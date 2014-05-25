#run_analysis.R
#Getting and Cleaning Data Course Project
#Stephanie Holcomb

# x_train.text = training set; y_train.txt = labels for training ; subject_train.txt = subject ids
# x_test.txt = test set ; y_test.txt = labels for test; subject_test.txt = subject ids

# 1.Merges the training and the test sets to create one data set.
trainingData<-read.table("./data/train/x_train.txt")
trainingLabels<-read.table("./data/train/y_train.txt")
trainingSubjects<-read.table("./data/train/subject_train.txt")

testData<-read.table("./data/test/x_test.txt")
testLabels<-read.table("./data/test/y_test.txt")
testSubjects<-read.table("./data/test/subject_test.txt")

    # read activity labels in
activityLabels<-read.table("./data/activity_labels.txt")

    # merge training and test data sets together
mergeData<-rbind(trainingData,testData)
mergeLabels<-rbind(trainingLabels,testLabels)
mergeSubjects<-rbind(trainingSubjects,testSubjects)


# 2.Extracts only the measurements on the mean and standard deviation for each measurement. 
    # read in features.txt
featuresData<-read.table("./data/features.txt")

    # pull out lines with mean or std identifications and create vector
StandardMeanSub<-grep("mean\\(\\)|std",featuresData[,2])

    # subset mergeData to only include rows of mean and standard deviation
mergeData<-mergeData[,StandardMeanSub]


    # use index of subset to set column headings and cleanup by removing parenthesis,dashes, and setting fontcases
names(mergeData)<-gsub("\\(\\)", "", featuresData[StandardMeanSub, 2])
names(mergeData)<-gsub("-","",names(mergeData))
names(mergeData)<-gsub("mean","Mean",names(mergeData)) #capitalize mean and std
names(mergeData)<-gsub("std","Std",names(mergeData)) 

# 3.Uses descriptive activity names to name the activities in the data set
    # add activity labels and cleanup - remove underscores, to lowercase, then camelcase if needed
activityLabels[,2]<-gsub("_","",activityLabels[,2]) #remove any underscores
activityLabels[,2]<-tolower(activityLabels[,2])
activityLabels[,2]<-gsub("walkingupstairs","walkingUpStairs",activityLabels[,2])
activityLabels[,2]<-gsub("walkingdownstairs","walkingDownStairs",activityLabels[,2])

# 4.Appropriately labels the data set with descriptive activity names. 
    #merge with activityLabels to get full set of labels
activityLabels <- activityLabels[mergeLabels[, 1], 2]      
mergeLabels[, 1] <- activityLabels #move activityLabel over to original mergeLabels set
names(mergeSubjects)<-"subject"
names(mergeLabels)<-"activity"

# 5.Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
    # create temporary merged data table
tidyDataTemp <- cbind(mergeSubjects, mergeLabels, mergeData)

    # melt data to calculate mean for each feature by subject,activity
library(reshape2)
melt<-melt(tidyDataTemp,id=c("subject","activity"))
tidyData<-dcast(melt,subject + activity ~variable,mean)

    # melt loses sort order - force resort by subject,activity per activity labels
activitySort<-c("walking","walkingUpStairs","walkingDownStairs","sitting","standing","laying")
tidyData<-tidyData[with(tidyData,order(subject,factor(activity,activitySort))),]
rownames(tidyData)<-NULL #reset rownumbers after sort
    # write final tidyData file
write.table(tidyData,"tidyData.txt")