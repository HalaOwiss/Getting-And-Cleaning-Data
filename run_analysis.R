# run_analysis.R

library(dplyr)

# 1. Download and unzip dataset if not already available
filename <- "UCI HAR Dataset.zip"
if (!file.exists(filename)) {
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, filename, method="curl")
}
if (!file.exists("UCI HAR Dataset")) {
  unzip(filename)
}

# 2. Load data
features <- read.table("UCI HAR Dataset/features.txt")
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("id", "activity"))

# Training data
x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "activity")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")

# Test data
x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "activity")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")

# 3. Merge training and test sets
X <- rbind(x_train, x_test)
Y <- rbind(y_train, y_test)
Subjects <- rbind(subject_train, subject_test)

# 4. Assign column names
colnames(X) <- features[,2]
merged_data <- cbind(Subjects, Y, X)

# Save merged dataset
write.table(merged_data, "merged_dataset.txt", row.name=FALSE)

mean_std_features <- grep("-(mean|std)\\(\\)", features[,2])  # indices
selected_data <- merged_data[, c(1, 2, mean_std_features + 2)] 

selected_data$activity <- factor(selected_data$activity, 
                                 levels = activity_labels$id, 
                                 labels = activity_labels$activity)


names(selected_data) <- gsub("\\()", "", names(selected_data))   # remove ()
names(selected_data) <- gsub("-", "_", names(selected_data))     # replace - with _
names(selected_data) <- gsub("^t", "Time_", names(selected_data))
names(selected_data) <- gsub("^f", "Freq_", names(selected_data))
names(selected_data) <- gsub("Acc", "Accelerometer", names(selected_data))
names(selected_data) <- gsub("Gyro", "Gyroscope", names(selected_data))
names(selected_data) <- gsub("Mag", "Magnitude", names(selected_data))


tidy_data <- selected_data %>%
  group_by(subject, activity) %>%
  summarise_all(mean)


write.table(tidy_data, "tidy_dataset.txt", row.name=FALSE)


