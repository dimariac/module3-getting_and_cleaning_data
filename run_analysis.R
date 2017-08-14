# Author: Costanzo Di Maria
# Last revision: 14/08/2017
#
# This function performes the data preparation for the final project of the Data Science Course,
# MOdule 3, Getting and Cleaning Data.



run_analysis <- function(){

        # Data folder and files set up.
        
        # Import libraries that will be used in the script.
        library(data.table)
        library(dplyr)
        
        
        # URL address of zip file containing the dataset
        fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        
        # Download data if not present yet
        dataMainFolder <- "./data"
        zipFilename <- "samsungData.zip"
        zipDest <- file.path(dataMainFolder, zipFilename)
        if (!file.exists(dataMainFolder)){
                dir.create(dataMainFolder)
        } 
        if (!file.exists(zipDest)){
                  download.file(fileUrl, destfile=zipDest)
        }
        
        # Unzip file if needed
        dataFolder <- file.path(dataMainFolder, "UCI HAR Dataset")
        if (!file.exists(dataFolder)){
                unzip(zipDest, exdir=dataMainFolder)
        }
        
        
        
        # Step 1. Merge the training and test sets to create one dataset.
        
        # Set up folder names.
        trainFolder <- file.path(dataFolder, "train")
        testFolder <- file.path(dataFolder, "test")
        
        # Import data from the training dataset.
        subject_train <- data.table(read.table(file.path(trainFolder, "subject_train.txt")))
        activity_train <- data.table(read.table(file.path(trainFolder, "y_train.txt")))
        record_train <- data.table(read.table(file.path(trainFolder, "X_train.txt")))
        
        # Combine subject list, activity list, and records in one single table for the trainig dataset.
        data_train <- data.table(subject_train, activity_train, record_train)
        
        # Import data from the test dataset.
        subject_test <- data.table(read.table(file.path(testFolder, "subject_test.txt")))
        activity_test <- data.table(read.table(file.path(testFolder, "y_test.txt")))
        record_test <- data.table(read.table(file.path(testFolder, "X_test.txt")))
        
        # Combine subject list, activity list, and records in one single table for the test dataset.
        data_test <- data.table(subject_test, activity_test, record_test)
        
        # Combine training and test datasets.
        data <- rbind(data_train, data_test)
        
        
        
        # Step 2. Extract only the measurements on the mean and standard deviation for each measurement.
        
        # Load variable names from file "features.txt".
        # NOTE: As I will be using this data within grep function, data.frame is easier to utilise in this case compared to data.table.
        featureFile <- file.path(dataFolder, "features.txt")
        feature_data <- read.table(featureFile, colClasses=c("numeric", "character"))
        
        # Exctract names of features with mean() or std(). This will be useful in subsequent step 4.
        feature_names <- grep("mean\\(\\)|std\\(\\)", feature_data[, 2], value=TRUE)
        
        # Extract positions of above names. The +2 is needed because the first two columns
        # of 'data' are subject_id and activity_id.
        feature_positions <- c(1, 2, grep("mean\\(\\)|std\\(\\)", feature_data[, 2])+2)
        
        # Select columns of 'data' which correspond to mean() and std().
        # NOTE: 'with=FALSE' is required to work with numeric vector indicating columns to select.
        data_subset <- data[, feature_positions, with=FALSE]
        
        
        
        # Step 3. Use descriptive activity names to name the activities in the data set.
        
        # Activity labels taken from file "activity_labels.txt".
        activity1 <- "WALKING"
        activity2 <- "WALKING_UPSTAIRS"
        activity3 <- "WALKING_DOWNSTAIRS"
        activity4 <- "SITTING"
        activity5 <- "STANDING"
        activity6 <- "LAYING"
        activity_lookup <- c(activity1, activity2, activity3, activity4, activity5, activity6)
        
        # Index the look-up vector 'activity_lookup' with the vector (column 2 of 'data_subset')
        # containing the numeric IDs, and the job is done!
        # NOTE: This only works with data.frame, but not with data.table.
        data_subset[, 2] <- activity_lookup[data.frame(data_subset)[, 2]]
        
        
        
        # Step 4. Appropriately label the data set with descriptive variable names.
        
        # Create vector of column names using 'feature_names' extraced at step 2.
        # Remember that I have added two columns at the beginnig for 'subject_id' and 'activity_id'.
        var_names <- c("subject_id", "activity_id", feature_names)
        
        # Replace column names in 'data_subset'.
        colnames(data_subset) <- var_names
        
        
        
        # Step 5. From the dataset in step 4, create a second, indepenedent tidy dataset 
        # with the average of each variable for each activity and each subject.
        data_summary <- data_subset %>% group_by(activity_id, subject_id) %>%
                summarise_all(mean, na.rm=TRUE)
        
        
        # Return dataset from step 5.
        data_summary
}