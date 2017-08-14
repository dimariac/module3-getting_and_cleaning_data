# module3-getting_and_cleaning_data
Data Science Course Module 3: Getting and Cleaning Data. Final project.

======================================================================
Author: Costanzo Di Maria.
14/08/2017


=====================================================================
Project overview.
This project utilises the Human Activity Recognition Using Smartphone Dataset version 1.0.
The original data is available at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
A comprehensive description of the raw data is available in the "README.txt" file contained in the zip folder above.


Starting from the raw data set above, the project instructions required to:

Step 1. Merge the training and the test sets to create one data set.

Step 2. Extract only the measurements on the mean and standard deviation for each measurement.

Step 3. Use descriptive activity names to name the activities in the data set.

Step 4. Appropriately label the data set with descriptive variable names.

Step 5. From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and
each subject.


The characteristics of a tidy data set are:

1) Each variable forms a column.
2) Each observation forms a row.
3) Each type of observational unit forms a table.
[References: course material and Wickham H., "Tidy Data", Journal of Statistical Software, issue 10, volume 59, August 2014.]


====================================================================
Repo content.
This repo contains three files as required in the project instructions:

1 - "run_analyisis.R" contains the R code which performs the analysis as required in the five steps of the instructions.
2 - "CodeBook.md" describes the variables, the data, and any transformations or work that I performed to clean up the data.
3 - "README.md" this file.


=====================================================================
Code instructions.
The solution I have provided is organised in one file only, "run_analysis.R".
After you source the code, you have one function available called run_analysis().

All you have to do is to call this function from the command line, it does not need any input arguments.
The function returns the data set as described at step 5 of instructions. The data set returned is tidy because 
it satisifies the three characteristics of a tidy data set.

Further details about the code implementation are given in the file "CodeBook.md", along with a description of 
the variables contained in the data set.
