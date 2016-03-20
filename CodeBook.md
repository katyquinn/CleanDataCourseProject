# Data Science Specialization
# Getting and Cleaning Data - Course Project
## Katherine Quinn, March 2016

## URL of project instructions:

https://www.coursera.org/learn/data-cleaning/peer/FIZtT/getting-and-cleaning-data-course-project

## Description of raw data:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## Raw data archive zip file:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## Raw data files we use:

* 'features.txt': List of all feature labels and ID numbers.
* 'activity_labels.txt': List of activity labels and ID numbers.
* 'test/X_test.txt': Test data set, each column is a feature listed in features.txt, same order.
* 'test/y_test.txt': Test activity ID numbers.
* 'test/subject_test.txt': Test subject ID numbers.
* 'train/X_train.txt': Training data set, each column is a feature listed in features.txt, same order.
* 'train/y_train.txt': Training activity ID numbers.
* 'train/subject_train.txt': Training subject ID numbers.

## Analysis steps (as run by run_analysis.R):

* Loaded the raw data in the test/ and train/ subdirectories
* Extracted only the columns in X_test.txt and X_train.txt that contain mean and standard deviation for each feature
* Created test and training datasets with the activity IDs, subject IDs, and feature data merged together
* Joined the test and training datasets
* Created a summary dataset with averages of the feature means and standard deviations, grouped by activity and subject

## Summary data file (data_averages.txt):
* size: 180 rows by 68 columns
* columns:
+ Activity - 6 types (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)
+ SubjectID - range 1 to 30
+ 66 columns of averages of feature means and standard deviations - note that features are normalized and bounded within [-1,1]

## Read command in R for summary data file:
data_averages <- read.table("data_averages.txt",header=TRUE,check.names=FALSE,as.is=TRUE)
