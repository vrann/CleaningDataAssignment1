## R script works on data collected from the accelerometers from the Samsung Galaxy S smartphone.
## Script which aggregates data from multiple files and generates summary.
## Original data set is downloaded here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
## The result is a data set with the average of each variable for each activity and each subject.

# First file is a file with the labels of Activities, recognizable by the system
labels = read.table("UCI\ HAR\ Dataset/activity_labels.txt")

# Next file represents features set
features = read.table("UCI\ HAR\ Dataset/features.txt", check.names=F)

# For aggregation purposes, the only features interested for us are means and standard deviation
# these features are marked as a mean() and std() in the names. Creating a vector of the names
meanstd_features = merge(features[grepl("mean\\(\\)$", features$V2, perl=T),],features[grepl("std\\(\\)$", features$V2, perl=T),], all=T)
meanstd_features_vector = as.vector(meanstd_features$V2);

# All the measurement data are splited on training set and testing set.
# First, loading training set, with using featutres names loaded on the previous step as a column names
trainset = read.table("UCI\ HAR\ Dataset/train/X_train.txt", col.names=features[,2], check.names=F)
#filtering the data set, leave just those columns which corresponds to means and standard deviation
trainset = trainset[meanstd_features_vector];

# Loading activity set for each of the measurement from training data set.
# Assigning Activity Labels loaded previously to each activity code
# Adding activity names to the loaded training data set
train_y = read.table("UCI\ HAR\ Dataset/train/y_train.txt")
activity = merge(train_y, labels, sort=F);
trainset$activity = activity$V2

# Loading subjects for the training data.
# Subject represents separate person whose movements and accelerometer data were studied
# Assigning subjects to loaded training set data
train_subject = read.table("UCI\ HAR\ Dataset/train/subject_train.txt")
trainset$subject = train_subject$V1

# Loading test set data
# filtering out features which are not means and standard deviation
testset = read.table("UCI\ HAR\ Dataset/test/X_test.txt", col.names=features[,2], check.names=F)
testset = testset[meanstd_features_vector];

# Loading activity set and assigning labels to that
# addinfg activities t0 test data set
test_y = read.table("UCI\ HAR\ Dataset/test/y_test.txt")
activity = merge(test_y, labels, sort=F)
testset$activity = activity$V2

# Loading subjects for test data set and assigning to the set
test_subject = read.table("UCI\ HAR\ Dataset/test/subject_test.txt")
testset$subject = test_subject$V1

# Merge training data set and test data set
merged_set = merge(trainset, testset, by = c(meanstd_features_vector,"activity", "subject"), all=T)

library(reshape2)

# Aggregating the data set with the goal to have an average of each variable for each activity and each subject
# For this purpose, first melting the data set by activity and subject ids
melted_set=melt(merged_set,id.vars=c("activity","subject"))

# Then, casting it with a "mean" aggregation function for the activity and subject pair
casted_set = dcast(melted_set, activity+subject~variable,mean)