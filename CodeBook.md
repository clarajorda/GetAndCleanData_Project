## Getting and Cleaning Data Course Project

Steps:

1. Download the zip file with all the txt files and unzip it under the folder "Curso-CleaningData-Coursera"

2. Set the working directory to the unziped folder with the data

	   setwd("/home/jorda/Escritorio/Curso-CleaningData-Coursera/UCI HAR Dataset/")

3. Merges the training and the test sets to create one data set. For this, we store as a dataframe each of the X,Y and train, test files:

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

4. Extracts only the measurements on the mean and standard deviation for each measurement. 

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

5. Appropriately labels the data set with descriptive variable names.

Set names to column variables: take the first 561 names from the 'variables' vector, set by hand the 562th name to "Activity"

    names(my_dataset) <- c( variables[positions,2][1:(length(positions)-1)], "Activity")

Now set descriptive activity names to the dataset. First, extract the activites names from activity_labels.txt

    activities <- read.table("/home/jorda/Escritorio/Curso-CleaningData-Coursera/UCI HAR Dataset/activity_labels.txt", stringsAsFactors=FALSE)


Second, replace the number in the Activity column from 'my_dataset' to the corresponding activity label from the 'activities' table

    my_dataset$Activity <- activities[my_dataset[,"Activity"],2]


6. From this data set, creates a table, independent tidy data set with the average of each variable for each activity and each subject.

       setwd("/home/jorda/Escritorio/Curso-CleaningData-Coursera/GetAndCleanData_Project/")
    
       clean_dataset <- aggregate(data=my_dataset, .~Activity, FUN=mean)
    
       write.table(clean_dataset, row.names=FALSE,file="Project_output.txt")

