---
title: "readme"
author: "jq"
date: "22. okt. 2015"
output: html_document
---
A full description of the datasets provided for the exercise can be found here:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The codebook can be found in the same directory as this file and is named codebook.md.

Needed libraries are read in in the console window. Correct order is library(plyr) and library(dplyr). If the library commands get executed in the script R may complain about the order in which they are read in since the script may be executed multiple times, hence I have taken them out.

All commands for reading, manipulating, and writing the data are in the run_analysis.R script.

First data is read in in order to examine them and find out which id match, row counts etc. 

Then meaningful column names are added to the subject_* and y_* datasets. This is not the exact order suggested in the exercise but it was just simpler code to write and understand. 

The cbind and rbind functions are used to produce a full dataset.

Then order is used to group data according to subject and activity.

The activity labels are added to the Activity columns giving meaningful names to the values in the column instead of the integer values. 

Finally, the aggregate function is used to calculate the mean of the values for the rows with the same subject/activity combination.

See the run_analysis.R script for full commands and explanations and the codebook.md for more descriptions of data and teh choices made when naming columns etc.