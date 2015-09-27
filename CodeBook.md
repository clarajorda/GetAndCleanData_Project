## Getting and Cleaning Data Course Project

Steps:

* Download the zip file with all the txt files and unzip it under the folder "Curso-CleaningData-Coursera"

* Set the working directory to the unziped folder with the data:
    
        setwd("/home/jorda/Escritorio/Curso-CleaningData-Coursera/UCI HAR Dataset/")

* Merges the training and the test sets to create one data set. For this, we store as a dataframe each of the X,Y and train, test files:

        train_x <- read.table("/home/jorda/Escritorio/Curso-CleaningData-Coursera/UCI HAR Dataset/train//X_train.txt", sep="", header=FALSE)
        test_x  <- read.table("/home/jorda/Escritorio/Curso-CleaningData-Coursera/UCI HAR Dataset/test//X_test.txt"  , sep="", header=FALSE)
	    train_y <- read.table("/home/jorda/Escritorio/Curso-CleaningData-Coursera/UCI HAR Dataset/train//y_train.txt", sep="", header=FALSE)
        test_y  <- read.table("/home/jorda/Escritorio/Curso-CleaningData-Coursera/UCI HAR Dataset/test//y_test.txt"  , sep="", header=FALSE)

In each of them there are 7352 observables: 
- for the 'X' files, there are 561 variables, defined in the txt file features.txt
- for the 'Y' files, there is 1 variable, defined in the txt file activity_labels.txt

Once we have the separated data frames, we merge all the data (X,Y) for both the train and test datasets, using a simple cbind function:

    total_train <- cbind(train_x, train_y)
    total_test  <- cbind(test_x , test_y)

Now that both datasets have the same format, we can merge the Train and Test

    total <- rbind(total_train, total_test)

* Extracts only the measurements on the mean and standard deviation for each measurement. 

The file features.txt describes each variable. From there, we know that the mean and standard deviation for each measurement are the variables number 
We read the variables names from the txt: 

    variables <- read.table("/home/jorda/Escritorio/Curso-CleaningData-Coursera/UCI HAR Dataset/features.txt", stringsAsFactors=FALSE)

We obtain the positions of the variables with a 'mean()' or 'std()' observable:

    positions_mean <- grep(pattern="mean\\(\\)", x=variables$V2, value=FALSE)
    positions_std  <- grep(pattern="std\\(\\)" , x=variables$V2, value=FALSE)

Obtain a final vector with all the positions of the mean and std observables, add by hand the 562 position for the "Activity"

    positions <- c(positions_mean, positions_std, 562)

Subset from the total dataset those observables: 

    my_dataset <- total[, positions]

* Appropriately labels the data set with descriptive variable names.

Set names to column variables: take the first 561 names from the 'variables' vector, set by hand the 562th name to "Activity"

    names(my_dataset) <- c( variables[positions,2][1:(length(positions)-1)], "Activity")

Now set descriptive activity names to the dataset. First, extract the activites names from activity_labels.txt

    activities <- read.table("/home/jorda/Escritorio/Curso-CleaningData-Coursera/UCI HAR Dataset/activity_labels.txt", stringsAsFactors=FALSE)


Second, replace the number in the Activity column from 'my_dataset' to the corresponding activity label from the 'activities' table

    my_dataset$Activity <- activities[my_dataset[,"Activity"],2]


The final set of stored variables (as columns) are:

