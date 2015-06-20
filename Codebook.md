---
title: 'Course Project Code Book: Getting and Cleaning Data'
author: "GAHoff"
date: "Saturday, June 20, 2015"
output: html_document
---

CODEBOOK
Getting and Cleaning Data Course Project
GA Hoff

The data used in this project is derived from the "Human Activity Recognition Using Smartphone Dataset, v.1.0" ref: activityrecognition@smartlab.ws

The data was collected from accelerometers on Samsung Galaxy S smartphones intended to model human activity and was presented in 8 files that were 
merged and processed to meet the requirements of the course project:

Files:
        activity_labels.txt -labels of subject activity
	features.txt - labels of variables measured
	subject_test.txt - variable measurement in the "test" set
	X_test.txt - subject id in the "test" set
	y_test.txt - activity codes in the "test" set
	subject_train.txt - variable measurement in the "train" set
	X_train.txt - subject id in the "train" set
	y_train.txt - activity codes in the "train" set

Course Project Requirements:
	1. Merges training and test sets to create one data set
	2. Extracts data on mean and standard deviation for each measurement
	3. Uses descriptive activity names to name activities 
	4. Labels variables with descriptive names
	5. Produces a tidy data set containing the average of each of the variables extracted in (3) by activity and subject
	
Code produces a tidy dataset of the means of variables associated with mean and standard deviation in the original data. This data is written to 
"CourseProjectTable.txt" which may be viewed in R with the following code: 	CourseProjectTable <- read.table("CourseProjectTable.txt",header=T)
										View(CourseProjectTable)

Descriptors of the data in the table are as follows:
Identifiers
	Activities
		LAYING
		SITTING
		STANDING
		WALKING
		WALKING_DOWNSTAIRS
		WALKING_UPSTAIRS

	Subject
		identified by numbers (1 -30) representing 30 volunteers aged 19-48
		
Variables (Calculated as MEANS (averages))
		[1]  "tBodyAcc-mean()-X"           "tBodyAcc-mean()-Y"          
		 [3] "tBodyAcc-mean()-Z"           "tGravityAcc-mean()-X"       
		 [5] "tGravityAcc-mean()-Y"        "tGravityAcc-mean()-Z"       
		 [7] "tBodyAccJerk-mean()-X"       "tBodyAccJerk-mean()-Y"      
		 [9] "tBodyAccJerk-mean()-Z"       "tBodyGyro-mean()-X"         
		[11] "tBodyGyro-mean()-Y"          "tBodyGyro-mean()-Z"         
		[13] "tBodyGyroJerk-mean()-X"      "tBodyGyroJerk-mean()-Y"     
		[15] "tBodyGyroJerk-mean()-Z"      "tBodyAccMag-mean()"         
		[17] "tGravityAccMag-mean()"       "tBodyAccJerkMag-mean()"     
		[19] "tBodyGyroMag-mean()"         "tBodyGyroJerkMag-mean()"    
		[21] "fBodyAcc-mean()-X"           "fBodyAcc-mean()-Y"          
		[23] "fBodyAcc-mean()-Z"           "fBodyAccJerk-mean()-X"      
		[25] "fBodyAccJerk-mean()-Y"       "fBodyAccJerk-mean()-Z"      
		[27] "fBodyGyro-mean()-X"          "fBodyGyro-mean()-Y"         
		[29] "fBodyGyro-mean()-Z"          "fBodyAccMag-mean()"         
		[31] "fBodyBodyAccJerkMag-mean()"  "fBodyBodyGyroMag-mean()"    
		[33] "fBodyBodyGyroJerkMag-mean()" "tBodyAcc-std()-X"           
		[35] "tBodyAcc-std()-Y"            "tBodyAcc-std()-Z"           
		[37] "tGravityAcc-std()-X"         "tGravityAcc-std()-Y"        
		[39] "tGravityAcc-std()-Z"         "tBodyAccJerk-std()-X"       
		[41] "tBodyAccJerk-std()-Y"        "tBodyAccJerk-std()-Z"       
		[43] "tBodyGyro-std()-X"           "tBodyGyro-std()-Y"          
		[45] "tBodyGyro-std()-Z"           "tBodyGyroJerk-std()-X"      
		[47] "tBodyGyroJerk-std()-Y"       "tBodyGyroJerk-std()-Z"      
		[49] "tBodyAccMag-std()"           "tGravityAccMag-std()"       
		[51] "tBodyAccJerkMag-std()"       "tBodyGyroMag-std()"         
		[53] "tBodyGyroJerkMag-std()"      "fBodyAcc-std()-X"           
		[55] "fBodyAcc-std()-Y"            "fBodyAcc-std()-Z"           
		[57] "fBodyAccJerk-std()-X"        "fBodyAccJerk-std()-Y"       
		[59] "fBodyAccJerk-std()-Z"        "fBodyGyro-std()-X"          
		[61] "fBodyGyro-std()-Y"           "fBodyGyro-std()-Z"          
		[63] "fBodyAccMag-std()"           "fBodyBodyAccJerkMag-std()"  
		[65] "fBodyBodyGyroMag-std()"      "fBodyBodyGyroJerkMag-std()"
		
Script with descriptions of performance:
	run_analysis.R
		# Script modules are separated by a blank line. The script performs 5 functions:
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


	
