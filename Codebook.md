The run_analysis.R script prepares the data and then perform the 5 sequences described in the course project’s requirement.

A) Data Preparation

1.Download the dataset from the link provided in the course project's requirement, unzip and extract the contents into a folder UCI HAR Dataset.

2.The files in the folder UCI HAR Dataset that are used for the course project and the names assigned to each file is listed:

features_names <- features.txt          : List of all features.
activity_label <- activity_labels.txt   : Links the class labels with their activity name.
subject_test   <- test/subject_test.txt : Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
features_test  <- test/X_test.txt       : Test set.
activity_test  <- test/y_test.txt       : Test labels.
subject_train  <- test/subject_train.txt : Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
features_train <- test/X_train.txt       : Training set.
activity_train <- test/y_train.txt       : Training labels.


B) 5 Sequences described in the course project's requirement
1.Merges the training and the test sets to create one data set 
features is created by merging features_train and features_test using rbind() function
activity is created by merging activity_train and activity_test using rbind() function
subject is created by merging subject_train and subject_test using rbind() function
data is created by merging subject, activity and features using cbind() function

2.Extracts only the measurements on the mean and standard deviation for each measurement 
data1 is created by subsetting data, selecting only the columns subject and code, and the measurements on the mean and standard deviation (std) for each measurement

3.Uses descriptive activity names to name the activities in the data set 
The data1 and activity_label is matched by activityid to obtain the description of the activities variable

4.Appropriately labels the data set with descriptive variable names 
Rename column in datalabel
All Acc in column’s name replaced by Accelerometer
All Gyro in column’s name replaced by Gyroscope
All BodyBody in column’s name replaced by Body
All Mag in column’s name replaced by Magnitude
All start with character f in column’s name replaced by Frequency
All start with character t in column’s name replaced by Time
All tBody in column's name replaced by TimeBody
All angle in column replaced by Angle
All gravity in column replaced by Gravity

5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject 
data2 is created by taking the average of each variable for each activity and each subject, after groupped by subject and activity.
data2 is exported into tidydata.txt file.
