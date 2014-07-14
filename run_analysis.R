##___read data
TEST <- read.csv("./UCI HAR Dataset/test/X_test.txt", sep="", header=FALSE)
TRAIN <- read.csv("./UCI HAR Dataset/train/X_train.txt", sep="", header=FALSE)

##___1.  Merges the training and the test sets to create one data set.
TOTAL <- rbind(TEST, TRAIN)

##___2.  Extracts only the measurements on the mean and standard deviation
##for each measurement. 
VAR_NAMES <- read.csv("./UCI HAR Dataset/features.txt", sep="", header=FALSE)
Chosen <- TOTAL[ , grep("mean|std", VAR_NAMES[ , 2] )]

##___3.  Uses descriptive activity names to name the activities in the data set
Y_TEST <- read.csv("./UCI HAR Dataset/test/y_test.txt", sep="", header=FALSE)
Y_TRAIN <- read.csv("./UCI HAR Dataset/train/y_train.txt", sep="", header=FALSE)
Y <- rbind(Y_TEST, Y_TRAIN); names(Y) <- "ActivityLabel"
Chosen <- cbind(Chosen, Y)

ActLabels <- read.csv("./UCI HAR Dataset/activity_labels.txt", sep="", header=FALSE)

for(a in ActLabels[, 1])
{
    Chosen$ActivityLabel <- sub(a, ActLabels[a, 2], Chosen$ActivityLabel)    
}

##___4.  Appropriately labels the data set with descriptive variable names. 
names(Chosen) <- c(grep("mean|std", VAR_NAMES[ , 2], value = TRUE), 
                   "ActivityLabel")

##___5. Creates a second, independent tidy data set 
##with the average of each variable for each activity and each subject
Subj_TEST <- read.csv("./UCI HAR Dataset/test/subject_test.txt", sep="", header=FALSE)
Subj_TRAIN <- read.csv("./UCI HAR Dataset/train/subject_train.txt", sep="", header=FALSE)
Subj <- rbind(Subj_TEST, Subj_TRAIN); names(Subj) <- "SubjectID"
Chosen <- cbind(Chosen, Subj)

Mean_ONLY <- Chosen[ , grep("mean|ActivityLabel|SubjectID", names(Chosen))]

TDS <- aggregate(x = Mean_ONLY, 
                 by = list(ActivityLabel = Mean_ONLY$ActivityLabel, 
                           SubjectID = Mean_ONLY$SubjectID), 
                 FUN = mean)

TDS <- TDS[ , 1:(ncol(TDS)-2)]

write.csv(TDS, file = "./tidy_data_set.txt")
