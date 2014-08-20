Reading in the data
#https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
#note since I use a windows 7 machine nothing special needs to happen to open the #zips.  
#Comments have been minimized for convenience of peer reviewer see codebook
#and read.me for added explaination.  
#Note1 : data directory structure is likely the same as what you used in your project 
# rather moving all of the data files your working directory.
#Note2: if you have updated R to the most recent version you may have to 
#reinstall or update some of the packages called here.
========================================================
  
#the training and test sets are combined creating a data.frame  
#with the dimensions 10299 X 561.  The steps are  
#1. Rbind the following data files together.
#  a. Xtrain and Xtest into a 10299 X 561 data.frame with the data and observations
#  b. y_train and y_test into a 10299 X 1 data.frame of raw activity codes  
#  c. subject_test and subjecttrain into a 10299 X 1 data.frame of subject ids  
#  d. cbind the data.frames (a,b,c) together.  
#  e. apply activity names to activity codes as factors
 
  
  
trainXall=read.table("./UCI HAR Dataset/train/X_train.txt", colClasses="numeric")
testXall=read.table("./UCI HAR Dataset/test/X_test.txt",colClasses="numeric")
rawdata<-rbind(trainXall, testXall)
trainyall=read.table("./UCI HAR Dataset/train/y_train.txt", colClasses="numeric")
testyall=read.table("./UCI HAR Dataset/test/y_test.txt",colClasses="numeric")
act1<-rbind(trainyall, testyall)
subjectidtrain=read.table("./UCI HAR Dataset/train/subject_train.txt")
subjectidtest=read.table("./UCI HAR Dataset/test/subject_test.txt")
subj_id=rbind(subjectidtrain, subjectidtest)
colnames(act1)="activity"
colnames(subj_id)="subject"
complete_rawdata<-cbind(rawdata, subj_id, act1) #preserves the order for subsequent subsetting.
activityname<-read.table("./UCI HAR Dataset/activity_labels.txt")
complete_rawdata$activity<-factor(complete_rawdata$activity,levels=activityname$V1, labels=activityname$V2 )

dim(complete_rawdata)
#Gets the variable name list of the data. Result is 561 variable names.  
#Subset the activity data to only include "mean()" and "std()" columns as that is one reasonable interpretation of the instructions.  This results in 66 columns
colfeature<-read.table("./UCI HAR Dataset/features.txt", colClasses="character")
names(colfeature)<-c("featureid","featurename")
nameset <- colfeature[grepl("-mean\\(\\)|-std\\(\\)", colfeature$featurename),] 


#subset the data on these columns,
refined_rawdata<-complete_rawdata[,c(562,563,as.numeric(nameset$featureid))] #this also reorders data. 562 is "subject" number; 531 is factor "activity" 

#Feature names are untidy need clarification. This sequence of 14 steps to clean the names.
#This creates names with major idendifiers separated by "." , less common
#identifiers written out and dashes and parens eliminated.
nameset1<-gsub("BodyBody" ,"Body", nameset$featurename)#second body is assumed a typo.
nameset2<-gsub("^t", "t.", nameset1)
nameset3<-gsub("^f", "f.", nameset2)
nameset4<-gsub("Acc", ".Acc.", nameset3)  
nameset5<-gsub("Gyro", ".Gyro.", nameset4)
nameset6<-gsub("Mag", "Magnitude.", nameset5)
nameset7<-gsub("-", "", nameset6)
nameset8<-gsub("X",".X", nameset7)
nameset9<-gsub("Y",".Y", nameset8)
nameset10<-gsub("Z",".Z", nameset9)
nameset11<-gsub("*[Ss]td\\(\\)", "Std", nameset10)
nameset12<-gsub("*[Mm]ean\\(\\)*", "Mean", nameset11)
nameset13<-gsub("Jerk", "Jerk.", nameset12)
namesetfinal<-tolower(nameset13)


#apply column names to refined data.
names(refined_rawdata)<-c("subject","activity",namesetfinal)
activitymonitor<-refined_rawdata # add better data.table name

#archive file as wearable.txt
#write.table(activitymonitor,"activitymonitor.txt",col.names=TRUE, row.names=FALSE)


# create a second tidy set for submission to Coursera with the average of #each variable for each activity and each subject. 
require(plyr)
require(dplyr) 
require(reshape2)
actmonitor<-melt(activitymonitor, id.var=c("subject","activity"))
# this creates the long format from the wide.
monitorgroups<-group_by(actmonitor, variable, subject, activity)
#once melted and grouped the dimensins 679734X4 - long format
#instructions:Creates a second, independent tidy data set with the average of each variable for each activity and each subject. This implies the order of variable, subjectid, activity and mean value.
tidyactivitymonitor<-summarize(monitorgroups, average.measure.by.subjects.activity=round(mean(value),4))
# 11880X4
# write.table(tidyactivitymonitor,"tidyactivitymonitor.txt",row.names=FALSE)# without the row.names false argument, the text file columns don't line up right.
#Example mean data for WALKING measure for first subject  
a<-subset(tidyactivitymonitor,tidyactivitymonitor[,2]==1 & tidyactivitymonitor[,3]=="WALKING")
a
