# Script modules are seperated by a blank line. The script performs 5 functions:
#       1. Merges training and test sets to create one data set
#       2. Extracts data on mean and standard deviation for each measurement
#       3. Uses descriptive activity names to name activities 
#       4. Labels variables with descriptive names
#       5. Produces a tidy data set containing the average of each of the 
#          variables extracted in (3) by activity and subject

# The next 3 modules construct the test and trainins sets and merge the two.

# read in the 3 "test" text files
x_test <- read.table("X_test.txt",quote="\"")
activity_test <- read.table("y_test.txt",quote="\"")
subject_test <- read.table("subject_test.txt",quote="\"")
# column bind the 3 "test" files to create one "test" table with variables 
# ordered by subject, activity and measurements
test <- cbind(subject_test,activity_test,x_test)

#read in the 3 "train" text files
x_train <- read.table("X_train.txt",quote="\"")
activity_train <- read.table("y_train.txt",quote="\"")
subject_train <- read.table("subject_train.txt",quote="\"")
# column bind the 3 "train" files to create one "train" table with variables 
# ordered by subject, activity and measurements
train <- cbind(subject_train,activity_train,x_train)

# row bind test and train to create one table (data) for analysis
data <- rbind(test,train)

# This module reads in features.txt file containing names for measurement 
# variables
measurements <- read.table("features.txt",quote="\"")
# extract names from measurements and coerce as character
measurement_names <- as.character(measurements[,2])

# This module names (labels) the identifiers and variables in the data set
data <- setNames(data,c("Subject","Activity",measurement_names))

# This modules convert activity codes to plain english from codes. Labels are 
# found in activity_labels.txt file
activity_labels <- read.table("activity_labels.txt",quote="\"")
# loops through data and finds matches in codes between data$Activity and 
# activity-labels, it then replaces data$Activity with the plain english 
# equivalents found in activity labels
for (i in seq(nrow(data))){
        index <- match(data[i,"Activity"],activity_labels[,1])
        data[i,"Activity"] <- as.character(activity_labels[index,2])
}

# This module produces a list of variables associated with Mean and Standard 
# Deviation("mean","std)
mean_Col <- agrep("mean()",measurement_names,fixed=T)
std_Col  <- agrep("std()",measurement_names,fixed=T)
# produces the list of variable names associated with either "mean" or "std"
mean_std_vars <- measurement_names[c(mean_Col,std_Col)]

# This module finishes the first tidy dataset
# extracts all the records from the dataset associated with "mean" or "std"
bigTidy <- data[,c("Subject","Activity",mean_std_vars)]
# this data is tidy because it has all the variables in columns and each
# observation is in a separate row and contains only the data associated
# with mean or standard deviation as required by the project

# This module creates the independent tidy dataset described by the 5th 
# function of the script (see above)
# create tinyTidy which is a tidy dataset with the mean of each variable
# in bigTidy by Subject and Activity
library(reshape2)
tinyTidy <- melt(bigTidy,id=c("Activity","Subject"))
tinyTidy <- dcast(tinyTidy,Activity + Subject ~ variable,mean)
# tinyTidy is tidy because it has all the variables in columns and each
# observation is in a seperate row and contains only the data required

# This module outputs the tinyTidy dataset as a .txt file which can be viewed 
# in R using the following code:
#       CourseProjectTable <- read.table("CourseProjectTable.txt",header=T)
#       View(CourseProjectTable)
write.table(tinyTidy,file="CourseProjectTable.txt",row.name=F)

