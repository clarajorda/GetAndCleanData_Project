## STEPS
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# Set the working directory to the unziped folder with the data
setwd("/home/jorda/Escritorio/Curso-CleaningData-Coursera/UCI HAR Dataset/")

### --- 1. Merges the training and the test sets to create one data set.

# Read the files separately

# In each there are 7352 observables
# -- For the 'X' files, there are 561 variables, defined in the txt file features.txt
# -- For the 'Y' files, there is 1 variable, defined in the txt file activity_labels.txt
train_x <- read.table("/home/jorda/Escritorio/Curso-CleaningData-Coursera/UCI HAR Dataset/train//X_train.txt", sep="", header=FALSE)
test_x  <- read.table("/home/jorda/Escritorio/Curso-CleaningData-Coursera/UCI HAR Dataset/test//X_test.txt"  , sep="", header=FALSE)

train_y <- read.table("/home/jorda/Escritorio/Curso-CleaningData-Coursera/UCI HAR Dataset/train//y_train.txt", sep="", header=FALSE)
test_y  <- read.table("/home/jorda/Escritorio/Curso-CleaningData-Coursera/UCI HAR Dataset/test//y_test.txt"  , sep="", header=FALSE)

# Merge all the data (X,Y) for both the train and test datasets
total_train <- cbind(train_x, train_y)
total_test  <- cbind(test_x , test_y)

# Now that both datasets have the same format, we can merge the Train and Test
total <- rbind(total_train, total_test)

### --- 2. Extracts only the measurements on the mean and standard deviation for each measurement. 

# The file features.txt describes each variable. From there, we know that the mean and standard deviation for each 
# measurement are the variables number 

# We read the variables names from the txt:
variables <- read.table("/home/jorda/Escritorio/Curso-CleaningData-Coursera/UCI HAR Dataset/features.txt", stringsAsFactors=FALSE)

# We obtain the positions of the variables with a 'mean()' or 'std()' observable:
positions_mean <- grep(pattern="mean\\(\\)", x=variables$V2, value=FALSE)
positions_std  <- grep(pattern="std\\(\\)" , x=variables$V2, value=FALSE)

# Obtain a final vector with all the positions of the mean and std observables, add by hand the 562 position for the "Activity"
positions <- c(positions_mean, positions_std, 562)

# Subset from the total dataset those observables: 
my_dataset <- total[, positions]

### --- 3. Uses descriptive activity names to name the activities in the data set
### --- 4. Appropriately labels the data set with descriptive variable names.

# Set names to column variables: take the first 561 names from the 'variables' vector, set by hand the 562th name to "Activity"
names(my_dataset) <- c( variables[positions,2][1:(length(positions)-1)], "Activity")

# Now set descriptive activity names to the dataset (as required in point 3)
# First, extract the activites names from activity_labels.txt
activities <- read.table("/home/jorda/Escritorio/Curso-CleaningData-Coursera/UCI HAR Dataset/activity_labels.txt", stringsAsFactors=FALSE)

# Second, replace the number in the Activity column from 'my_dataset' to the corresponding activity label from the 'activities' table
my_dataset$Activity <- activities[my_dataset[,"Activity"],2]

### ---5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

setwd("/home/jorda/Escritorio/Curso-CleaningData-Coursera/GetAndCleanData_Project/")
clean_dataset <- aggregate(data=my_dataset, .~Activity, FUN=mean)
write.table(clean_dataset, row.names=FALSE,file="Project_output.txt")


