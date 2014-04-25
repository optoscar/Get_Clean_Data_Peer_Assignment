#--------------------------------------------------------------------
# 1. Merges the training and the test sets to create one data set.
#--------------------------------------------------------------------
## Features names
feat_names <- read.table("../UCI HAR Dataset/features.txt")

## Reading test data
# set of 561 features calculated from the raw data
x_test <- read.table("../UCI HAR Dataset/test/X_test.txt")
# label for each observation in x_test
y_test <- read.table("../UCI HAR Dataset/test/y_test.txt")
# id of subject for each observatin in x_test
subject_test <- read.table("../UCI HAR Dataset/test/subject_test.txt") 

# Name subject and activity data 
names(subject_test) <- "subjectid"
names(y_test) <- "activity"
names(x_test) <- feat_names$V2

# join subjectid, actividy and features
data_test <- cbind.data.frame(subject_test,y_test,x_test)

## Reading train data
# set of 561 features calculated from the raw data
x_train <- read.table("../UCI HAR Dataset/train/X_train.txt")
# label for each observation in x_train
y_train <- read.table("../UCI HAR Dataset/train/y_train.txt")
# id of subject for each observatin in x_train
subject_train <- read.table("../UCI HAR Dataset/train/subject_train.txt") 

# Name subject and activity data 
names(subject_train) <- "subjectid"
names(y_train) <- "activity"
names(x_train) <- feat_names$V2

# join subjectid, actividy and features
data_train <- cbind.data.frame(subject_train,y_train,x_train)

# read subject ids
id_test <- unique(subject_test)
id_train <- unique(subject_train)
# check there are no mixed
any(id_test[,1] %in% id_train[,1])

# merge training and test data
data <- rbind.data.frame(data_test,data_train)

# clean memory
rm("data_test","data_train","subject_test","subject_train","x_test","x_train","y_test","y_train","id_test","id_train")














