# run_analysis.R
## Based on Coursera "Getting and Cleaning Data Course" Assignment
## Details on where the data comes from and how it is processed: See separate README file

##########################################################################################
# Phase 1: Merge training and test sets to create one data set.
##########################################################################################
# Read People data, concatenate, add column name
PeopleTrainingDataSet <- read.table("subject_train.txt")
PeopleTestDataSet <- read.table("subject_test.txt")
PeopleData <- rbind(PeopleTrainingDataSet, PeopleTestDataSet)
names(PeopleData) <- "VolumteerNo"

# Read actual measurement data, concatenate, add column names
MeasurementTrainingData <- read.table("X_train.txt")
MeasurementTestData <- read.table("X_test.txt")
MeasurementData <- rbind(MeasurementTrainingData, MeasurementTestData)
MeasurementDataColumnNames <- read.table("features.txt")
names(MeasurementData) <- MeasurementDataColumnNames$V2

# Read the activities, concatenate, add column name
ActivitiesTrainingData <- read.table("y_train.txt")
ActivitiesTestData <- read.table("y_test.txt")
ActivitiesData <- rbind(ActivitiesTrainingData, ActivitiesTestData)
names(ActivitiesData) <- "Peoples_Activities"

# Fill everything into one data structure
UCI_HAR_DataSet <- cbind(PeopleData, ActivitiesData, MeasurementData)

# Data ready to be processed

##########################################################################################
# Phase 2: Extract: Measurements on the mean and standard deviation for each measurement.
##########################################################################################

# Given 561 observations with different names we extract here the colums that have in the name 
# the string "mean()" or "std()" assuming that is the data to be abstracted
# Note the occurence of the words "mean" and "std" without "()" after it in other column names
# So select columns along the binary vector where search strings are hit
SelectColumns <- grepl("mean\\(\\)", names(UCI_HAR_DataSet)) | grepl("std\\(\\)", names(UCI_HAR_DataSet))
UCI_HAR_DataSetMeansStd <- UCI_HAR_DataSet[, SelectColumns]

# Data, but no additional information, combine people and actities back to the data to make something senseful
UCI_HAR_DataSetMeansStd <- cbind(PeopleData, ActivitiesData, UCI_HAR_DataSetMeansStd) 

##########################################################################################
# Phase 3: Add descriptive activity names to name the activities in the data set
##########################################################################################

# The UCI codebook says: 1 WALKING, 2 WALKING_UPSTAIRS, 3 WALKING_DOWNSTAIRS, 4 SITTING, 5 STANDING, 6 LAYING
ActivityNames <- c("Walking", "Walking upstairs", "Walking downstairs", "Sitting", "Standing", "Laying")
# Data here still in integer, so convert to factors and label according to the UCI convention given
# UCI_HAR_DataSetMeansStd$ActivitiesData <- factor(UCI_HAR_DataSetMeansStd$ActivitiesData, levels=c(1,2,3,4,5,6), labels = ActivityNames)


##########################################################################################
# Phase 4: Appropriately labeling the data set with descriptive variable names.
##########################################################################################
# Already done in pre-processing phase

##########################################################################################
# Phase 5: Create second copy of TIDY data set with 
# the average of each variable for each activity and each subject in it
##########################################################################################
# We use reshape2 library to summarize the data
library(reshape2)

MeltDataDown <- melt(UCI_HAR_DataSetMeansStd, id=c("VolumteerNo","Peoples_Activities"))
UCI_TidyDataSet <- dcast(MeltDataDown, VolumteerNo+Peoples_Activities ~ variable, mean)

# Export the tidy data set as a CSV file to file system
write.csv(UCI_TidyDataSet, "UCI_TidyDataSet.csv")

# Export according to Coursera needs
write.table(UCI_TidyDataSet, file="UCI_TidyDataSet.txt", sep="\t", row.name=FALSE)