"Activity" "tBodyAcc-mean()-X" "tBodyAcc-mean()-Y" "tBodyAcc-mean()-Z" "tGravityAcc-mean()-X" "tGravityAcc-mean()-Y" "tGravityAcc-mean()-Z" "tBodyAccJerk-mean()-X" "tBodyAccJerk-mean()-Y" "tBodyAccJerk-mean()-Z" "tBodyGyro-mean()-X" "tBodyGyro-mean()-Y" "tBodyGyro-mean()-Z" "tBodyGyroJerk-mean()-X" "tBodyGyroJerk-mean()-Y" "tBodyGyroJerk-mean()-Z" "tBodyAccMag-mean()" "tGravityAccMag-mean()" "tBodyAccJerkMag-mean()" "tBodyGyroMag-mean()" "tBodyGyroJerkMag-mean()" "fBodyAcc-mean()-X" "fBodyAcc-mean()-Y" "fBodyAcc-mean()-Z" "fBodyAccJerk-mean()-X" "fBodyAccJerk-mean()-Y" "fBodyAccJerk-mean()-Z" "fBodyGyro-mean()-X" "fBodyGyro-mean()-Y" "fBodyGyro-mean()-Z" "fBodyAccMag-mean()" "fBodyBodyAccJerkMag-mean()" "fBodyBodyGyroMag-mean()" "fBodyBodyGyroJerkMag-mean()" "tBodyAcc-std()-X" "tBodyAcc-std()-Y" "tBodyAcc-std()-Z" "tGravityAcc-std()-X" "tGravityAcc-std()-Y" "tGravityAcc-std()-Z" "tBodyAccJerk-std()-X" "tBodyAccJerk-std()-Y" "tBodyAccJerk-std()-Z" "tBodyGyro-std()-X" "tBodyGyro-std()-Y" "tBodyGyro-std()-Z" "tBodyGyroJerk-std()-X" "tBodyGyroJerk-std()-Y" "tBodyGyroJerk-std()-Z" "tBodyAccMag-std()" "tGravityAccMag-std()" "tBodyAccJerkMag-std()" "tBodyGyroMag-std()" "tBodyGyroJerkMag-std()" "fBodyAcc-std()-X" "fBodyAcc-std()-Y" "fBodyAcc-std()-Z" "fBodyAccJerk-std()-X" "fBodyAccJerk-std()-Y" "fBodyAccJerk-std()-Z" "fBodyGyro-std()-X" "fBodyGyro-std()-Y" "fBodyGyro-std()-Z" "fBodyAccMag-std()" "fBodyBodyAccJerkMag-std()" "fBodyBodyGyroMag-std()" "fBodyBodyGyroJerkMag-std()"

where: 

- Activity refers to the type of activity carried out by the subject. It can be either of these: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING
- tBodyAcc-mean()-X (Y or Z): mean body acceleration of x, y and z coordinates
- tBodyAcc-std()-X (Y or Z): standard deviation of the body acceleration for x, y and z coordinates
- tGravityAcc-mean()-X (Y or Z): mean gravity acceleration of x, y and z coordinates
- tGravityAcc-std()-X (Y or Z): standard deviation of the gravity acceleration for x, y and z coordinates
- tBodyAccJerk-mean()-X (Y or Z): mean of body linear acceleration in time for x, y and z coordinates
- tBodyAccJerk-std()-X (Y or Z): standard deviation of body linear acceleration in time acceleration for x, y and z coordinates
- tBodyGyro-mean()-X (Y or Z): mean of body angular velocity for x, y and z coordinates
- tBodyGyro-std()-X (Y or Z): standard deviation of body angular velocity for x, y and z coordinates
- tBodyGyroJerk-mean()-X (Y or Z): mean of body angular velocity in time for x, y and z coordinates
- tBodyGyroJerk-std()-X (Y or Z): standard deviation of body angular velocity in time for x, y and z coordinates
- tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag - mean() or std(): the magnitude of these three-dimensional signals calculated using the Euclidean norm

* From this data set, creates a table, independent tidy data set with the average of each variable for each activity and each subject.

        setwd("/home/jorda/Escritorio/Curso-CleaningData-Coursera/GetAndCleanData_Project/")
    
        clean_dataset <- aggregate(data=my_dataset, .~Activity, FUN=mean)
    
        write.table(clean_dataset, row.names=FALSE,file="Project_output.txt")

