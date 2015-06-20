# Course-Project-Getting-and-Cleaning-Data
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