# Data Science Specialization
# Getting and Cleaning Data Course Project
# K.Quinn, March 2016

# Instructions for project:
# https://www.coursera.org/learn/data-cleaning/peer/FIZtT/getting-and-cleaning-data-course-project

# Data for the project:
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

# Create one R script called run_analysis.R that does the following:
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# load the dplyr and tidyr libraries
library(dplyr)
library(tidyr)

# Go to my local course directory
setwd("/Users/Katy/Desktop/Coursera/DataSci/CleanData")

# Download and read in data
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL,"CleanData_Dataset.zip",method="curl")
filelist <- unzip("CleanData_Dataset.zip",list=TRUE)
unzip("CleanData_Dataset.zip")

# data directory
ddir <- "UCI HAR Dataset/"

# load label information
activity_labels <- read.table(paste0(ddir,"activity_labels.txt"),
                              col.names = c("AID","Aname"),as.is=TRUE)
feature_labels <- read.table(paste0(ddir,"features.txt"),
                              col.names = c("FID","Fname"),as.is=TRUE)

# find feature indices with mean and std
meanCols <- grep("-mean()",feature_labels$Fname,fixed=TRUE)
stdCols <- grep("-std()",feature_labels$Fname,fixed=TRUE)
keepCols <- sort(c(meanCols,stdCols))

# load test data
subject_test <- tbl_df(read.table(paste0(ddir,"test/subject_test.txt"),col.names = "SID"))
activity_test <- tbl_df(read.table(paste0(ddir,"test/y_test.txt"),col.names = "AID"))
activity_test <- left_join(activity_test,activity_labels,by="AID")
data_test <- tbl_df(read.table(paste0(ddir,"test/X_test.txt"),col.names = paste0("FID_",feature_labels$FID)))
data_test <- data_test[keepCols] # only keep mean and std variables
data_test <- bind_cols(subject_test,activity_test,data_test)

# load training data
subject_train <- tbl_df(read.table(paste0(ddir,"train/subject_train.txt"),col.names = "SID"))
activity_train <- tbl_df(read.table(paste0(ddir,"train/y_train.txt"),col.names = "AID"))
activity_train <- left_join(activity_train,activity_labels,by="AID")
data_train <- tbl_df(read.table(paste0(ddir,"train/X_train.txt"),col.names = paste0("FID_",feature_labels$FID)))
data_train <- data_train[keepCols] # only keep mean and std variables
data_train <- bind_cols(subject_train,activity_train,data_train)

# merge test and training data
data_all <- bind_rows(data_test,data_train)

# find averages of features by activity and by subject
data_averages <- data_all %>% group_by(Aname,SID) %>%
    summarize_each(funs(mean),matches("FID"))

# give more descriptive column names
featureCols <- feature_labels$Fname[keepCols]
colnames(data_averages) <- c("Activity","SubjectID",featureCols)

# output data_averages to data_averages.txt
write.table(data_averages,"data_averages.txt",row.names=FALSE,col.names=TRUE)

# To read back in the data averages, use this command:
# data_averages <- read.table("data_averages.txt",header=TRUE,check.names=FALSE,as.is=TRUE)
