#Read Me File for the Clean Data project as part of the Getting and Cleaning Data course
## Summary of the project requirements:
####Given the data collected from the accelerometers from the Samsung Galaxy S smartphone, create a tidy data set as per these instructions -  
####1. Merge the training and the test sets to create one data set.
####2. Extract only the measurements on the mean and standard deviation for each measurement. 
####3. Use descriptive activity names to name the activities in the data set
####4. Appropriately label the data set with descriptive variable names. 
####5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
## Step by Step Process  :
#### Read the test and training data into separate datasets 
#### Read the test and training activity indicators (1 through 6)
#### Read the test and training subject labels
#### Create the full test and full training data sets by adding the activity indicator and subject number columns to each dataset
#### Now place the rows of each data set into one big dataset 
#### Read the features data
#### Get the features' names
#### Convert the names vector from a factor to a character vector
#### Name the last two columns appropriately using this character vector
#### Clean up the column names - remove () and replace "," with "."
#### Assign the new column names to the full data set
#### Remove columns not required and retain only those specified
#### Bind all the columns to form the relevant subset
#### Name the activities with meaningful names
#### Split the data set based on Activity and Subject
#### Note that the column names are indicative of the activity and the subject
#### Find the number of columns in the final set
#### Each column is a dataframe and we need to find the mean of each column in that dataframe
#### So - loop through each column,and for the first 66 columns find the mean
#### Create appropriate row names (Note: column names are ok)
#### Set the new row names
#### Note that the newset is a matrix 
#### Now write it out as a textfile
