# Getting and Cleaning Data - Course Project

## Overview
This repository contains the submission for the Coursera course **Getting and Cleaning Data**.  
The purpose of the project is to demonstrate the ability to collect, work with, and clean a data set.  
The end result is a tidy dataset that can be used for later analysis.

The data used in this project comes from the **Human Activity Recognition Using Smartphones Dataset**, collected from the accelerometers and gyroscopes of Samsung Galaxy S smartphones.  
More info: [UCI HAR Dataset](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

---

## Repository Contents
- **run_analysis.R** → Main R script that performs the full data processing pipeline.  
- **tidy_dataset.txt** → Output tidy dataset, created by the script.  
- **merged_dataset.txt** → Intermediate dataset with all merged training and test data (saved for reference).  
- **CodeBook.md** → Describes variables, data, and transformations performed.  
- **README.md** → Explains the repository, how the script works, and how everything is connected.

---

## How the Script Works
The script `run_analysis.R` performs the following steps:

1. **Download and unzip the dataset**  
   - Checks if the dataset archive `UCI HAR Dataset.zip` exists locally.  
   - If not, downloads it from the course URL and unzips it.  

2. **Load metadata and raw data**  
   - Loads `features.txt` (list of measurement variable names).  
   - Loads `activity_labels.txt` (mapping of activity IDs to descriptive names).  
   - Loads training data:  
     - `X_train.txt` → feature measurements.  
     - `y_train.txt` → activity IDs.  
     - `subject_train.txt` → subject IDs.  
   - Loads test data (`X_test.txt`, `y_test.txt`, `subject_test.txt`) in the same way.  

3. **Merge training and test sets**  
   - Combines training and test sets using `rbind()`.  
   - Creates a single dataset `merged_data` containing subject, activity, and all 561 features.  
   - Saves this dataset to `merged_dataset.txt`.  

4. **Extract mean and standard deviation measurements**  
   - Uses a regular expression (`grep("-(mean|std)\\(\\)")`) to select only the variables that are means or standard deviations.  
   - Keeps only `subject`, `activity`, and the selected variables.  

5. **Use descriptive activity names**  
   - Converts numeric activity codes into human-readable names (e.g., WALKING, SITTING).  

6. **Label dataset with descriptive variable names**  
   - Cleans up and expands variable names:  
     - Removes parentheses `()`.  
     - Replaces dashes `-` with underscores `_`.  
     - Expands abbreviations (`t` → `Time_`, `f` → `Freq_`, `Acc` → `Accelerometer`, etc.).  

7. **Create a tidy dataset**  
   - Groups data by `subject` and `activity`.  
   - Calculates the mean of each measurement variable within each group.  
   - The result is a tidy dataset with **180 rows** (30 subjects × 6 activities) and descriptive measurement columns.  
   - Saves this tidy dataset to `tidy_dataset.txt`.  

---

## How to Run
1. Open R (or RStudio).  
2. Make sure you have the **dplyr** package installed:
   ```r
   install.packages("dplyr")
