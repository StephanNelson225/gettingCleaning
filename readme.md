Dataset

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

For each record in the dataset it is provided: 
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration. 
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.


mean(x), y, z were main subset elements that resulted in
they also had std. 








http://www.cs.ubc.ca/~nando/540-2013/projects/p6.pdf






The dataset used in this project is the Human Activity Recognition Using Smartphones 
public dataset, made available at the Machine Learning Repository of the University of 
California Irvine. The data was collected by experimentation with a group of 30 volunteers.
46 With a Samsung Galaxy smartphone attached at the waist, each volunteer performed six different activities: standing, walking straight, walking up stairs, walking down stairs, sitting, and laying.

Each smartphone's (gyroscope and accelerometer) provides 
outputs on 3 axes.  After this cleaning, the time series data underwent up to of 16 different types of processing, 
depending on the variable in question. Some of the processing types were quite basic, 
namely the mean, standard deviation, maximum, and minimum. By spanning the time series 
data of a single sensor reading, this results in features like ”tBodyAcc-mean()-X”, denoting 
the mean of acceleration of the volunteer’s body on axis X over the given window. This is 
distinguished from, for example, the gravity component, or the standard deviation, or readings on axis Y. 

 The signals prefixed with “t” are over the time domain, whereas the “f”-
prefixed signals are frequency domain signals obtained by performing a Fast Fourier 
Transform on the respective time-domain signal. By applying the functions above to the 
signals below, we obtain signals like “tBodyAccJerk-correlation()-X,Z” and “fBodyGyro-
maxInds-Y”. Those with “XYZ” denote a separate signal exists for each axis. Once all this 
processing is done, each data row has a total of 561 features

The dataset, as it comes, is already split into training and testing portions. The data gatherers 
141 split the volunteers 70% / 30% into training/testing sets. Due to a somewhat variable amount 
142 of data gathered per volunteer, the resulting data split is not exactly that amount. Of the total 
143 10,301 data points, 7353 are from the training set volunteers, and 2948 are from the testing 
144 set volunteers (approximately a 71.38% / 28.62% split). This structure of separation makes 
145 sense because it clearly compartmentalizes any volunteer-based biases that occur in the data. 
146 The advantage of this is that the test data is not “polluted” by training data. Indeed, if the 
147 training and test data both came from the same sources, then they would not differ 
148 significantly, and this could lead to an artificially inflated measurement of the accuracy of 
149 the machine learning system. The way the data has been collected ensures that a more-
150 realistic degree of difference between the training data and test data is present, so that the 
151 degree of accuracy achieved is likely to continue. 