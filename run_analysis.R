REading in the data
========================================================
  #Get and scope out variable name list of the data. Result is 561 variable names.
  ```{r}
colfeature<-read.table("./UCI HAR Dataset/features.txt", colClasses="character")
dim(colfeature)
head(colfeature)
tail(colfeature)
```


#check out how many contain the letter string "mean" and "std".  Then look at greps of accelerometer and gyroscope, acc and gyro.   So lets look at how the word mean is distributed.  Then std. See comment below. Then acc and gyro: only 3 variable names out of the 561 aren't referencing either Accelerometer or gyroscope although, "gravity" is accelerometer data according to the read.me.
```{r}
dim(colfeature[grepl("mean",colfeature$V2),])
dim(colfeature[grepl("[Mm]ean",colfeature$V2),])# 53 variable names
dim(colfeature[grepl("mean",colfeature$V2, fixed=TRUE),])# 46 if you don't include capitalized
dim(colfeature[grepl("-mean()",colfeature$V2, fixed=TRUE),])# 33 with a trailing paraenthesis
dim(colfeature[grepl("-mean()-",colfeature$V2, fixed=TRUE),])# 24 with a trailing paraenthesis and -
dim(colfeature[grepl("std",colfeature$V2),])# 33 variable names
dim(colfeature[grepl("std",colfeature$V2,fixed=TRUE),])#note that std is unique and not part of another string

dim(colfeature[grepl("Gyro",colfeature$V2),])
dim(colfeature[grepl("Acc",colfeature$V2),])
dim(colfeature[grepl("Acc|Gyro", colfeature$V2),])
colfeature[grep("Acc|Gyro", colfeature$V2, invert=TRUE),]# 3 variables
```


#untidy names.  lets get rid of some unneeded key strokes. First capitalization. Then dashes. then ()
```{r}
colfeaturelow<-tolower(colfeature$V2) #lowercase
colfeat_clean1<-gsub("-", "", colfeaturelow,fixed=TRUE)#dashes
clean2<-gsub("()","_", colfeat_clean1, fixed=TRUE)#() replace with _ otherwise x,y,z becomes confusing.
cleaned<-gsub("bodybody","body",clean2)# fix body double
cleanfeature<-cbind(colfeature,cleaned)
cleanfeature
```

#start the subsetting.  While convenient to limit the size of the data, it doesn't seem like I have any reason not to include the full 46 means and 33 stds. There is data that will be lost.  I'll do the subset against cleaned

```{r}
dim(cleanfeature[grepl("std|mean", cleanfeature$cleaned),])
Cc<-(cleanfeature[grepl("std|mean", cleanfeature$cleaned),])
dim(Cc)
str(Cc)
var_numgood<-list(as.integer(Cc$V1))
numlist<-toString(var_numgood)
numlist # there must be a pretty way to do this but it does the job. Clip and paste result
name1<-as.vector(as.character(Cc$cleaned))
name1
```

# subsetting of the training data and test data.Take a quick look at X_train and y_train and subject_train.txt  Lets start with the training set which is bigger. 
```{r}
trainX=(head(read.table("./UCI HAR Dataset/train/X_train.txt"),nrows=10))
trainy=(head(read.table("./UCI HAR Dataset/train/y_train.txt"),nrows=10))
subjectid=read.table("./UCI HAR Dataset/train/subject_train.txt", nrows=10)
trainX #shows all 561 variables without descriptive names
trainy # basically an index to activity name
subjectid #basically an index to training subjects
```


#Our subsetting names and column numbers were created before as names1 and numlist.  These are clipped and paste to subset and colname could just be the vector.
```{r}
numlist
training=(read.table("./UCI HAR Dataset/train/X_train.txt", colClasses="numeric"))
dim(training)
train<-training[,c(1, 2, 3, 4, 5, 6, 41, 42, 43, 44, 45, 46, 81, 82, 83, 84, 85, 86, 121, 122, 123, 124, 125, 126, 161, 162, 163, 164, 165, 166, 201, 202, 214, 215, 227, 228, 240, 241, 253, 254, 266, 267, 268, 269, 270, 271, 294, 295, 296, 345, 346, 347, 348, 349, 350, 373, 374, 375, 424, 425, 426, 427, 428, 429, 452, 453, 454, 503, 504, 513, 516, 517, 526, 529, 530, 539, 542, 543, 552, 555, 556, 557, 558, 559, 560, 561)]#there has to be a better way to do this.  Peer reviewers please make your suggestions.
dim(train)#7352 by 86
name1
colnames(train)<-name1
head(train)
dim(train)
```


