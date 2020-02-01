library(dplyr)

xtrain <- read.table("X_train.txt")
ytrain <- read.table("y_train.txt")
xtest <- read.table("X_test.txt")
ytest <- read.table("y_test.txt")

subject_train <- read.table("subject_train.txt")
subject_test <- read.table("subject_test.txt")

features <- read.table("features.txt")
activity_labels <- read.table("activity_labels.txt")

merged_df <- rbind(xtrain, xtest)

meanvar <- grep("mean()", features$V2)
stdvar <- grep("std()", features$V2)
allcol <- sort(c(meanvar,stdvar))
merged_df <- merged_df[, allcol]
subjects <- rbind(subject_train, subject_test)
ys <- rbind(ytrain, ytest)
merged_df <- cbind(subjects, ys, merged_df)

merged_df[, 2] <- activity_labels$V2[match(merged_df[, 2], activity_labels$V1)]

features$V2 <- as.character(features$V2)
f1 <- gsub("^[tT]", "Time",features$V2)
f1 <- gsub("^[fF]", "Freq",f1)
f1 <- gsub("\\()", "",f1)
f1 <- gsub("-", ".",f1)


first <- "Subject ID"
second <- "Activity Name"
third <- as.character(f1)[allcol]
names(merged_df) <- c(first, second, third)

merged_df <- group_by(merged_df, `Subject ID`, `Activity Name`)
merged_df <- summarize_all(merged_df, .funs = mean)

write.table(merged_df, "tidy_dataset.txt", row.names = F)

