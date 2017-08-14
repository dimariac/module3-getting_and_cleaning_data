=====================================================================
Code explanation.

- Data folder and files set up -
Initially, the code load the libraries that will be needed in the rest of the code.
These are the 'data.table' and 'dplyr' libraries.

Then, it checks if a folder called 'data' is in the working directory. If there is not,
the folder is created. Then it checks if the zip file containing the dataset is present in 
'data'. If not present, the zip file is downloaded. Finally, it checks if the folder 
'UCI HAR Dataset' is present, i.e. if the zip file has been unzipped. If not present, the 
file is unzipped inside 'data'. This means that the unzipped data files will eventually
be in './data/UCI HAR Dataset'.

- Data preparation -
The data is prepared sequentially following the five steps given in the project instructions.

Step 1 - Merge the training and test sets to create one dataset.
The training data set is read in from the "X.train.txt" file. The relative information
corresponding to the subject who performed each activity and the type of each activity
are also read in, respectively from "subject_train.txt" and "y_train.txt". All these data
are collated in one tbl structure called 'data_train'.
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
The corrspondence between activity id and activity name is takedn from the file 
"activity_labels.txt". The 6 activity names are utilised to create a lookup vector. 
The activity ids are then changed to activity names by indexing the lookup vector with
the second column of 'data_subset'.


Step 4 - Appropriately label the data set with descriptive variable names.
I created a vector 'var_names' containing the names to be given to the columns. The first
two names are 'subject_id' and 'activity_id'. The remaing 66 names are the 'feature_names'
identified at step 2. I did not modify the features names as I found they were already
well descriptive. In order to make them even more explicit, I would have needed to make 
the names longer. But in my epxerience I have found that very long variable or column
names become difficult to handle in the code. 
The column names of 'data_subset' were changed by assigning 'var_names' to 
colnames(data_subset)


Step 5 - From the dataset in step 4, create a second, idipenedent tidy dataset 
with the average of each variable for each activity and each subject.




=====================================================================
Variables description.
