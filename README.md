## Tidy Data Set 
### collected from accelerometers on the Samsung Galaxy S smartphone

Script "run_analysis.R" performs several tasks with the data downloaded from [link](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) on July 13, 2014

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

The obtained tidy data set is written to a file "tidy_data_set.txt"