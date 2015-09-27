# GetAndCleanData_Project
Course Project for Getting and Cleaning Data

Code to prepare, clean and tidy data from the wepage http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones, which studies the human activity recognition using data recolected by smartphones.

* All the code is under a unique R script run_analysis.R

* This script does the following:

 -- Merges the training and the test sets to create one data set.
 -- Extracts only the measurements on the mean and standard deviation for each measurement. 
 -- Uses descriptive activity names to name the activities in the data set
 -- Appropriately labels the data set with descriptive variable names. 
 -- From the data set obtained, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

* With this single script, we are able to directly obtain an average of the relevant mean and std variables for each of the studied activities. 

* The final table is stored in the txt file: Project_output.txt

* More information can be found in the Code Book: CodeBook.md




