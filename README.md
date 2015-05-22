Read the following files from the working directory
* features.txt - contains the names of the measures recorded by the devices
* act_labels - contains activity number to description mapping for 6 distinct activities

Calculate the indexes of the measures we care about. These include std and mean.  meanfreq is excluded.

For each subdirectory (test and train), do the following
* Read x_[test|train].txt - data file
* y_[test|train].txt - activity being beasured for corresponding observation in the x file
* subject_[test|train].txt - subject perofrming activity for corresponding observation in the x file
* Assign column names to each file
* trim the data file to the columns calculated that we care about
* CBind the data frames for the y file, subject and x file into one data frame
* Merge in activity names gathered from features.txt
* Final data frame for test set is data_file_merged_test, train is data_file_merged_train

Final Steps
* Rbind the two data_file_merged scripts into data_file_merged
* Use aggregate function to determine the mean values accross activity and subject
* Write the file to WearableComputing.txt
