### Initial data set and the problem description

Course assignment is using the data set collected during the experiment of creating the learning algorythm, which assignes labels with corresponding activities performed by a human wearing the measurement device, based on the sensors data from the device.

"The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data." [1]

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

### Inintial data preprocessing of data set
1. Load the labels which marks different human activities
2. lod the features names to use it as a column names in the resulting data set
3. creates the subset of all features just with those which represents mean and standard deviation
4. load trainset, using features names as a column names and filtering out everything which is not in subset created on (3) step
5. adding the activity label to each measurement of training data set
6. adding subject to each measurement of training data set
7. repeat steps (4) - (6) for the test set
8. merge training set and test set

### Aggregation, performed on the data set
1. Melt the data set retrieved after preprocessing by activity and subject vriables. This will create a base for aggregating the data grouped by this variables using mean aggregation function
2. Aggregate the data using mean aggregation funtion in order to receive average for each variable in the data set for the activity and subject
