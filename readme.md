Project instructions: include a README.md in the repo describing how the script works.

The basic approach in the script is to pull in the data, explore, refine and the implement the code.  

The datasets were pulled done from the GettingCleaning project link and placed in a directory on my dropbox.  The directory structure of the download was not changed from that of UCI HAR dataset. 

As a first step major files were rbind and cbind together before subsetting the feature names.  These included the test and training files including data, subjects and activity codes.  Activity names were applied to the appropriate codes as factors.


It then create my feature subsets using the broadest scope on mean() and std().  This selects 66 variables.  More could be selected but these 66 seem like the core variables and the others are more peripheral.  

I then tidy up the feature names a little and then add them as variable names to the main data. 


Rbinding these together as wearable, I archive it to disk as a 10299 X 68 file "wearable.txt". 

The next part of the assignment was to creates a second, independent tidy data set with the average of each variable for each activity and each subject. Here, I called the plyr, dplyr and reshape2 packages and melted the data into a lengthy 679734 X 4 data.frame consisting of variables "subjectid" "activity"  "variable"  "value" .  Then I used "group_by function to cast the data into similarly-sized dataframe and the summarized the data by average variable value by subject and activity (avevarbysubj_activity).  This dataset is called "tidywearable" has the dimensions 15460X4 and was uploaded as the text file "tidywearable.txt" to Coursera.

**Run script**

To run this script, use RStudio.  open a new file in your Project working directory, copy and paste this text into that file.  Be sure that the data files are in the appropriate sub-directories.  Install the packages required and it should work.