Coursera Getting and Cleaning Data Class - Course Project
---------------------------------------------------------

**Requirements:**

Uses data obtained from the URL below: 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip


Using data abtained from the URL above, demonstrate your ability to collect, work with, and clean a data set by creating on R script called run_analysis.R that does the following:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. ppropriately labels the data set with descriptive activity names. 
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

**run_analysis.R Process Notes:**


1. Read the training files: x_train.txt, y_train.txt, and subject_train.txt from the data folder and save to temporary tables
2. Read the test file: x_test.txt, y_test.txt, and subject_test.txt from the data folder and save to temporary tables
3. Read the activity_labels.txt file from the data folder and save to a temporary table
4. Merge the corresponding training and test data sets together into three tables:
    1. data values
    2. labels
    3. subjects
5. Read the features.txt file to a temporary table
6. From the temporary features table, subset only those lines that include mean or std measures
7.  Using the results from step#6, above, subset the merged data to only include rows that have mean or std measures
8. Use the index of the subset to create column headings.
9. Clean up the column headings by removing parenthesis, dashes, and by putting them in camelcase format
10. Using the activity labels read in step#3 above, add activity labels to the dataset and clean them up by removing underscores and setting to camelcase format.
11. Move the cleaned up activity labels over to the merged labels table.
12. Set column heading for merged subjects file to "subject"
13. Set column heading for merged labels file to "activity"
14. Merge all sets together to form one temporary master file
15. Using the reshape2 library, melt the temporary dataset created in step#14 above to calculate mean for each subject,activity combination - and put it in a final tidyData dataset.
16. Because sort order of activity was lost during melt, force a resort by subject and then activity per the cleaned up activity labels created in step#10 above.
17. Write final tidy dataset to tidyData.txt 

