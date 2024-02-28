# GettingDataProject_coursera

Data describing motion characteristics, such as acceleration in the X, Y, and Z axes for 30 participants engaging in various activities like walking were obtained from accelerometers and gyroscopes from Samsung Galaxy S II. The data files are avialble here:

            https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The raw data were provided, but summary data for a variety of features, such as means of body acceleration were provided in the data cited below. The data are also split into training and test sets. The subject names, their activity types, and the feature names are, however, not contained in a single file requiring their assembly (and some mild to moderate cleaning).

This gitHub page describes the project to obtain, clean, compile, and summarize these data.

My work here assembled the processed 'features' data, along with the subject and activity identifiers, into a single coherent data file identifying the value of the feature/summary variable for each subject and each activity, and the use of said data in the training or testing set. A final summary file ('MeanSubjectActivity.txt') is also provided which shows the means of the feature variables for each subject and activity.

The codebook describes the data in detail, inlcuidng helpful tips on the contents of the various files you will need (and the ones you can ignore).

The 'run_analysis.R' script includes the code to obtain, clean, compile, and summarize the data using the Tidyverse. This code has been heavily annotated and describes all of the steps to meet the requirements of the project described here:

      https://www.coursera.org/learn/data-cleaning/peer/FIZtT/getting-and-cleaning-data-course-project.

Thanks for reading.

Sham.

  
