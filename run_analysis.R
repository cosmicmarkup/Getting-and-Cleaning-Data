# GOALS
# 1) a tidy data set as described below, 
# 2) a link to a Github repository with your script for performing the analysis, and 
# 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data 
#    called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts 
#    work and how they are connected.

## Pre-processing
#  Download and Extract Data
library(data.table)
fileurl = 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'

	if (!file.exists('./UCI HAR Dataset.zip')){
	download.file(fileurl,'./UCI HAR Dataset.zip', mode = 'wb')
	unzip("UCI HAR Dataset.zip", exdir = getwd())
}

# Read data
features <- read.csv('./UCI HAR Dataset/features.txt', header = FALSE, sep = ' ')
features <- as.character(features[,2])

train_x <- read.table('./UCI HAR Dataset/train/X_train.txt')
train_y <- read.csv('./UCI HAR Dataset/train/y_train.txt', header = FALSE, sep = ' ')
train_subject <- read.csv('./UCI HAR Dataset/train/subject_train.txt',header = FALSE, sep = ' ')

train <-  data.frame(train_subject, train_y, train_x)
names(train) <- c(c('subject', 'activity'), features)

test_x <- read.table('./UCI HAR Dataset/test/X_test.txt')
test_y <- read.csv('./UCI HAR Dataset/test/y_test.txt', header = FALSE, sep = ' ')
test_subject <- read.csv('./UCI HAR Dataset/test/subject_test.txt', header = FALSE, sep = ' ')

test <-  data.frame(test_subject, test_y, test_x)
names(test) <- c(c('subject', 'activity'), features)

##Merges the training and the test sets to create one data set.
all <- rbind(train, test)

##Extracts only the measurements on the mean and standard deviation for each measurement.
get_mean_std <- grep('mean|std', features)
subject <- all[,c(1,2,get_mean_std + 2)]

##Uses descriptive activity names to name the activities in the data set.
activity_labels <- read.table('./UCI HAR Dataset/activity_labels.txt', header = FALSE)
activity_labels <- as.character(activity_labels[,2])
subject$activity <- activity_labels[subject$activity]

##Appropriately labels the data set with descriptive variable names.
new_name <- names(subject)
new_name <- gsub("[(][)]", "", new_name)
new_name <- gsub("^t", "TimeDomain_", new_name)
new_name <- gsub("^f", "FrequencyDomain_", new_name)
new_name <- gsub("Acc", "Accelerometer", new_name)
new_name <- gsub("Gyro", "Gyroscope", new_name)
new_name <- gsub("Mag", "Magnitude", new_name)
new_name <- gsub("-mean-", "_Mean_", new_name)
new_name <- gsub("-std-", "_StandardDeviation_", new_name)
new_name <- gsub("-", "_", new_name)
names(subject) <- new_name

##From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
tidy <- aggregate(
	subject[,3:81], 
	by = list(
		activity = subject$activity, 
		subject = subject$subject),
	FUN = mean
)

write.table(x = tidy, file = "data_tidy.txt", row.names = FALSE)