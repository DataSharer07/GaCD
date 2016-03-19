run_analysis<- function(){
  #Install and load required packages
  require("dplyr")
  require("data.table")
  library(dplyr)
  library(data.table)
#Step 1 Merge the training and the test sets to create one data set
  if(!file.exists("./Assignment")){ #Create a data folder if it does not exist yet 
    dir.create("./Assignment")

    
  }
  if(!file.exists("./Assignment/accelerometers.zip")){
  fileURL<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL,destfile="./Assignment/accelerometers.zip")#,method="curl")  #for Mac  
  }
unzip(zipfile="./Assignment/accelerometers.zip",exdir = "./Assignment") #unzip the data and put the unzipped data inside the "data" folder
unzippedfolderpath <- file.path("./Assignment" , "UCI HAR Dataset") #Create folder path where the data is located
#Pull feature data from both folders and merge
Features<- rbind(read.table(file.path(unzippedfolderpath, "train","X_train.txt"),header=FALSE), read.table(file.path(unzippedfolderpath, "test","X_test.txt"),header=FALSE))  
#pull feature name values
FeatureNames<-read.table(file.path(unzippedfolderpath, "features.txt"),head=FALSE)
#assign feature name values
names(Features)<-FeatureNames$V2
#Pull Subject data from both folders and merge
Subject <- rbind(read.table(file.path(unzippedfolderpath, "train","subject_train.txt"),header=FALSE), read.table(file.path(unzippedfolderpath, "test","subject_test.txt"),header=FALSE))  
#insert Subject header label
names(Subject)<-c("subject")
#Pull Activity data from both folders and merge
Activity<- rbind(read.table(file.path(unzippedfolderpath, "train","y_train.txt"),header=FALSE), read.table(file.path(unzippedfolderpath, "test","y_test.txt"),header=FALSE))  
#insert Activity header label
names(Activity)<- c("activity")
#Merge Subject and Activity Table
Merge1 <- cbind(Subject,Activity)
#Merge feature table with merged subject and activity table
Merge2 <- cbind( Merge1,Features)
#write.csv(Merge2,file="./Assignment/SmartphoneData.csv") #Just a test for me

#Step 2 Extract only the measurements on the mean and standard deviation for each measurement
neededColumns<-c(as.character(FeatureNames$V2[grep("mean\\(\\)|std\\(\\)",FeatureNames$V2)]),"subject","activity")#Find positions where text includes mean and std 
Merge2<-subset(Merge2,select=neededColumns)
#write.csv(Merge2,file="./Assignment/SmartphoneData2.csv")#Just a test for me

#Step 3 Use descriptive activity names to name the activities in the data set
activityNames<-read.table(file.path(unzippedfolderpath,"activity_labels.txt"),header=FALSE)#Pull activity names in table
Merge2$activity<-as.factor(Merge2$activity)
levels(Merge2$activity)<-activityNames$V2
#write.csv(Merge2,file="./Assignment/SmartphoneDataNames.csv")#Just a test for me

#Step 4 Appropriately label the data set with descriptive variable names
names(Merge2)<-gsub("^t", "Time", names(Merge2))
names(Merge2)<-gsub("mean\\()", "MeanValue", names(Merge2))
names(Merge2)<-gsub("std\\()", "StandardDeviation", names(Merge2))
names(Merge2)<-gsub("Acc", "Acceleration", names(Merge2))
names(Merge2)<-gsub("Gyro", "Gyroscope", names(Merge2))
names(Merge2)<-gsub("Mag", "Magnitude", names(Merge2))
names(Merge2)<-gsub("^f", "Frequency", names(Merge2))
#Move activity and subject in first 2 columns
setcolorder(Merge2, c("subject", setdiff(names(Merge2), "subject")))
setcolorder(Merge2, c("activity", setdiff(names(Merge2), "activity")))

#Save  clean data set
write.table(Merge2,file="./Assignment/CleanedSmartphoneData.txt",row.names=FALSE)

#Step 5 create a second, independent tidy data set with the average of each variable for each activity and each subject.
Tidy<-aggregate(. ~activity+subject,Merge2, mean)
Tidy<-Tidy[order(Tidy$activity,Tidy$subject),]
#Save tidy data set with means
write.table(Tidy,file="./Assignment/TidySmartphoneData.txt",row.names=FALSE)
}