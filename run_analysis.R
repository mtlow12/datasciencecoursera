#Unzip file and extract its contents
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
td <- tempdir()
tf <- tempfile(tmpdir = td, fileext=".zip")

#Download Zip File
download.file(fileURL, tf)

#Features
featuresfname <- unzip(tf, list=TRUE)$Name[2]
unzip(tf, files=featuresfname, exdir=td, overwrite=TRUE)
featuresfpath <- file.path(td, featuresfname)
featuresData <- read.table(featuresfpath, stringsAsFactors=FALSE)
featuresNames <- featuresData[,2]

#Features2
featuresNames2 <- read.table("features2.txt", stringsAsFactors=FALSE)
featuresNames2 <- featuresNames2[,1]

#Unzip Test file
testfname <- unzip(tf, list=TRUE)$Name[17]
unzip(tf, files=testfname, exdir=td, overwrite=TRUE)
testfpath <- file.path(td, testfname)

#Unzip Test Subject file
testSubjectfname <- unzip(tf, list=TRUE)$Name[16]
unzip(tf, files=testSubjectfname, exdir=td, overwrite=TRUE)
testSubjectfpath <- file.path(td, testSubjectfname)

#Unzip Test Labels File
testLabelfname <- unzip(tf, list=TRUE)$Name[18]
unzip(tf, files=testLabelfname, exdir=td, overwrite=TRUE)
testLabelfpath <- file.path(td, testLabelfname)

#Read Test File in
testData <- read.table(testfpath, stringsAsFactors=FALSE)
colnames(testData) <- featuresNames

#Read Test Subject File in
testSubject <- read.table(testSubjectfpath, stringsAsFactors=FALSE)

#Read Test Labels File in
testLabel <- read.table(testLabelfpath, stringsAsFactors=FALSE)

#Unzip Train File
trainfname <- unzip(tf, list=TRUE)$Name[31]
unzip(tf, files=trainfname, exdir=td, overwrite=TRUE)
trainfpath <- file.path(td, trainfname)

#Unzip Train Subject file
trainSubjectfname <- unzip(tf, list=TRUE)$Name[30]
unzip(tf, files=trainSubjectfname, exdir=td, overwrite=TRUE)
trainSubjectfpath <- file.path(td, trainSubjectfname)

#Unzip Train Labels File
trainLabelfname <- unzip(tf, list=TRUE)$Name[32]
unzip(tf, files=trainLabelfname, exdir=td, overwrite=TRUE)
trainLabelfpath <- file.path(td, trainLabelfname)

#Read Train File in
trainData <- read.table(trainfpath, stringsAsFactors=FALSE)
colnames(trainData) <- featuresNames

#Read Train Subject File in
trainSubject <- read.table(trainSubjectfpath, stringsAsFactors=FALSE)

#Read Train Labels File in
trainLabel <- read.table(trainLabelfpath, stringsAsFactors=FALSE)

#Create Activity table to be merged
activity_num<-c(1:6)
activity_desc<-c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING")
activityDF<-data.frame(activity_num,activity_desc,stringsAsFactors=FALSE)

#Test - Add Activity Names
testMaster<-cbind(testSubject, testLabel, testData)
colnames(testMaster)[1] <- "Subject"
colnames(testMaster)[2] <- "ActivityNum"
mergetestMaster<-merge(activityDF,testMaster,by.x="activity_num",by.y="ActivityNum",all=TRUE)

#Train - Add Activity Names
trainMaster<-cbind(trainSubject, trainLabel, trainData)
colnames(trainMaster)[1] <- "Subject"
colnames(trainMaster)[2] <- "ActivityNum"
mergetrainMaster<-merge(activityDF,trainMaster,by.x="activity_num",by.y="ActivityNum",all=TRUE)

#Merge Test and Training Files
dataMaster<-rbind(mergetestMaster,mergetrainMaster)

#Grep for Mean and STD columns
grepMean<-grep("mean\\(\\)",names(dataMaster))
grepSTD<-grep("std\\(\\)",names(dataMaster))
grepMaster<-c(2,3,grepMean,grepSTD)
grepdataMaster<-dataMaster[,grepMaster]

#Find Mean of all columns
colMean<-aggregate(grepdataMaster[,3:68],grepdataMaster[,1:2],FUN=mean)

colnames(colMean) <- featuresNames2

write.table(colMean,"tidy.txt")
