PROGRAMMING ASSIGNMENT README
=============================

This repo stores files required for Programming Assignment on Coursera's "Getting and Cleaning Data" course:
* run_analysis.R
* README.md
* CodeBook.md

<b>run_analysis.R</b> is a R script used for cleaning and tidying the assignment data. The main steps of data processing are as follows:
<ol>1. reading the source data tables from "UCI HAR Dataset". Data from "Inertial Signals", according to tutors' advices on the forum, is omitted.</ol>
<ol>2. train_X and test_X datasets are bound by rows, then the column names are assigned.</ol>
<ol>3. filter removing all variables different that 'std' and 'mean' ones is used. We grep the column names and keep only those which have substring like 'mean' or 'std'.</ol>
<ol>4. subjects and activities data is merged to the main dataset, i.e. tab_X_mean_std object. activityLabel variable is kept as a factor.</ol>
<ol>5. library 'reshape2' is loaded in order to help in data tidying. First, the tab_X_mean_std is melted with id.vars set on 'subject' and 'activityLabel'. Then, the tidying is done with dcast function.</ol>

All script's activities are commented in the code body, also.

<b>CodeBook.md</b> is a data dictionary for tidy_data.txt dataset. It collects some basic information on the dataset structure, as well as on origin of the data. The variables' meaning and formats are given. Links to sites and documents with more detailed information are provided.

The output file, i.e. <b>tidy_data.txt</b>, is loaded into the Coursera's site (according to Assignment instructions). The file can be obtained also via running the run_analysis.R script. It will be written in the working directory, and can be loaded into R by submitting read.table("tidy_data.txt", header=TRUE, check.names=FALSE).