#now the test set.
```{r}
testing=(read.table("./UCI HAR Dataset/test/X_test.txt", colClasses="numeric"))
dim(testing) #561X 2947
test<-testing[,c(1, 2, 3, 4, 5, 6, 41, 42, 43, 44, 45, 46, 81, 82, 83, 84, 85, 86, 121, 122, 123, 124, 125, 126, 161, 162, 163, 164, 165, 166, 201, 202, 214, 215, 227, 228, 240, 241, 253, 254, 266, 267, 268, 269, 270, 271, 294, 295, 296, 345, 346, 347, 348, 349, 350, 373, 374, 375, 424, 425, 426, 427, 428, 429, 452, 453, 454, 503, 504, 513, 516, 517, 526, 529, 530, 539, 542, 543, 552, 555, 556, 557, 558, 559, 560, 561)]
dim(test)#2947X86
name1
colnames(test)<-name1
head(test)
dim(test)
```


# Now the acivity names for each. Leaving them all caps as there are so few.
#First the training data. The activities are:  
```{r}
activityname<-read.table("./UCI HAR Dataset/activity_labels.txt")
activityname
str(activityname)#don't be fooled they come out in alphabetical order.
activity<-read.table("./UCI HAR Dataset/train/y_train.txt")#list of 7352 subject activities
dim(activity)
activity$V1<-as.factor(activity$V1) #need to make it into factor
levels(activity$V1)[4]="WALKING" # note alphabetical
levels(activity$V1)[6]="WALKING_UPSTAIRS"
levels(activity$V1)[5]="WALKING_DOWNSTAIRS"
levels(activity$V1)[2]="SITTING"
levels(activity$V1)[3]="STANDING"
levels(activity$V1)[1]="LAYING"
colnames(activitytest)<-"activity"
```


# Then the test data
```{r}
activitytest<-read.table("./UCI HAR Dataset/test/y_test.txt")
activitytest$V1<-as.factor(activitytest$V1) #need to make it into factor
levels(activitytest$V1)[4]="WALKING" # note alphabetical
levels(activitytest$V1)[6]="WALKING_UPSTAIRS"
levels(activitytest$V1)[5]="WALKING_DOWNSTAIRS"
levels(activitytest$V1)[2]="SITTING"
levels(activitytest$V1)[3]="STANDING"
levels(activitytest$V1)[1]="LAYING"
colnames(activitytest)<-"activity"
```

#add subjects training first
```{r}
mysubjects<-read.table("./UCI HAR Dataset/train/subject_train.txt", colClasses="character")
dim(mysubjects)
str(mysubjects)
```

#then test set
```{r}
mytestsubjects<-read.table("./UCI HAR Dataset/test/subject_test.txt", colClasses="character")
dim(mytestsubjects)
str(mytestsubjects)
```


#cbind subjects to train and test.  Added distinction between test and training observation type.
```{r}
dim(mysubjects)
dim(train)
dim(activity)
mytrain<-cbind(mysubjects, activity, train)
dim(mytestsubjects)
dim(activitytest)
dim(test)
obstype<-as.vector(rep("test",2947))
mytest<-cbind(obstype,mytestsubjects,activitytest, test)
names(mytest)
names(mytest)[2]<-"subjectid"

```
# return and fix mytrain
```{r}
names(mytrain)[1]<-"subjectid"
names(mytrain)
head(mytrain)
obstype2<-as.vector(rep("train",7352))
length(obstype2)
mytrain<-cbind(obstype2,mytrain)
names(mytrain)[1]<-"obstype"
names(mytrain)
```


# Rowbind as factor
```{r}
wearable1<-rbind(mytest,mytrain)
str(wearable1)
wearable1$subjectid<-as.factor(wearable1$subjectid)
dim(wearable1)#10299 X 89
#archive
write.table(wearable1,"wearable.txt",col.names=TRUE)
```
# create tidy set for submission to Coursera
```{r}
require(plyr)
require(dplyr)
require(reshape2)
names(wearable1)
wearmelt<-melt(wearable1, id.var=c("subjectid","activity","obstype"))
dim(wearmelt)
head(wearmelt)
wearablegroups<-group_by(wearmelt, variable, subjectid, activity)
dim(wearablegroups)#once melted and grouped the dimensins 885715X5 - long format
tidywearable<-summarize(wearablegroups, avevarbysubj_activity=round(mean(value),3))
dim(tidywearable)#once summarized tidy set is 15480 x 4
tidywearable
names(tidywearable)
hist(tidywearable$avevarbysubj_activity,breaks=50)#just for fun a histogram.

#instructions:Creates a second, independent tidy data set with the average of each variable for each activity and each subject. This implies the order of variable, subjectid, activity and mean value.
write.table(tidywearable,"tidywearable.txt")
dim(tidywearable)

```