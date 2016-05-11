# Getting-and-Cleaning-Data


###Repository for the Assignment in the Coursera Course "Getting and Cleaning Data" as part of the data science specialisation offered by JHU


This assigmentment is broken into 5 parts. I have done them in order and clearly labelled each part in the run_analysis.R script. This readme explains what I am doing and the decisions I have made along the way

###Part 0

It isn't clear whether or not downloading the data is meant to be part of the assignment. I assume you have downloaded the data already. If you don't want to do it again, please copy the data to a folder called "data" in your working directory and comment out the lines in part 0

###Part 1 "Merges the training and the test sets to create one data set"

This part is relatively easy and just reads the test and train data in and uses cbind to add the appropriate activity and subject data in (as it is another variable), and uses rbind to stick them together. The resulting file is called alldata

###Part 2 "Extracts only the measurements on the mean and standard deviation for each measurement"

For this we need the variable names. They are in the second column of the features.txt file included in the datase. They are then made into the column names of alldata

From here there are several possible approaches, based on how you interpret the question and the phrase "each measurement". Does it mean we want the measurements of the sd in the X,Y and Z directions (which would mean looking for all column names that include either mean() or std())? Or only the mean and sd of the overall measurement(which would involve looking for only the column names that *end* in mean()or std())? Or does it mean all data that uses the words mean, for example the column angle(X, gravityMean)? I have interpreted this as the first way as it makes the most sense to me.

We then use the grep command to extract the required data. The resultant table called somedata. 

### Part 3 "Uses descriptive activity names to name the activities in the data set"

It's not clear which data set we are talking about. However I interpret it as using the orignal dataset alldata (because we got rid of the activity data in part 2). We want to rename the labels 1,2,3,4,5,6 in the activites column with the actual activities. We use the data in activity_labels to do this and merge it with alldata

### Part 4 "Appropriately labels the data set with descriptive variable names"

Here we want to label the data set with nicer labels. There are certain values, like t, that correspond to something more readable. We replace all of these values in the name of the columns of newdata. We are careful not to relace every instance of "t" with "time", however.

### Part 5 "From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject"

Here there are a few ways to do this. We could build a short wide dataset where the each row has a different activity/subject pair and each column had the mean of the variables in alldata, or we could have a tall skinny dataset where the columns are the differnet activity/subject pair and the rows are the different variables. I think either one comprises of tidy data, depending on your definition and what this table will be used for. I chose to do it the first way.

We use the function data.table from the data.table package. I assume you have it downloaded. If not, use download.package("data.table") to get it.



