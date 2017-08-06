## Function name: run_analysis
## Purpose: To combine and analyze Samsung Galaxy S smartphone accelerometer
##          data from tests
## Parameters:  (Req) - 
##           (Req) - 
## Returns: 
run_analysis <- function() {
    ##load necessary packages
    library(dplyr)
    library(tidyr)
    library(readr)
    
    ##load labels
    dataLabels <- read.delim("features.txt",header = FALSE, col.names = c("features")) %>% 
        separate("features",c("num","label"), sep = " ")
    activityLabels <- read.delim("activity_labels.txt",header = FALSE, col.names = c("activities")) %>% 
        separate("activities",c("num","label"), sep = " ")
    
    ##load and combine train data
    trainSub <- read.delim("train/subject_train.txt",sep = "", header = FALSE, col.names = c("subject"))
    trainActivity <- read.delim("train/y_train.txt",sep = "", header = FALSE, col.names = c("activity"))
    trainData <- read.delim("train/X_train.txt",sep = "", header = FALSE, col.names = dataLabels$label)
    
    trainCombined <- cbind(trainSub, trainActivity, select(trainData,matches('mean|std')))
    
    #load and combine test data
    testSub <- read.delim("test/subject_test.txt",sep = "", header = FALSE, col.names = c("subject"))
    testActivity <- read.delim("test/y_test.txt",sep = "", header = FALSE, col.names = c("activity"))
    testData <- read.delim("test/X_test.txt",sep = "", header = FALSE, col.names = dataLabels$label)
    
    testCombined <- cbind(testSub, testActivity, select(testData,matches('mean|std')))
    
    ##combine test and train data
    dataSet <- bind_rows(trainCombined,testCombined)
    
    ##remove periods from columns names
    ##change to lowercase
    colnames(dataSet) <- tolower(gsub("\\.+","",names(dataSet)))
    
    ##update activity name to a factor
    dataSet$activity <-as.factor(dataSet$activity)
    levels(dataSet$activity) <- activityLabels$label
    
    #summarize the mean for each measurment by subject and activity
    dataSet %>%
        group_by(subject, activity) %>%
        summarize_all(funs(mean)) %>%
        write.table(file = "dataSetOutput.txt",row.name=FALSE)
}
