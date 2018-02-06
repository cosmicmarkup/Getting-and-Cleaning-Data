#Codebook

##Download and Extract Data
1. Load the data.table library
2. Download the file from URL and extract it

##Read files into their corresponting tables (train and test)
*train = X_train.txt, y_train.txt, subject_train.txt, features.txt
*test = X_test.txt, y_test.txt, subject_test.txt, features.txt

##Merge the training and the test sets to create one data set.
Put them in the variable 'all'

##Extracts only the measurements on the mean and standard deviation for each measurement.

##Uses descriptive activity names to name the activities in the data set.
Read the activity_labels file and insert it to the 'all' table. Store it to a variable called 'subject'

##Appropriately labels the data set with descriptive variable names.
Use gsub to replace the appropirate table labels.

##From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
Generate a tidy dataset containing only the average of each variable for each activity and subject.