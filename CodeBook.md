# module3-getting_and_cleaning_data
Data Science Course Module 3: Getting and Cleaning Data. Final project.

======================================================================
Author: Costanzo Di Maria.
14/08/2017



=====================================================================
Code explanation.

- Data folder and files set up -
Initially, the code load the libraries that will be needed in the rest of the code.
These are the 'data.table' and 'dplyr' libraries.

Then, it checks if a folder called 'data' is in the working directory. If it is not,
the folder is created. Then it checks if the zip file containing the dataset is present in 
'data'. If not present, the zip file is downloaded. Finally, it checks if the folder 
'UCI HAR Dataset' is present, i.e. if the zip file has been unzipped. If not present, the 
file is unzipped inside 'data'. This means that the unzipped data files will eventually
be in './data/UCI HAR Dataset'.

- Data preparation -
The data is prepared sequentially following the five steps given in the project instructions.

Step 1 - Merge the training and test sets to create one dataset.
The training data set is read in from the "X_train.txt" file. The relative information
corresponding to the subject who performed each activity and the type of activity
are also read in, respectively from "subject_train.txt" and "y_train.txt". All these data
are collated into one tbl structure called 'data_train'.
The same process is performed for the test set, and all data are collated in the 
'data_test' tbl variable.
The 'data_train' and 'data_test' are combined together using rbind. The entire data set
is called simply 'data'.

Step 2 - Extract only the measurements on the mean and standard deviation for each measurement.
The 561 feature names are read in from the "features.txt" file. I interpreted this step as
selecting all features whose name contain the string "mean()" or "std()". I solved this problem
by utilising the grep function and regular expressions to extract the list of feature names
satisfying the requirements (variable 'feature_names') and their positions (variable 
'feature_positions'), corresponding to the indices of which columns of 'data' should be kept. 
Note that +2 should be added to these positions due to the fact that the first two columns
of 'data' are the subject and activity ids. A total of 66 features were identified.
The features containing mean or std are then selected by subsetting 'data' using the indices
in 'feature_positions'. The resulting variable is called 'data_subset', which contains 68
columns, subject id + activity id + 66 features.

Step 3 - Use descriptive activity names to name the activities in the data set.
The corrspondence between activity id and activity name is taken from the file 
"activity_labels.txt". The 6 activity names are utilised to create a lookup vector. 
The activity ids are then changed to activity names by indexing the lookup vector with
the second column of 'data_subset'.

Step 4 - Appropriately label the data set with descriptive variable names.
I created a vector 'var_names' containing the names to be given to the columns. The first
two names are 'subject_id' and 'activity_id'. The remaing 66 names are the 'feature_names'
identified at step 2. I did not modify the feature names as I found they were already
well descriptive. In order to make them even more explicit, I would have needed to make 
the names longer. But in my epxerience I have found that very long variable or column
names become difficult to handle in the code. 
The column names of 'data_subset' were changed by assigning 'var_names' to 
colnames(data_subset).

Step 5 - From the dataset in step 4, create a second, indepenedent tidy dataset 
with the average of each variable for each activity and each subject.
To solve this problem, I utilised the dplyr package and the %>% operator. The
data were grouped by 'activity_id' and 'subject_id' using the group_by function. 
Averages for each resulting group were calculated using the summarise_all function.
The resulting tbl is called 'data_summary' and this is the only variable returned by the fucntion,
as required by the instructions.
'data_summary' is also a tidy data set because it satisfies the three characteristics:

1) each variable forms a columns
2) each observation froms a row
3) each type of observational unit forms a table



=====================================================================
Variables description.
Each observation / entry of the returned table provides the mean value for a given feature (column name)
across all records of the same activity type for each subject.
The features are as described in "feature_info.txt".

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time
domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and
a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then
separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a
corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and
tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag,
tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag).

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ,
fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals).

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

For each of the signals above, the mean() and std()  vales are returned by run_analysis().
