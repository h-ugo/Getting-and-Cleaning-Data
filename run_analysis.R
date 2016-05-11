# script for Getting and Clanaing Data assigment
#part 0

if(!file.exists("data")){dir.create("data")}      #create data folder if it does not exist
url="https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url,"./data/dataset.zip")
unzip("./data/dataset.zip",exdir="./data")

#part 1
xtrain<-read.table("./data/UCI HAR Dataset/train/X_train.txt")
xtest<-read.table("./data/UCI HAR Dataset/test/X_test.txt")
ytrain<-read.table("./data/UCI HAR Dataset/train/y_train.txt")
ytest<-read.table("./data/UCI HAR Dataset/test/y_test.txt")
subjecttrain<-read.table("./data/UCI HAR Dataset/train/subject_train.txt")
subjecttest<-read.table("./data/UCI HAR Dataset/test/subject_test.txt")
features<-read.table("./data/UCI HAR Dataset/features.txt")

colnames(xtrain)<-features[,2]
colnames(xtest)<-features[,2]
colnames(ytrain)<-"activity"
colnames(ytest)<-"activity"
colnames(subjecttrain)<-"subject"
colnames(subjecttest)<-"subject"
training<-cbind(ytrain,subjecttrain,xtrain)
test<-cbind(ytest,subjecttest,xtest)
alldata<-rbind(training,test)

#part 2

meansdcolumns<-grep("[Mm]ean\\(\\)|[Ss]td\\(\\)",names(alldata))
somedata<-alldata[,meansdcolumns]

#part 3 
activity_labels<-read.table("./data/UCI HAR Dataset/activity_labels.txt")
colnames(activity_labels)<-c("activity","activity_name")
newdata<-merge(activity_labels,alldata)

#part 4 
names(newdata)<-gsub("^t", "time", names(newdata))
names(newdata)<-gsub("^f", "frequency", names(newdata))
names(newdata)<-gsub("Acc", "Accelerometer", names(newdata))
names(newdata)<-gsub("Gyro", "Gyroscope", names(newdata))
names(newdata)<-gsub("Mag", "Magnitude", names(newdata))
names(newdata)<-gsub("BodyBody", "Body", names(newdata))

#part 5

library(data.table)
dt<-data.table(newdata)
tidydata<-dt[,lapply(.SD,mean),by='subject,activity_name']
write.table(tidydata,file="./data/tidydata.txt")




