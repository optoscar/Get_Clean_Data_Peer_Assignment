# Peer Assessments /Getting and Cleaning Data Project

The data represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here is the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

This repo contains a R script `run_analysis.R` which does the following: 

  1. Merges the training and the test sets to create one data set.
  2. Extracts only the measurements on the mean and standard deviation for each measurement. 
  3. Uses descriptive activity names to name the activities in the data set
  4. Appropriately labels the data set with descriptive activity names. 
  5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Running the script
The script assumes that the original data is uncompressed and placed in folder "UCI HAR Dataset" one level up the working directory ("../UCI HAR Dataset/").

The script can be running all "Ctrl-Alt-R" and it will generate two variables "data" and "tidy".
"data" dataframe contains the merged data as asked in task 1-4.
"tidy" dataframe contains the data set with the average of each variable for each activity and each subject, as asked in Task 5.
  
The following asumptions has been taken for each task:

## Task 1. Merges the training and the test sets to create one data set.
From reading the forums, I have decided to read the features calculated from the researchers, and do not try to recalculate them from the row data.

Features have been read from X_text.txt and X_train.txt.
Activities have been read from y_test.txt and y_train.txt.
Id of the participants have been read from subject_test.txt and subject_train.txt.

The data from subject, activity and features has been joined for test and train datasets, using cbind() function. Name has been added for all the columns.

After this, both dataset has been joined using rbind() functions.

## Task 2. Extracts only the measurements on the mean and standard deviation for each measurement.
In this task I have decided only to keep those features that have been calculated using mean() and std() features. 
It has been identified by the substrings "mean()" and "std()". 

## Task 3. Uses descriptive activity names to name the activities in the data set
I have decided to use the description obtained from the file "activity_labels.txt" as a descriptive names for the activies.

## Task 4. Appropriately labels the data set with descriptive activity names.
Column "activity" has been transformed as a factor, and labeled with the names obtained in task 3.

## Task 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
The dataset "data" obtained after task4 has been splited using the subjectid and the activity columns. 
After this, sapply() has been used to average the values of the 66 features selected in Task 2.
Several operations has been done to the resulting dataframe to improve readability.
The final dataframe "tidy" is writen in the hard disk as "tidy.txt".





  

