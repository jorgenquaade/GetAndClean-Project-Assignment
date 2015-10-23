## Needed libraries are read in in the console window. Correct order is Library(plyr) and library(dplyr)
## If the library commands get executed in the script R complains about the order in which they are read in

## reading in the raw data for examination

features <- read.table("~/DataScience/GetandClean/project/data/features.txt", quote="\"", comment.char="")

activity_labels <- read.table("~/DataScience/GetandClean/project/data/activity_labels.txt", quote="\"", comment.char="")

subject_test <- read.table("~/DataScience/GetandClean/project/data/test/subject_test.txt", quote="\"", comment.char="")
subject_train <- read.table("~/DataScience/GetandClean/project/data/train/subject_train.txt", quote="\"", comment.char="")

x_test <- read.table("~/DataScience/GetandClean/project/data/test/X_test.txt", quote="\"", comment.char="")
x_train <- read.table("~/DataScience/GetandClean/project/data/train/X_train.txt", quote="\"", comment.char="")

y_test <- read.table("~/DataScience/GetandClean/project/data/test/y_test.txt", quote="\"", comment.char="")
y_train <- read.table("~/DataScience/GetandClean/project/data/train/y_train.txt", quote="\"", comment.char="")

## 1. Merge the training and the test sets to create one data set
##
## Before the merge of the datasets I'll add columnnames to the datatables
## as it can easily be achieved before adding more columns to the base tables
## Also merging the subject_* columns to the base tables is easier before the
## row merge as the number of rows match with the base tables

## Adding column names from features
colnames(x_test) <- as.character(features[,2])
colnames(x_train) <- as.character(features[,2])

## Renaming subject_test column V2 to Subject. Person would be more polite
## but we'll stick with the more clinical Subject

colnames(subject_test) <- c("Subject")
colnames(subject_train) <- c("Subject")

## renaming the activity column in y_test and y_train

colnames(y_test) <- c("Activity")
colnames(y_train) <- c("Activity")

## Merging the subject_* and activity (y_*) columns with the base tables

cbtest <- cbind(subject_test, y_test, x_test)
cbtrain <- cbind(subject_train, y_train, x_train)

## Row binding the datasets to merge them

xMerged <- rbind.data.frame(cbtrain, cbtest)

## 2. Extract only the measurements on the mean and standard deviation for each measurement
## I have chosen to do this by hand since the various string matching choices produces an outcome
## with unexpected columns included. I only want to select the columns that contains
## the strings "mean()" and "std()" in the latter part of the column name. Other occurences 
## of mean and std as strings are not included

xMergedExtract <- xMerged[,c(1:8,43:48,83:88,123:128,163:168,203:204,216:217,229:230,242:243,255:256,268:273,347:352,426:431,505:506,518:519,531:532,544:545)]

## 3. Use descriptive activity names to name the activities in the data set
## This is simply adding the descriptive labels from activity_labels instead of
## numbers. Coloumn need to be transformed to character first though

xMergedExtract <- transform(xMergedExtract, Activity = as.character(Activity))

xMergedExtract$Activity <- mapvalues(xMergedExtract$Activity, c(1,2,3,4,5,6), c("Walking", "WalkingUpstairs", "WalkingDownstairs", "Sitting", "Standing", "Laying"))

## 4. Appropriately label the data set with descriptive variable names. 
## This step was accomplished a little earlier as it was easier to code

## 5. From the data set in step 4, create a second, independent tidy data set with the
## average of each variable for each activity and each subject.

## Create sorted data set
tmp <- xMergedExtract[order(xMergedExtract$Subject, xMergedExtract$Activity),]

## Create new tidy dataset with averages for each subject/activity combination
## Using the aggregate function gives a very elegant solution

tidydf <- aggregate(. ~ Subject+Activity,data = tmp,FUN=function(x) c(mn =mean(x)) )

## Writing the table to a file with write.table() using row.name=FALSE

write.table(tidydf, file = "tidydata.txt", row.name=FALSE)
