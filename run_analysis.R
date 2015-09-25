# Project Instructions:
#You should create one R script called run_analysis.R that does the following. 
#1. Merges the training and the test sets to create one data set.
#2. Extracts only the measurements on the mean and standard deviation for each measurement. 
#3. Uses descriptive activity names to name the activities in the data set
#4. Appropriately labels the data set with descriptive variable names. 
#5. From the data set in step 4, creates a second, independent tidy data set 
# with the average of each variable for each activity and each subject.
#################################################################################
#
# Read the test and training data 
Xtest <- read.table("C:/Users/student/vrvasu-dropbox/Dropbox/Coursera/DataScienceSpecialization/GettingAndCleaningData/Project/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt")
Xtrain <- read.table("C:/Users/student/vrvasu-dropbox/Dropbox/Coursera/DataScienceSpecialization/GettingAndCleaningData/Project/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt")
# Read the test and training activity indicators (1 through 6)
Ytest <- read.table("C:/Users/student/vrvasu-dropbox/Dropbox/Coursera/DataScienceSpecialization/GettingAndCleaningData/Project/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt")
Ytrain <- read.table("C:/Users/student/vrvasu-dropbox/Dropbox/Coursera/DataScienceSpecialization/GettingAndCleaningData/Project/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt")

# Read the test and training subject labels
subjecttest <- read.table("C:/Users/student/vrvasu-dropbox/Dropbox/Coursera/DataScienceSpecialization/GettingAndCleaningData/Project/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt")
subjecttrain <- read.table("C:/Users/student/vrvasu-dropbox/Dropbox/Coursera/DataScienceSpecialization/GettingAndCleaningData/Project/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt")

# Create the full test and full training data setes by adding the activity indicator 
# and subject number columns
Xfulltest <- cbind(Xtest, Ytest, subjecttest)
Xfulltrain <- cbind(Xtrain, Ytrain, subjecttrain)

# Now add the rows of each data set into one big dataset 
Xfull <- rbind(Xfulltrain,Xfulltest)

# Read the features data
varnames <- read.table("C:/Users/student/vrvasu-dropbox/Dropbox/Coursera/DataScienceSpecialization/GettingAndCleaningData/Project/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/features.txt")
# Get the names
varnames_vec <- varnames[,2]
lengthofvarnames <- length(varnames_vec)

# Convert from factor to character vector
varnames_vec <- as.character(varnames_vec)

# Name the last two columns appropriately
varnames_vec[lengthofvarnames + 1] <- "Activity"
varnames_vec[lengthofvarnames + 2] <- "Subject"
# Clean up the column names - remove () and replace "," with "."
varnames_vec <- gsub("[:():]","",varnames_vec)
varnames_vec <- gsub(",",".",varnames_vec)

# Assign the new column names to the full data set
names(Xfull) <- varnames_vec 

# Remove columns not required and retain only those specified
Xsubset1 <- Xfull[,c(1:381,424:563)]
Xsubset2 <- select(Xsubset1, contains("mean"))
Xsubset3 <- select(Xsubset2, -contains("angle"))
Xsubset4 <- select(Xsubset3, -contains("meanFreq"))

Xsubset5 <- select(Xsubset1, contains("std"))
Xsubset6 <- select(Xsubset1, contains("Activity"))
Xsubset7 <- select(Xsubset1, contains("Subject"))

# Bind all the columns to form the relevant subset
Xsubset <- cbind(Xsubset4, Xsubset5, Xsubset6, Xsubset7)

# Name the activities with meaningful names
Xsubset$Activity[Xsubset$Activity == 1] <- "WALKING"
Xsubset$Activity[Xsubset$Activity == 2] <- "WALKING_UPSTAIRS"
Xsubset$Activity[Xsubset$Activity == 3] <- "WALKING_DOWNSTAIRS"
Xsubset$Activity[Xsubset$Activity == 4] <- "SITTING"
Xsubset$Activity[Xsubset$Activity == 5] <- "STANDING"
Xsubset$Activity[Xsubset$Activity == 6] <- "LAYING"


# Split the data set based on Activity and Subject
finalset <- split(Xsubset, list(Xsubset$Activity, Xsubset$Subject))
# Note that the column names are indicative of the activity and the subject
finalsetnames <- names(finalset)
# Find the number of columns in the final set
numcolsfinalset <- length(finalsetnames)

# Each column is a dataframe and we need to find the mean of each column in that dataframe
# So - loop through each column,and for the first 66 columns find the mean
for (i in 1: numcolsfinalset) {
  testset <- sapply(finalset[[i]][,1:66], mean)
  if (i == 1) {
    newset <- testset; # Create a new dataset
  }
  else {
    newset <- rbind(newset, testset); # Add to this data set each row of means
  }
}

# Create appropriate row names (Note: column names are ok)
newsetnames <- gsub("[:.:]"," ACTIVITY BY SUBJECT ", finalsetnames)
# Set the new row names
rownames(newset) <- newsetnames

# Note that the newset is a matrix 
# Now write it out as a textfile
write.table (newset, file = "cleandata.txt", row.name = FALSE)
