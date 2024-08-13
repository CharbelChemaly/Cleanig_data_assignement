# Cleanig_data_assignement
This depositary contains my solution to the final assignment of the course "Getting and Cleaning Data"

The purpose is to clean up the Samsung data set to make it  a tidy data. 

I load the raw data for the test. This data frame contains 561 variables and no column names or IDs.
I also load the 2 data frames for IDs and activity, renaming them in an identifiable way.

To give the columns of the raw data their proper names, I load the file named "features" and then use it as a vector to attribute the col names.

After that, I select the column that have either mean() or std() in their name.I then merge this split data set with the ID and activity data sets. 

The same is performed for the data from the training. 

When I get the 2 data frames containing the IDs, activity, and measurements, I row bind them. This creates the merged_data.

Once that done, I change the activity column, from numbers to description of the activity. I do this with the mutate function.

Finally, I group the data by ID and activity, and create a data frame containing the mean of each observations by the defined groups.