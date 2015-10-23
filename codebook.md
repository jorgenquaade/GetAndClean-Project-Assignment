---
title: "codebook.md"
author: "jq"
date: "22. okt. 2015"
output: html_document
---
As can be seen when examing the data, and reading the documentation from the link above

Features contain a list of features measured. They can be used as the column names for the x_test and x_train datasets.

The subject_* tables lists the subject variable for each of the measurements in the x_* tables and must be column bind'ed together.

The y_* tables list the actvities performed for each of the measurements in the x_* tables and should likewise be column bind'ed together.

The full dataset then consist of the following columns: subject_* column 2 + y_* column 2 + all columns in x_* for a total of 563 columns in each dataset. This should be done for both the *_train and *_test datasets. The resulting datasets are named cbtest and cbtrain respectively.

Since the full *_train dataset contains the same columns as the full *_test dataset, they can easily be row binded together simply adding the test rows to the train rows, giving a total of 10299 rows. The merged dataset is called xMerged.

The columns selected from the full dataset are the columns with mean() and std() appearing in the name. They are selected manually as the various string matching functions all produced side effects including columns that are not a mean() or std() measurement. There are 66 columns fulfilling the requirement and hence we end up with a dataset with 68 columns and 10299 rows. The resulting dataset is called xMergedExtract.

For better "tidyness" the column containing the subject id's is labelled Subject and the column containing activity codes is labelled Activity. 

Instead of using integer identifiers, the descriptive labels in activity_labels are added as values in the Acticity column which then changes from an integer to a character column, further adding to the tidyness.

The tidydf dataset is the aggregate dataset with averages for the measurements for each subject/activity combination. Since there are 30 subjects and 6 activities the dataset contains 180 rows. The column names have been retained as it will add no value preceding each column name with "Mean of" or something similar. Suffice to say in the codebook that the number in the tidydf dataset are mean values of the values aggregated from the measurements of each subject/activity combination.

The tidydf dataset is ordered by activity rather than subject, but can easily be manipulated into other orderings. Since we don't know what it is going to be used for it makes no difference what the initial ordering is, as long as the data is tidy.