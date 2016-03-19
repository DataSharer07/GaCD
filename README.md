# Assignment: Getting and Cleaning Data Course Project 3/19/2016

The data used for this assignment comes from data collected from the accelerometers from the Samsung Galaxy S smartphone. The data is downloaded from

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

A full description of the study is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones


The objectives of this assignment were to submit a script called run_analysis.R that does the following with the downloaded data.

* Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement.
* Uses descriptive activity names to name the activities in the data set
* Appropriately labels the data set with descriptive variable names.
* From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


The provided dataset in this repository includes the following files:

* The ReadMe.md file
* A script called run_analysis.R for performing the analysis
* A code book that describes the variables, the data, and any transformations or work that I performed to clean up the data called CodeBook.md
* A cleaned data set with means and standard deviations  with descriptive variable names called CleanedSmartphoneData.txt
* A tidy data set with means of each variable from the cleaned data set for each activity and each subject called: TidySmartphoneDataMeans.txt

