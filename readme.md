Project instructions: include a README.md in the repo describing how the script works.

The basis approach in the script is to pull in the data, explore, refine and the implement the code.  

The datasets were pulled done from the GettingCleaning project link and place in a directory on my dropbox.  The directory structure of the download was not changed from that of UCI HAR dataset. 

After reading the feature.txt file, I explore a number of grep options related to "mean" and "std" and look at the features a bit.

I then tidy up the feature names a little. 

It then create my feature subsets using the broadest scope on mean and std starting with the training set.

I subset the data using the 86 features that conformed with my grep subset and at the cleaned feature names.  Then I do the same subset procedure to the smaller test set.

The next step is to link activity names as factor levels to the y_train file which is a list of 7352 numeric subject activities.  I call this variable activities.  Then I do the same thing to the test activities.  Note, I left the activities uppercase because I may latter plot the data and like the uppercase for plotting.

Similarly I assembled first the training and then the test subject number data.frames naming them "mysubjects" and "mytestsubjects" respectively.  These I cbind to the main test and train datasets after creating vectors to keep track of the observation type (test, or train).  I cbind these together and now have data.frames "mytest" and "mytrain".

Rbinding these together as wearable1, I archive it to disk as a 10299 X 89 file "wearabel.txt". 

The next part of the assignment was to creates a second, independent tidy data set with the average of each variable for each activity and each subject. Here, I called the plyr, dplyr and reshape2 packages and melted the data into a lengthy 885714 X 5 data.frame consisting of variables "subjectid" "activity"  "obstype"   "variable"  "value" .  Then I used "group_by function to cast the data into similarly-sized dataframe and the summarized the data by average variable value by subject and activity (avevarbysubj_activity).  This dataset is called "tidywearable" has the dimensions 15460X4 and was uploaded as the text file "tidywearable.txt" to Coursera.