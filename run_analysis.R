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


#-------------------------------------------------------------------------------------------
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
#-------------------------------------------------------------------------------------------
# find those features on mean()
mean_i <- grep("mean\\(\\)",feat_names$V2)
# find those features on std()
std_i <- grep("std\\(\\)",feat_names$V2)
# sum 2 to mean_i and std_i to take into account added subjectid and activity columns
mean_i <- mean_i + 2
std_i <- std_i + 2
# sum 2 to take into account subjectid and activity rows added to the data set
data <- data[,c(1,2,mean_i,std_i)]

# tidying up features names, removing "()" and "-"
feat_names <- names(data)
feat_names <- gsub("[\\-]","",feat_names)
feat_names <- gsub("[\\(\\)]","",feat_names)
names(data) <- feat_names
rm("mean_i","std_i","feat_names")

#-------------------------------------------------------------------------------------------
# 3. Uses descriptive activity names to name the activities in the data set
#-------------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------------
# 4. Appropriately labels the data set with descriptive activity names.
#-------------------------------------------------------------------------------------------
##read labels
act_labels <- read.table("../UCI HAR Dataset/activity_labels.txt")
data$activity <- factor(data$activity, labels=act_labels$V2)
data$subjectid <- factor(data$subjectid)
## check labeling
str(data$activity)
head(data$activity)

str(data$subjectid)
head(data$subjectid)


#-------------------------------------------------------------------------------------------
# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
#-------------------------------------------------------------------------------------------
## split the data base on subjectid and activity
sdata <- split(data, data[,c('subjectid','activity')])
## apply functions colMeans to all the elements in the lists and only to the features 3:68               
tidy <- sapply(sdata,function(x)colMeans(x[,3:68]))

## transpose the dataframe to have the features as columns, and the grouping as rows
# first remember the names for columns and rows
rn <- row.names(tidy)
cn <- colnames(tidy)
# transpose 
tidy <- as.data.frame(t(tidy))
# set rows and columns names back
row.names(tidy) <- cn
colnames(tidy) <- rn

## adding subjectid and activity columns to make it easier to understand and filter
subjects <- rep(c(1:30),6)
#read labels
act_labels <- read.table("../UCI HAR Dataset/activity_labels.txt")
# repeat them 30 times (one per user)
act_labels2 <- rep(act_labels$V2[],30)
# order the labels as stated in activity_labels.txt
levels(act_labels2) <- act_labels$V2
# order by labels
act_labels2 <- act_labels2[order(act_labels2)]
# add subjectid and activity columns to tidy data set
tidy <- cbind(subjects,act_labels2,tidy)
# clean aux variables
rm("sdata","rn","cn","subjects","act_labels","act_labels2")

# write tidy to a ".txt" file (in CSV format)
write.csv(tidy, file="tidy.txt")

