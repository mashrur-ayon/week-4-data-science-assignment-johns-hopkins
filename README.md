
 
This repository was created for the completion of the peer-graded assignment: 

> Course 3: Getting And Cleaning Data, Johns Hopkins University, Coursera. 



The assignment asked to:

> You will be required to submit: 
> 
>   1. a tidy data set as described below 
>   2. a link to a Github repository with your script for performing
       the analysis, and 
>   3. a code book that describes the variables, the data, and any
       transformations or work that you performed to clean up the data
       called CodeBook.md. 
> 
> You should also include a README.md in the repo with your scripts. 
> This repo explains how all of the scripts work and how they are connected. 

and for the main script, 'run_analysis.R' the requirements was that it should
be able to run, as far as the 'UCI HAR Dataset' is present in the working
directory and to be able to perform the following 5 steps:

> 1. Merges the training and the test sets to create one data set. 
> 2. Extracts only the measurements on the mean and standard deviation for
each measurement. 
> 3. Uses descriptive activity names to name the activities in the data set 
> 4. Appropriately labels the data set with descriptive variable names. 
> 5. From the data set in step 4, creates a second, independent tidy data set
with the average of each variable for each activity and each subject. 

*** 
# Details on the files that exist in this repository  
 

### README.md 
This is the general purpose readme file created during formation of the repository. 
 
### get_data.R 

This is the R script for downloading, unzipping and preparing the data. 
. 
 
### run_analysis.R 
 
It is the main script of the repository. 
The deatils are described in 'CodeBood.md':

    
### data_summary.txt 
 
The tidy dataset that was produced by the script 'run_analysis.txt',

The tidy dataset is presented in data_summary.txt

 
### CodeBook.md 

The code book contains informations on the total process.
