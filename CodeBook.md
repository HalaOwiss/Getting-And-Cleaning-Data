# CodeBook for Tidy Dataset

## Data Source
This project uses the **Human Activity Recognition Using Smartphones Dataset**, collected from the accelerometers and gyroscopes of Samsung Galaxy S smartphones.

Original dataset:  
[UCI HAR Dataset](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

## Variables in the Tidy Dataset
The tidy dataset `tidy_dataset.txt` contains the following variables:

1. **subject**  
   - Integer identifier for the subject (range: 1–30).  
   - Represents the individual who performed the activity.

2. **activity**  
   - Factor with six levels:  
     - WALKING  
     - WALKING_UPSTAIRS  
     - WALKING_DOWNSTAIRS  
     - SITTING  
     - STANDING  
     - LAYING  

3. **Measurement variables**  
   - Averages of the selected mean and standard deviation features from the original dataset.  
   - Each variable name is descriptive, following these conventions:  
     - Prefix **Time_**: time domain signals (originally prefixed with "t").  
     - Prefix **Freq_**: frequency domain signals (originally prefixed with "f").  
     - **Accelerometer**, **Gyroscope**, **Magnitude**: indicate the signal type.  
     - Suffixes `_X`, `_Y`, `_Z`: axis of measurement.  
     - `_mean` and `_std`: represent mean and standard deviation values.  

   Example variables:  
   - `Time_BodyAccelerometer_mean_X`  
   - `Time_BodyAccelerometer_std_Z`  
   - `Freq_BodyGyroscope_mean_X`  
   - `Freq_BodyAccelerometerMagnitude_std`  

## Transformations Performed
1. Downloaded and unzipped the raw dataset.  
2. Read in **training** and **test** sets and merged them into one dataset.  
3. Extracted only the measurements on the mean and standard deviation (using `grep("-(mean|std)\\(\\)")`).  
4. Applied descriptive activity names using `activity_labels.txt`.  
5. Cleaned variable names to make them more descriptive:  
   - Removed parentheses `()` and replaced dashes `-` with underscores `_`.  
   - Replaced abbreviations with full words:  
     - `t` → `Time_`  
     - `f` → `Freq_`  
     - `Acc` → `Accelerometer`  
     - `Gyro` → `Gyroscope`  
     - `Mag` → `Magnitude`  
6. Created a tidy dataset by grouping by `subject` and `activity`, and calculating the mean of each variable.  
