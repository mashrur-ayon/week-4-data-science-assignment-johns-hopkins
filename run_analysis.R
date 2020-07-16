

# DESCRIPTION: The script 'run_analysis.R' follows strictly the instruction
#              given by assignment, in a simple straightforward way.
#                 0. Loads the data in R.
#              Then 5 main steps are executed in order.
#                 1. Merges the training and the test sets
#                    to create one data set.
#                 2. Extracts only the measurements on the mean
#                    and standard deviation for each measurement.
#                 3. Uses descriptive activity names
#                    to name the activities in the data set.
#                 4. Appropriately labels the data set
#                    with descriptive variable names.
#                 5. From the data set in step 4,
#                    creates a second, independent tidy data set
#                    with the average of each variable
#                    for each activity and each subject.

# RESULT:   The result is to create the 'data_summary' data table
#           with the average values for the target features,
#           which is saved as 'tidy_data_summary.txt' in the working directory.
#          
#           The resulting data table, can be loaded in R,
#           with correct variable names, classes and values by the command:
#
#           tidy_data_summary <- read.table(file = "data_summary.txt",
#                                           header = TRUE, check.names = FALSE,
#                                           dec = ".") 
#
#           or for faster loading:

#           tidy_data_summary <- read.table(file  = "data_summary.txt",
#                                           header = TRUE, check.names = FALSE,
#                                           dec = ".",
#                                           colClasses = c("numeric", "factor",
#                                                          "rep("numeric", 66)),
#                                           nrows = 180,
#                                           comments.char = "", quote = "") 
#          
#           Details on the 'data_summary' table can be found,
#           at 'CodeBook.md' that exist in the Git Hub, from the link:
#           "https://github.com/jzstats/Getting-and-Cleaning-Data-Assignment/blob/master/CodeBook.md"
#





library(dplyr)





read.table_instructions <- list(
      
      file = list(
            activity_labels = "UCI HAR Dataset/activity_labels.txt",
            features = "UCI HAR Dataset/features.txt",
            subject_train = "UCI HAR Dataset/train/subject_train.txt",
            y_train = "UCI HAR Dataset/train/y_train.txt",
            X_train = "UCI HAR Dataset/train/X_train.txt",
            subject_test = "UCI HAR Dataset/test/subject_test.txt",
            y_test = "UCI HAR Dataset/test/y_test.txt",
            X_test = "UCI HAR Dataset/test/X_test.txt"
      ),
     
      colClasses = list(
            activity_labels = c("integer", "character"),
            features = c("integer", "character"),
            subject_train = "integer",
            y_train = "integer",
            X_train = rep("numeric", 561),
            subject_test = "integer",
            y_test = "integer",
            X_test = rep("numeric", 561)
      ),
      
      nrows = list(
            activity_labels = 6,
            features = 561,
            subject_train = 7352,
            y_train = 7352,
            X_train = 7352,
            subject_test = 2947,
            y_test = 2947,
            X_test = 2947
      )
)


data_files <- with(read.table_instructions,
                   Map(read.table,
                       file = file, colClasses = colClasses, nrows = nrows,
                       quote = "", comment.char = "",
                       stringsAsFactors = FALSE))

message("    ...data files were successfully loaded into R, \n",
        "       in the list with name 'data_files'.")




################################################################################
# STEP 1: Merges the data to create one data set.
################################################################################


merged_data <- with(data_files,
                    rbind(cbind(subject_train, y_train, X_train),
                          cbind(subject_test,  y_test,  X_test)))




################################################################################
# STEP 2: Extracts the mean and standard deviation.
################################################################################


target_features_indexes <- grep("mean\\(\\)|std\\(\\)",
                                data_files$features[[2]])


target_variables_indexes <- c(1, 2, # the first two columns that refer to
                              # 'subject' and 'activity'
                              # should be included
                              # adds 2 to correct the indexes
                              # of target features indexes because of
                              # the 2 extra columns we have included
                              target_features_indexes + 2)

target_data <- merged_data[ , target_variables_indexes]




################################################################################
# STEP 3: naming the activities in data set
################################################################################


target_data[[2]] <- factor(target_data[[2]],
                           levels = data_files$activity_labels[[1]],
                           labels = data_files$activity_labels[[2]])




################################################################################
# STEP 4: labeling the data set
################################################################################


descriptive_variable_names <- data_files$features[[2]][target_features_indexes]


descriptive_variable_names <- gsub(pattern = "BodyBody", replacement = "Body",
                                   descriptive_variable_names)

tidy_data <- target_data
names(tidy_data) <- c("subject", "activity", descriptive_variable_names)




################################################################################
# STEP 5: Clearing the data and forming a tidy one.
################################################################################


data_summary <- tidy_data %>%
      group_by(subject, activity) %>%
      summarise_all(funs(mean)) %>%
      ungroup()


new_names_for_summary <- c(names(data_summary[c(1,2)]),
                           paste0("Avrg-", names(data_summary[-c(1, 2)])))
names(data_summary) <- new_names_for_summary

## Save the data as a text file.
write.table(data_summary, "data_summary.txt", row.names = FALSE)




