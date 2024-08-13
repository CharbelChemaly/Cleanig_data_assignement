library(readr)
library(plyr)
library(dplyr)
library(tidyr)
library(stringr)

##stwd(....) to set the working directory. The following code will only work
##if the files are in the working directory

##Loading the raw data from the test
test_results <- read_table("test/X_test.txt", 
                           col_names = FALSE)

##Loading the corresponding IDs and activities
ID <- read_csv("test/subject_test.txt", col_names = FALSE)
ID <- rename(ID, ID = X1)

activity <- read_csv("test/y_test.txt", 
                     col_names = FALSE)
activity <- rename(activity, activity = X1)

##Loading the list of names so that I can assign the proper column names
list_name <- read_table("features.txt", 
                        col_names = FALSE, col_types = cols(X1 = col_skip()))
##Assigning names
colnames(test_results) <- list_name$X2

##Selecting the columns with mean or std in them
test_mean_std <- select(test_results, contains("mean()"), 
                        contains("std()"))

##Merging the results, the IDs and the activity
final_test_data <- cbind(ID, activity, test_mean_std)


##The same is done for the train data

subject_train <- read_csv("train/subject_train.txt", 
                          col_names = FALSE)
subject_train <- rename(subject_train, ID = X1)


activity_train <- read_csv("train/y_train.txt", 
                           col_names = FALSE)
activity_train <- rename(activity_train, activity = X1)

training_raw_results <- read_table("train/X_train.txt", 
                                   col_names = FALSE)


colnames(training_raw_results) <- list_name$X2

train_mean_std <- select(training_raw_results, contains("mean()"), 
                         contains("std()"))

##Merging the results, the IDs and the activity
final_train_data <- cbind(subject_train, activity_train, train_mean_std)

##Merge the two data frames
merged_data <- rbind(final_test_data, final_train_data)


##Giving names to the activities

merged_data <- merged_data %>%
  mutate(activity = recode(activity,
                           `1` = "Walking",
                           `2` = "Walking_upstairs",
                           `3` = "Walking_dowstairs",
                           `4` = "Sitting",
                           `5` = "Standing",
                           `6` = "Landing")) %>% 
print()


##Grouping the data
grouped_data <- group_by(merged_data, ID, activity)

tidy_data <- summarise_all(grouped_data, mean)

##Creating the text file
write.table(tidy_data, file="tidy_data.txt", row.names = FALSE)
