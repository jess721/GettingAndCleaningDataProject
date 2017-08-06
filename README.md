# GettingAndCleaningDataProject
Files to process data files and create clean data set for Getting and Cleaning Data project

The R script run_analysis.R assumes it is ran with the files from here unzipped in your working directory: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The script performs the following steps on the data:
1. A dataframe is created for both the train and test data. Those are created by (this is for the train dataset -- everything also applies to the test dataset, but replace 'train' with 'test'):  
	1. Column 1 is set as the "subject" and is loaded from the train/subject_train.txt file.  
	2. Column 2 is set as the "activity" and is loaded from the train/y_train.txt file.  
	3. The values in column 2 are set as a factor with the label activity name based on the values in the activity_labels.txt file.  
 	4. Columns 3-88 are:  
 		1. Loaded from the train/X_train.txt file.  
		2. The labels for these columns come from the features.txt file.  
		3. Only columns that contain "mean" or "std" are added to the data set.  
		4. The loaded names are made all lower case and the periods are removed.  
2. After both the train and test data are loaded, they are combined into one data set.  
3. The dataset is then grouped by participant and then activity, and the mean is calculated for every variable.  
4. The grouped, summarized output is then stored to a file dataSetOutput.txt in the working directory.  

