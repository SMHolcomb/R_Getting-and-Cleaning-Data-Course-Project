


**Final tidyData.txt file includes the following:**
-------------------------------------------------

*180 observations of 68 variables*

Each observation includes: 

- Subject id from 1 to 30 that identifies the subject who carried out the experiment

- Activity label that identifies one of the six activities that were carried out

- Average of each of 66 features corresponding to the subject and activity
(for more information on each feature measured, see "features.txt" and "features_info.txt" in the data folder.)


**Notes on original data collection and process:**

Data files downloaded from: 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Original source of raw data:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 


The original raw data files included in the data folder and used to generate the final tidy data set (tidyData.txt) include:

- 'train/X_train.txt': Training data

- 'train/y_train.txt': Training labels

- 'test/X_test.txt': Test data

- 'test/y_test.txt': Test labels.

- 'train/subject_train.txt': Each row identifies the subject (1-30) who performed the activity for each window sample

- 'test/subject_test.txt': Each row identifies the subject (1-30) who performed the activity for each window sample

- 'features_info.txt': Shows information about the variables used on the feature vector

- 'features.txt': List of all features

- 'activity_labels.txt': Links the class labels with their activity name


**run_analysis.R - Details of Script Process:**

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
17. Write final tidy dataset to working directory as "tidyData.txt"





