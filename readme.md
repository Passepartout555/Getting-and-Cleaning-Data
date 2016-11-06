# README
## Documentation of the data processing with run_analysis.R script

### Data Source
The data comes from Human Activity Recognition Using Smartphones Dataset, Version 1.0 and is example data for the Coursera Getting and Cleaning Data Course Project.

### Phase 1: Merge
Merge training and test sets to create one data set.
Training and Test each are made up of three different files:

* subject_train.txt	: The number of the person for the observation 1-30
* X_train.txt: The actual data of the training set
* y_train.txt: Activity labels of the training set 1-6  

* subject_test.txt: The number of the person for the observation 1-30
* X_test.txt: The actual data of the test set
* y_test.txt: Labels of the test set 1-6

To start with we product three different data structures
* a. A vector of the subjects (people) observed from test and data sets
* b. A matrix of the data collections for test and training combined
* c. A vector of the activity labels

Produce out of this a data frame as follows:  
* Column 1: People   
* Column 2: Activity  
* Column 3 to n: Measured data  


### Phase 2: Extract: 
Extract the measurements on the mean and standard deviation for each measurement.
Given 561 observations with different names we extract here the columns that have in the name 
the string "mean()" or "std()" assuming that is the data to be abstracted
Note the occurence of the words "mean" and "std" without "()" after it in other column names
We select columns along a binary vector where search strings criteria are met.

  
  
The process by now got the raw measurement data columns, but no additional information, combine people and actities back to the data to make something senseful and complete. That means adding the people and what they did to the data again.
  
  

### Phase 3: Descriptions
Add descriptive activity names to name the activities in the data set

The original UCI codebook uses six numbers or states from 1 to 6 with the following meaning: 
 
* 1 WALKING
* 2 WALKING_UPSTAIRS
* 3 WALKING_DOWNSTAIRS
* 4 SITTING
* 5 STANDING
* 6 LAYING

We pick up the wording and transform into factors with appropriate labels.


### Phase 4: Labeling
Appropriately labeling the data set with descriptive variable names.
  
It was more handy to produce approproate labels before building the data structure. The columns are labeled close to the UCI codebook.


### Phase 5: Tidy data set
Create second copy of TIDY data set with 
the average of each variable for each activity and each subject in it

 Met the data down and build the groupings as described for the course. Export the data as CSV file (could technically also be TXT, use CSV here because seems more appropriate for the kind of data.)