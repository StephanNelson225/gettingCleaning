This Codebook that describes the variables, the data, and any transformations or work that you performed to clean up the data.

**The Data**

The dataset includes the following files:

- 'features_info.txt': Provides a description of the features and how the features were collected and derived.

- 'activity_labels.txt': Links the class labels with their activity name:  WALKING, WALKING_UPSTAIRS WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING

- 'train/X_train.txt': Training set of 7352 rows and 561 columns.

- 'train/y_train.txt': Training labels to link the activity labels to the features.  Length 7352.

- 'test/X_test.txt': Test set.  2947 rows, 561 columns

- 'test/y_test.txt': Test labels to link the activity lables to the features.  Length 2947

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

The Inertial Signals data set was not needed for this project.

The training data had a dimension of 561 columns representing the features and 7352 rows of observations.
The test data had a dimension of 561 columns representing the features and 2941 rows of observations. 

**The Variables**

The 561 variables as described in features_info.txt included accelerometer and gyroscope 3-axial raw signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

mean(): Mean value
std(): Standard deviation
mad(): Median absolute deviation 
max(): Largest value in array
min(): Smallest value in array
sma(): Signal magnitude area
energy(): Energy measure. Sum of the squares divided by the number of values. 
iqr(): Interquartile range 
entropy(): Signal entropy
arCoeff(): Autorregresion coefficients with Burg order equal to 4
correlation(): correlation coefficient between two signals
maxInds(): index of the frequency component with largest magnitude
meanFreq(): Weighted average of the frequency components to obtain a mean frequency
skewness(): skewness of the frequency domain signal 
kurtosis(): kurtosis of the frequency domain signal 
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

gravityMean
tBodyAccMean
tBodyAccJerkMean
tBodyGyroMean
tBodyGyroJerkMean


**Data Cleaning and Refinement**

Several steps were taken to refine the data.  First, the analysis was limited to mean and standard deviation data. So conditions for subsetting the data needed to be established.  After exploring possible combinations of strings with the grep command, the most reasonable combination was determined to be a grep of all variables (feature names) that contained "mean" (without regard to case) and "std".  This resulted in a subset of 86 variables, 53 related to mean and 33 related to std.

Further procession was done on the feature names.  The main goal was to clear out errors and to reduce the use some shift key strokes while not causing the potential for confusion.  


- The gsub function was used to get rid of a mistake that doubled up the word "body" in a few variables;
- The tolower funtion was used to change every letter to lower case.
- The "-" mark was eliminated and the text collapsed.
- The "()" combination was replaced with the "_".

No actual words were changed based on the assumption that the variable names contained information meaningful to those who were deep into this data.  The resultant variable names were:

tbodyaccmean_x, tbodyaccmean_y, tbodyaccmean_z, tbodyaccstd_x, tbodyaccstd_y, tbodyaccstd_z, tgravityaccmean_x, tgravityaccmean_y, tgravityaccmean_z, tgravityaccstd_x, tgravityaccstd_y, tgravityaccstd_z, tbodyaccjerkmean_x, tbodyaccjerkmean_y, tbodyaccjerkmean_z, tbodyaccjerkstd_x, tbodyaccjerkstd_y, tbodyaccjerkstd_z, tbodygyromean_x, tbodygyromean_y, tbodygyromean_z, tbodygyrostd_x, tbodygyrostd_y, tbodygyrostd_z, tbodygyrojerkmean_x, tbodygyrojerkmean_y, tbodygyrojerkmean_z, tbodygyrojerkstd_x, tbodygyrojerkstd_y, tbodygyrojerkstd_z, tbodyaccmagmean_, tbodyaccmagstd_, tgravityaccmagmean_, tgravityaccmagstd_, tbodyaccjerkmagmean_, tbodyaccjerkmagstd_, tbodygyromagmean_, tbodygyromagstd_, tbodygyrojerkmagmean_, tbodygyrojerkmagstd_, fbodyaccmean_x, fbodyaccmean_y, fbodyaccmean_z, fbodyaccstd_x, fbodyaccstd_y, fbodyaccstd_z, fbodyaccmeanfreq_x, fbodyaccmeanfreq_y, fbodyaccmeanfreq_z, fbodyaccjerkmean_x, fbodyaccjerkmean_y, fbodyaccjerkmean_z, fbodyaccjerkstd_x, fbodyaccjerkstd_y, fbodyaccjerkstd_z, fbodyaccjerkmeanfreq_x, fbodyaccjerkmeanfreq_y, fbodyaccjerkmeanfreq_z, fbodygyromean_x, fbodygyromean_y, fbodygyromean_z, fbodygyrostd_x, fbodygyrostd_y, fbodygyrostd_z, fbodygyromeanfreq_x, fbodygyromeanfreq_y, fbodygyromeanfreq_z, fbodyaccmagmean_, fbodyaccmagstd_, fbodyaccmagmeanfreq_, fbodyaccjerkmagmean_, fbodyaccjerkmagstd_, fbodyaccjerkmagmeanfreq_, fbodygyromagmean_, fbodygyromagstd_, fbodygyromagmeanfreq_, fbodygyrojerkmagmean_, fbodygyrojerkmagstd_, fbodygyrojerkmagmeanfreq_, angle(tbodyaccmean,gravity), angle(tbodyaccjerkmean),gravitymean), angle(tbodygyromean,gravitymean), angle(tbodygyrojerkmean,gravitymean), angle(x,gravitymean), angle(y,gravitymean), angle(z,gravitymean)  

A couple of variables were added.  First a variable  (obstype) reflecting whether the data was from the test or training set.  And the subject number variable was named "subjectid."