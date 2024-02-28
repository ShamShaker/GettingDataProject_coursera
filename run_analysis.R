library(tidyverse)

### Set the working directory in the next line

setwd("C:/Users/BusinessTim/Desktop/desktop files/Coursera/Course3/finalProject/GettingDataProject_coursera")

### context data---------------------

###create data frame for matching activity codes with activity names

training.types.key<-read_table("UCI HAR Dataset/activity_labels.txt", 
                               col_names = FALSE) %>%
  rename(activity.type.code=X1, 
         activity.type.name=X2)


### create dataframe containing the measurement/summary variable codes

column.names<-read_table("UCI HAR Dataset/features.txt", 
                            col_names = FALSE) %>%
  
  ## give the column names an easy-to-remember name
  rename(column.names=2) %>%
  
  ## keep only the column names 
  dplyr::select(column.names) %>%
  
  ## get rid of the ugly characters
  mutate(column.names=str_remove_all(column.names, '-'),
         column.names=str_remove_all(column.names, '\\('),
         column.names=str_remove_all(column.names, ','),
         column.names=str_remove_all(column.names, '\\)'))

#### compile the training data------------------------

## load the subject number codes 

train.subject <- read_table("UCI HAR Dataset/train/subject_train.txt", col_names = FALSE)

## load the activity code variable

activity.type.code.train <- read_table("UCI HAR Dataset/train/y_train.txt", col_names = FALSE)

## load the summarized measurements and attach the column names obtained above

compiled.train.data <- read_table("UCI HAR Dataset/train/X_train.txt", 
                                 col_names = column.names$column.names)%>% 
  
  ## retain only the columns with means or standard deviations (std)
  dplyr::select(contains('mean') | contains('std')) %>%
  
  ## create new variable: data set type
  mutate(data.type='train',
         
         ## append the subject code number and the activity type code
         subject=train.subject$X1,
         activity.type.code=activity.type.code.train$X1) %>%
  
  ## join the activity type name to dataframe
  left_join(training.types.key, by='activity.type.code') %>%
  
    ##re-order columns with identifying columns first
    dplyr::select(data.type, subject, activity.type.code, activity.type.name, 
                  tBodyAccmeanX:fBodyBodyGyroJerkMagstd)



### compile test data-----------------------------

## load the subject number codes 

test.subject <- read_table("UCI HAR Dataset/test/subject_test.txt", col_names = FALSE)

## load the activity code variable
      
activity.type.code.test <- read_table("UCI HAR Dataset/test/y_test.txt", col_names = FALSE)

## load the summarized measurements and attach the column names obtained above

compiled.test.data <- read_table("UCI HAR Dataset/test/X_test.txt", 
                     col_names = column.names$column.names)%>% 
  
  ## retain only the columns with means or standard deviations (std)
  dplyr::select(contains('mean') | contains('std')) %>%
  
   ## create new variable: data set type
  mutate(data.type='test',
         
 ## append the subject code number and the activity type code
         subject=test.subject$X1,
         activity.type.code=activity.type.code.test$X1) %>%
  
  ## join the activity type name to dataframe
  left_join(training.types.key, by='activity.type.code') %>%
  
  ##re-order columns with identifying columns first
  dplyr::select(data.type, subject, activity.type.code, activity.type.name, 
                tBodyAccmeanX:fBodyBodyGyroJerkMagstd)

### compiling training and test data

## bind the test and train data

all.mean.and.sd.data<-bind_rows(compiled.test.data, compiled.train.data) 

### create summary means for each subject per activity (and ignoring training/test status)

mean.subject.activity <- all.mean.and.sd.data %>%
  group_by(subject, activity.type.name) %>%
  dplyr::select(-c(data.type, activity.type.code)) %>%
  summarize_all(mean)

write.table(mean.subject.activity, 
            "MeanSubjectActivity.txt", 
            row.name=FALSE)





  
  
  
  
  



  





