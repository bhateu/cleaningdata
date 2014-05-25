CodeBook
==================

Use attached R file -- run_analysis.R
Read - Readme.md

Assumption -- the R file is in the same folder as the unzipped UCI HAR folder

Details of Data structures --
* the mearged data set should contain data from features data, subject data and activity data
* features data is loaded from X_train.txt and X_test.txt files
* Subject data is loaded from subject_train.txt and subject_test.txt
* Activity data is loaded from Y_train.txt and Y_test.txt
* Load the names of the features from the features.txt file
* features data contains several features; we will use only those features which have "mean" or "std" in their names
* load the activity names from the activity_labels.txt file


Details of the R script --

* read the data files
* read the features file
* in the loaded features data, find the rows and the feature names which have "mean" or "std" in them
* merge the data sets (use only the above selected features from the X_train and X_test data and leave aside the other data from those files)
* clear memory (better that way, than holding on to heavy data in RAM)
* change feature names -- to lower case and remove paranthesis and change "-" to "."
* read activity labels file
* change activity labels data -- as above, change to lower case and change "_" to "."
* apply activity labels to the respective columns in the merged dataset
* use melt and dcast functions to find averages
* write final dataset to file -- final_dataset.txt


