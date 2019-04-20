library(data.table)
library(dplyr)

## download the file into own folder.
filename <- "getdata_projectfiles_UCI HAR Dataset.zip"

if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, filename, method="curl")
}  

# unzip the file after download
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}

## read metadata and name the variables
features_name <- read.table("UCI HAR Dataset/features.txt", col.names = c("featuresid","featuresname"))
activity_label <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("activityid", "activity_label"))

## read test and train data and name the variables
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
features_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features_name$featuresname)
activity_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "activityid")

subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
features_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features_name$featuresname)
activity_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "activityid")

## 1. Merges the training and the test sets to create one data set.
features <- rbind(features_train, features_test)
activity <- rbind(activity_train, activity_test)
subject <- rbind(subject_train, subject_test)
data <- cbind(subject, activity, features)

## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
data1 <- data %>% select(subject, activityid, contains("mean"), contains("std"))

## see the extraction of the mean and standard deviation for each measurement
str(data1)

## 3. Uses descriptive activity names to name the activities in the data set
datalabel = merge(data1, activity_label, by='activityid', all.x=TRUE)

## 4. Appropriately labels the data set with descriptive variable names. 
names(datalabel)<-gsub("^t", "time", names(datalabel))
names(datalabel)<-gsub("^f", "frequency", names(datalabel))
names(datalabel)<-gsub("Acc", "Accelerometer", names(datalabel))
names(datalabel)<-gsub("Gyro", "Gyroscope", names(datalabel))
names(datalabel)<-gsub("Mag", "Magnitude", names(datalabel))
names(datalabel)<-gsub("BodyBody", "Body", names(datalabel))
names(datalabel)<-gsub("tBody", "TimeBody", names(datalabel))
names(datalabel)<-gsub("angle", "Angle", names(datalabel))
names(datalabel)<-gsub("gravity", "Gravity", names(datalabel))

## see the descriptive labeling 
names(datalabel)

## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
data2 <- datalabel %>%
  group_by(subject, activity_label) %>%
  summarise_all(funs(mean))
write.table(data2, "tidydata.txt", row.name=FALSE)

## see output 
data2






