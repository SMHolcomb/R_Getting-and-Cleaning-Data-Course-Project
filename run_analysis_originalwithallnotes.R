#run_analysis.R
#Getting and Cleaning Data Course Project
#Stephanie Holcomb


# 3.Uses descriptive activity names to name the activities in the data set
# 4.Appropriately labels the data set with descriptive activity names. 
# 5.Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

# x_train.text = training set; y_train.txt = labels for training ; subject_train.txt = subject ids
# x_test.txt = test set ; y_test.txt = labels for test; subject_test.txt = subject ids

# 1.Merges the training and the test sets to create one data set.
trainingData<-read.table("./data/train/x_train.txt")
trainingLabels<-read.table("./data/train/y_train.txt")
trainingSubjects<-read.table("./data/train/subject_train.txt")

testData<-read.table("./data/test/x_test.txt")
testLabels<-read.table("./data/test/y_test.txt")
testSubjects<-read.table("./data/test/subject_test.txt")

activityLabels<-read.table("./data/activity_labels.txt")

mergeData<-rbind(trainingData,testData)
mergeLabels<-rbind(trainingLabels,testLabels)
mergeSubjects<-rbind(trainingSubjects,testSubjects)
# head(mergeLabels)
# tail(mergeLabels)

# 2.Extracts only the measurements on the mean and standard deviation for each measurement. 
featuresData<-read.table("./data/features.txt")
# head(featuresData)
#pull out lines with mean or std identifications create vector
StandardMeanSub<-grep("mean\\(\\)|std",featuresData[,2])
#StandardMeanSub
#subset mergeData to only include rows of mean and standard deviation
mergeData<-mergeData[,StandardMeanSub]
# head(mergeData)

# set column headings to equal database features from features.txt
#clean up by removing parenthesis, dashes etc..
#use the indices of rows containing std and mean features to set new column headings
names(mergeData)<-gsub("\\(\\)", "", featuresData[StandardMeanSub, 2])
  # head(mergeData)
names(mergeData)<-gsub("-","",names(mergeData))
names(mergeData)<-gsub("mean","Mean",names(mergeData)) #capitalize mean and std - easier to read
names(mergeData)<-gsub("std","Std",names(mergeData)) 

#add activity labels and cleanup
head(activityLabels)
activityLabels[,2]<-gsub("_","",activityLabels[,2]) #remove any underscores
#make lowercase then fix to camelcase if needed
activityLabels[,2]<-tolower(activityLabels[,2])

activityLabels[,2]<-gsub("walkingupstairs","walkingUpStairs",activityLabels[,2])
activityLabels[,2]<-gsub("walkingdownstairs","walkingDownStairs",activityLabels[,2])

#merge with activityLabels to get full set of labels
activityLabels <- activityLabels[mergeLabels[, 1], 2]      

mergeLabels[, 1] <- activityLabels #move activityLabel over to original mergeLabels set
names(mergeSubjects)<-"subject"
names(mergeLabels)<-"activity"
tidyDataTemp <- cbind(mergeSubjects, mergeLabels, mergeData)

#head(tidyDataTemp,n=40)

#*** order tidyDataTemp by subject, then explicit activity
activitySort<-c("walking","walkingUpStairs","walkingDownStairs","sitting","standing","laying")
tidyDataTemp<-tidyDataTemp[with(tidyDataTemp,order(subject,factor(activity,activitySort))),]
#write tidyData out to a .txt file
#write.table(tidyDataTemp,"tidyTableTemp.txt") #temp to eyeball

#melt loses sort order - can this be custom ordered for activity column? 
library(reshape2)
melt<-melt(tidyDataTemp,id=c("subject","activity"))
#head(melt)
tidyData<-dcast(melt,subject + activity ~variable,mean)

#Take 2 group on subject,activity and loop through column indices and calculate mean

#order on subject then activity so embedded loop i.e. 1 to total subject count and 
# 1 to total activity count
# length(sort(unique(mergeSubjects[,1])))
# length(sort(activityLabels))
# rownum=1
# for(a in 1:length(sort(unique(mergeSubjects[,1])))) {
#     
#     for(b in 1:length(sort(activityLabels)) {
#          
#     
#     }
# }
tidyData<-tidyData[with(tidyData,order(subject,factor(activity,activitySort))),]
#tidyDataFinal<-tidyData
#tidyData[1:10,1:3]
rownames(tidyData)<-NULL #reset rownumbers after sort
write.table(tidyData,"tidyData.txt")