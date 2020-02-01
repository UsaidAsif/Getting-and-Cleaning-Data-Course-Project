    # This is the .Rmd file, please see the .md file of the codebook to see the rendered version on github.

Introduction
------------

This is the codebook markdown file providing various details of the
project and was made using the guidelines provided in the Getting and
Cleaning Data course project of the Data Science Specialization.

Data Collection and Processing
------------------------------

### Collection of the raw data

The dataset to be used in the project was taken from the link
<a href="https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip" class="uri">https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip</a>,
and it was unzipped to access the required files. For the purposes of
the project, only the files named “activity\_labels.txt”,
“features.txt”, “features\_info.txt”, “subject\_test.txt”,
“X\_test.txt”, y\_test.txt“,”subject\_train.txt“,”X\_train.txt“,
y\_train.txt” were used.

Detailed Steps to Create the Tidy Dataset
-----------------------------------------

1.  First the data was read using the read.table command. This resulted
    in all the relevant data frames to be used in further analysis.
2.  Since we weere required to merge the training and test sets so using
    the rbind command, the relevant fata frames were merged.
3.  Next we needed only the measurements on all the mean and std
    variables, hence using the grep command the regex pattern “mean()”
    and “std()” were used on the second column of the “features.txt”
    file to grab all the columns/features containing the mean and std
    code words.
4.  The sort command was used to combine all the mean and std column
    names in an ascending manner.
5.  Next we took the data frame created in step 2, and grabbed from it
    all the columns (along with all of its rows) that were sorted in
    ascending order in step 4. This resulted in all the required columns
    for the project.
6.  Both the subjects’ file and the ys’ file were merged together, in
    each of their own separate files.
7.  The command cbind was used to combine the files created in 6th step
    with the data frame of the 5th step. This resulted in additional
    required columns/features for the project.
8.  To replace the activity numbers with the activity names, the match
    command was used. All of the relevant matches from the 2nd column of
    the data frame of the 7th step in the “activity\_labels” data
    frame’s first column were passed to the “activity\_labels” data
    frame’s to extract the relevant activity name, and thus this new
    column was used to replace the old 2nd column of the 7th step data
    frame.
9.  Next to clean and thus for appropriate naming of all the features of
    our data frame, first the features data frame’s 2nd column was
    converted to character (to avoid potential problems with working on
    factors) and then a series of gsub commands were used to have
    cleaner names of the features.
10. Next we picked all the columns which had mean() or std() in their
    names from the data frame of the 9th step and then passed their new
    names to our data frame. Thus now our data frame had appropriate
    names (the 1st and 2nd column was also renamed to “Subject ID” and
    “Activity Name”).
11. To create our final data frame, and to do step 5 of the course
    project, the data frame was grouped by “Subject ID”, and “Activity
    Name” and then used the summarize\_all command, passing in the
    grouped data frame and the mean function. This excluded the grouped
    variables so mean function was not applied to the “Subject ID” and
    “Activity Name” columns but on all of the other columns. This gives
    our average of each variable for each activity and each subject.
    This resulted in the tidy set required in the project.

Information on the Variables
----------------------------

-   Abbreviations used in analysis:

Acc: Acceleration, Std: Standard Deviation, Gyro: Gyroscope, Mag:
Magnitude, Freq: Frequency.

-   All variables which have “Time” as a prefix means that they indicate
    the time domain signals whereas all variables which have “Freq” as a
    prefix indicate that they are in the frequency domain obtained by
    applying the Fast Fourier Transform to the signals.
-   All variables which contains “Body” in their names indicates that
    the signal represents the body component of the specific
    acceleration measurements for the specified individual and the
    specific activity and variables which contains “gravity” indicates
    it represents the gravity component of the specific acceleration
    measurements for the specified individual and the specific activity.
-   All variables which contains “Acc” indicates that the signals had
    come from the accelerometer and those which contain “Gyro” indicates
    that the signals had come from the gyroscope.
-   Variables which contains “jerk” indicates that the body linear
    acceleration and angular velocity were derived in time to obtain
    these Jerk signals for the specified individual and the specific
    activity.
-   Variables which contains “Mag” in their names represents that those
    values were obtained after calculating the Euclidean norm of the
    signals.

<!-- -->

    df4 <- read.csv("codebook variables info.csv", check.names = F)
    #print(df4)
    knitr::kable(df4)

<table>
<thead>
<tr class="header">
<th style="text-align: left;">Variable Name</th>
<th style="text-align: left;">Class</th>
<th style="text-align: left;">Units</th>
<th style="text-align: left;">Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: left;">Subject ID</td>
<td style="text-align: left;">integer</td>
<td style="text-align: left;">None</td>
<td style="text-align: left;">The ID indicates specific individual who performed the prescribed activity, its value ranges form 1 to 30 since there were 30 individuals in the analysis.</td>
</tr>
<tr class="even">
<td style="text-align: left;">Activity Name</td>
<td style="text-align: left;">factor</td>
<td style="text-align: left;">None</td>
<td style="text-align: left;">The specific activity name which was performed by the individual and whose data was recorded in the analysis, there are a total of 6 activities which were performed by the various individuals, namely “walking”, “walking upstairs”, “walking downstairs”, “sitting”, “standing”, “laying”.</td>
</tr>
<tr class="odd">
<td style="text-align: left;">TimeBodyAcc.mean.X</td>
<td style="text-align: left;">numeric</td>
<td style="text-align: left;">m/s^2</td>
<td style="text-align: left;">The mean value obtained for all the 128 signals in the X axis.</td>
</tr>
<tr class="even">
<td style="text-align: left;">TimeBodyAcc.mean.Y</td>
<td style="text-align: left;">numeric</td>
<td style="text-align: left;">m/s^2</td>
<td style="text-align: left;">The mean value obtained for all the 128 signals in the Y axis.</td>
</tr>
<tr class="odd">
<td style="text-align: left;">TimeBodyAcc.mean.Z</td>
<td style="text-align: left;">numeric</td>
<td style="text-align: left;">m/s^2</td>
<td style="text-align: left;">The mean value obtained for all the 128 signals in the Z axis.</td>
</tr>
<tr class="even">
<td style="text-align: left;">TimeBodyAcc.std.X</td>
<td style="text-align: left;">numeric</td>
<td style="text-align: left;">m/s^2</td>
<td style="text-align: left;">The standard deviation obtained for all the 128 signals in the X axis.</td>
</tr>
<tr class="odd">
<td style="text-align: left;">TimeBodyAcc.std.Y</td>
<td style="text-align: left;">numeric</td>
<td style="text-align: left;">m/s^2</td>
<td style="text-align: left;">The standard deviation obtained for all the 128 signals in the Y axis.</td>
</tr>
<tr class="even">
<td style="text-align: left;">TimeBodyAcc.std.Z</td>
<td style="text-align: left;">numeric</td>
<td style="text-align: left;">m/s^2</td>
<td style="text-align: left;">The standard deviation obtained for all the 128 signals in the Z axis.</td>
</tr>
<tr class="odd">
<td style="text-align: left;">TimeGravityAcc.mean.X</td>
<td style="text-align: left;">numeric</td>
<td style="text-align: left;">m/s^2</td>
<td style="text-align: left;">The mean value obtained for all the 128 signals in the X axis.</td>
</tr>
<tr class="even">
<td style="text-align: left;">TimeGravityAcc.mean.Y</td>
<td style="text-align: left;">numeric</td>
<td style="text-align: left;">m/s^2</td>
<td style="text-align: left;">The mean value obtained for all the 128 signals in the Y axis.</td>
</tr>
<tr class="odd">
<td style="text-align: left;">TimeGravityAcc.mean.Z</td>
<td style="text-align: left;">numeric</td>
<td style="text-align: left;">m/s^2</td>
<td style="text-align: left;">The mean value obtained for all the 128 signals in the Z axis.</td>
</tr>
<tr class="even">
<td style="text-align: left;">TimeGravityAcc.std.X</td>
<td style="text-align: left;">numeric</td>
<td style="text-align: left;">m/s^2</td>
<td style="text-align: left;">The standard deviation obtained for all the 128 signals in the X axis.</td>
</tr>
<tr class="odd">
<td style="text-align: left;">TimeGravityAcc.std.Y</td>
<td style="text-align: left;">numeric</td>
<td style="text-align: left;">m/s^2</td>
<td style="text-align: left;">The standard deviation obtained for all the 128 signals in the Y axis.</td>
</tr>
<tr class="even">
<td style="text-align: left;">TimeGravityAcc.std.Z</td>
<td style="text-align: left;">numeric</td>
<td style="text-align: left;">m/s^2</td>
<td style="text-align: left;">The standard deviation obtained for all the 128 signals in the Z axis.</td>
</tr>
<tr class="odd">
<td style="text-align: left;">TimeBodyAccJerk.mean.X</td>
<td style="text-align: left;">numeric</td>
<td style="text-align: left;">m/s^2</td>
<td style="text-align: left;">The mean value obtained for all the 128 signals in the X axis.</td>
</tr>
<tr class="even">
<td style="text-align: left;">TimeBodyAccJerk.mean.Y</td>
<td style="text-align: left;">numeric</td>
<td style="text-align: left;">m/s^2</td>
<td style="text-align: left;">The mean value obtained for all the 128 signals in the Y axis.</td>
</tr>
<tr class="odd">
<td style="text-align: left;">TimeBodyAccJerk.mean.Z</td>
<td style="text-align: left;">numeric</td>
<td style="text-align: left;">m/s^2</td>
<td style="text-align: left;">The mean value obtained for all the 128 signals in the Z axis.</td>
</tr>
<tr class="even">
<td style="text-align: left;">TimeBodyAccJerk.std.X</td>
<td style="text-align: left;">numeric</td>
<td style="text-align: left;">m/s^2</td>
<td style="text-align: left;">The standard deviation obtained for all the 128 signals in the X axis.</td>
</tr>
<tr class="odd">
<td style="text-align: left;">TimeBodyAccJerk.std.Y</td>
<td style="text-align: left;">numeric</td>
<td style="text-align: left;">m/s^2</td>
<td style="text-align: left;">The standard deviation obtained for all the 128 signals in the Y axis.</td>
</tr>
<tr class="even">
<td style="text-align: left;">TimeBodyAccJerk.std.Z</td>
<td style="text-align: left;">numeric</td>
<td style="text-align: left;">m/s^2</td>
<td style="text-align: left;">The standard deviation obtained for all the 128 signals in the Z axis.</td>
</tr>
<tr class="odd">
<td style="text-align: left;">TimeBodyGyro.mean.X</td>
<td style="text-align: left;">numeric</td>
<td style="text-align: left;">m/s^2</td>
<td style="text-align: left;">The mean value obtained for all the 128 signals in the X axis.</td>
</tr>
<tr class="even">
<td style="text-align: left;">TimeBodyGyro.mean.Y</td>
<td style="text-align: left;">numeric</td>
<td style="text-align: left;">m/s^2</td>
<td style="text-align: left;">The mean value obtained for all the 128 signals in the Y axis.</td>
</tr>
<tr class="odd">
<td style="text-align: left;">TimeBodyGyro.mean.Z</td>
<td style="text-align: left;">numeric</td>
<td style="text-align: left;">m/s^2</td>
<td style="text-align: left;">The mean value obtained for all the 128 signals in the Z axis.</td>
</tr>
<tr class="even">
<td style="text-align: left;">TimeBodyGyro.std.X</td>
<td style="text-align: left;">numeric</td>
<td style="text-align: left;">m/s^2</td>
<td style="text-align: left;">The standard deviation obtained for all the 128 signals in the X axis.</td>
</tr>
<tr class="odd">
<td style="text-align: left;">TimeBodyGyro.std.Y</td>
<td style="text-align: left;">numeric</td>
<td style="text-align: left;">m/s^2</td>
<td style="text-align: left;">The standard deviation obtained for all the 128 signals in the Y axis.</td>
</tr>
<tr class="even">
<td style="text-align: left;">TimeBodyGyro.std.Z</td>
<td style="text-align: left;">numeric</td>
<td style="text-align: left;">m/s^2</td>
<td style="text-align: left;">The standard deviation obtained for all the 128 signals in the Z axis.</td>
</tr>
<tr class="odd">
<td style="text-align: left;">TimeBodyGyroJerk.mean.X</td>
<td style="text-align: left;">numeric</td>
<td style="text-align: left;">m/s^2</td>
<td style="text-align: left;">The mean value obtained for all the 128 signals in the X axis.</td>
</tr>
<tr class="even">
<td style="text-align: left;">TimeBodyGyroJerk.mean.Y</td>
<td style="text-align: left;">numeric</td>
<td style="text-align: left;">m/s^2</td>
<td style="text-align: left;">The mean value obtained for all the 128 signals in the Y axis.</td>
</tr>
<tr class="odd">
<td style="text-align: left;">TimeBodyGyroJerk.mean.Z</td>
<td style="text-align: left;">numeric</td>
<td style="text-align: left;">m/s^2</td>
<td style="text-align: left;">The mean value obtained for all the 128 signals in the Z axis.</td>
</tr>
<tr class="even">
<td style="text-align: left;">TimeBodyGyroJerk.std.X</td>
<td style="text-align: left;">numeric</td>
<td style="text-align: left;">m/s^2</td>
<td style="text-align: left;">The standard deviation obtained for all the 128 signals in the X axis.</td>
</tr>
<tr class="odd">
<td style="text-align: left;">TimeBodyGyroJerk.std.Y</td>
<td style="text-align: left;">numeric</td>
<td style="text-align: left;">m/s^2</td>
<td style="text-align: left;">The standard deviation obtained for all the 128 signals in the Y axis.</td>
</tr>
<tr class="even">
<td style="text-align: left;">TimeBodyGyroJerk.std.Z</td>
<td style="text-align: left;">numeric</td>
<td style="text-align: left;">m/s^2</td>
<td style="text-align: left;">The standard deviation obtained for all the 128 signals in the Z axis.</td>
</tr>
<tr class="odd">
<td style="text-align: left;">TimeBodyAccMag.mean</td>
<td style="text-align: left;">numeric</td>
<td style="text-align: left;">m/s^2</td>
<td style="text-align: left;">The mean value obtained after calculating the euclidean norm of all the signals in each of the axis (mean of the 3 euclidean norms).</td>
</tr>
<tr class="even">
<td style="text-align: left;">TimeBodyAccMag.std</td>
<td style="text-align: left;">numeric</td>
<td style="text-align: left;">m/s^2</td>
<td style="text-align: left;">The standard deviation obtained after calculating the euclidean norm of all the signals in each of the axis (standard deviation of the 3 euclidean norms).</td>
</tr>
<tr class="odd">
<td style="text-align: left;">TimeGravityAccMag.mean</td>
<td style="text-align: left;">numeric</td>
<td style="text-align: left;">m/s^2</td>
<td style="text-align: left;">The mean value obtained after calculating the euclidean norm of all the signals in each of the axis (mean of the 3 euclidean norms).</td>
</tr>
<tr class="even">
<td style="text-align: left;">TimeGravityAccMag.std</td>
<td style="text-align: left;">numeric</td>
<td style="text-align: left;">m/s^2</td>
<td style="text-align: left;">The standard deviation obtained after calculating the euclidean norm of all the signals in each of the axis (standard deviation of the 3 euclidean norms).</td>
</tr>
<tr class="odd">
<td style="text-align: left;">TimeBodyAccJerkMag.mean</td>
<td style="text-align: left;">numeric</td>
<td style="text-align: left;">m/s^2</td>
<td style="text-align: left;">The mean value obtained after calculating the euclidean norm of all the signals in each of the axis (mean of the 3 euclidean norms).</td>
</tr>
<tr class="even">
<td style="text-align: left;">TimeBodyAccJerkMag.std</td>
<td style="text-align: left;">numeric</td>
<td style="text-align: left;">m/s^2</td>
<td style="text-align: left;">The standard deviation obtained after calculating the euclidean norm of all the signals in each of the axis (standard deviation of the 3 euclidean norms).</td>
</tr>
<tr class="odd">
<td style="text-align: left;">TimeBodyGyroMag.mean</td>
<td style="text-align: left;">numeric</td>
<td style="text-align: left;">m/s^2</td>
<td style="text-align: left;">The mean value obtained after calculating the euclidean norm of all the signals in each of the axis (mean of the 3 euclidean norms).</td>
</tr>
<tr class="even">
<td style="text-align: left;">TimeBodyGyroMag.std</td>
<td style="text-align: left;">numeric</td>
<td style="text-align: left;">m/s^2</td>
<td style="text-align: left;">The standard deviation obtained after calculating the euclidean norm of all the signals in each of the axis (standard deviation of the 3 euclidean norms).</td>
</tr>
<tr class="odd">
<td style="text-align: left;">TimeBodyGyroJerkMag.mean</td>
<td style="text-align: left;">numeric</td>
<td style="text-align: left;">m/s^2</td>
<td style="text-align: left;">The mean value obtained after calculating the euclidean norm of all the signals in each of the axis (mean of the 3 euclidean norms).</td>
</tr>
<tr class="even">
<td style="text-align: left;">TimeBodyGyroJerkMag.std</td>
<td style="text-align: left;">numeric</td>
<td style="text-align: left;">m/s^2</td>
<td style="text-align: left;">The standard deviation obtained after calculating the euclidean norm of all the signals in each of the axis (standard deviation of the 3 euclidean norms).</td>
</tr>
<tr class="odd">
<td style="text-align: left;">FreqBodyAcc.mean.X</td>
<td style="text-align: left;">numeric</td>
<td style="text-align: left;">Hz</td>
<td style="text-align: left;">The mean value obtained for all the 128 signals in the X axis.</td>
</tr>
<tr class="even">
<td style="text-align: left;">FreqBodyAcc.mean.Y</td>
<td style="text-align: left;">numeric</td>
<td style="text-align: left;">Hz</td>
<td style="text-align: left;">The mean value obtained for all the 128 signals in the Y axis.</td>
</tr>
<tr class="odd">
<td style="text-align: left;">FreqBodyAcc.mean.Z</td>
<td style="text-align: left;">numeric</td>
<td style="text-align: left;">Hz</td>
<td style="text-align: left;">The mean value obtained for all the 128 signals in the Z axis.</td>
</tr>
<tr class="even">
<td style="text-align: left;">FreqBodyAcc.std.X</td>
<td style="text-align: left;">numeric</td>
<td style="text-align: left;">Hz</td>
<td style="text-align: left;">The standard deviation obtained for all the 128 signals in the X axis.</td>
</tr>
<tr class="odd">
<td style="text-align: left;">FreqBodyAcc.std.Y</td>
<td style="text-align: left;">numeric</td>
<td style="text-align: left;">Hz</td>
<td style="text-align: left;">The standard deviation obtained for all the 128 signals in the Y axis.</td>
</tr>
<tr class="even">
<td style="text-align: left;">FreqBodyAcc.std.Z</td>
<td style="text-align: left;">numeric</td>
<td style="text-align: left;">Hz</td>
<td style="text-align: left;">The standard deviation obtained for all the 128 signals in the Z axis.</td>
</tr>
<tr class="odd">
<td style="text-align: left;">FreqBodyAcc.meanFreq.X</td>
<td style="text-align: left;">numeric</td>
<td style="text-align: left;">Hz</td>
<td style="text-align: left;">The mean value obtained for all the 128 signals in the X axis.</td>
</tr>
<tr class="even">
<td style="text-align: left;">FreqBodyAcc.meanFreq.Y</td>
<td style="text-align: left;">numeric</td>
<td style="text-align: left;">Hz</td>
<td style="text-align: left;">The mean value obtained for all the 128 signals in the Y axis.</td>
</tr>
<tr class="odd">
<td style="text-align: left;">FreqBodyAcc.meanFreq.Z</td>
<td style="text-align: left;">numeric</td>
<td style="text-align: left;">Hz</td>
<td style="text-align: left;">The mean value obtained for all the 128 signals in the Z axis.</td>
</tr>
<tr class="even">
<td style="text-align: left;">FreqBodyAccJerk.mean.X</td>
<td style="text-align: left;">numeric</td>
<td style="text-align: left;">Hz</td>
<td style="text-align: left;">The mean value obtained for all the 128 signals in the X axis.</td>
</tr>
<tr class="odd">
<td style="text-align: left;">FreqBodyAccJerk.mean.Y</td>
<td style="text-align: left;">numeric</td>
<td style="text-align: left;">Hz</td>
<td style="text-align: left;">The mean value obtained for all the 128 signals in the Y axis.</td>
</tr>
<tr class="even">
<td style="text-align: left;">FreqBodyAccJerk.mean.Z</td>
<td style="text-align: left;">numeric</td>
<td style="text-align: left;">Hz</td>
<td style="text-align: left;">The mean value obtained for all the 128 signals in the Z axis.</td>
</tr>
<tr class="odd">
<td style="text-align: left;">FreqBodyAccJerk.std.X</td>
<td style="text-align: left;">numeric</td>
<td style="text-align: left;">Hz</td>
<td style="text-align: left;">The standard deviation obtained for all the 128 signals in the X axis.</td>
</tr>
<tr class="even">
<td style="text-align: left;">FreqBodyAccJerk.std.Y</td>
<td style="text-align: left;">numeric</td>
<td style="text-align: left;">Hz</td>
<td style="text-align: left;">The standard deviation obtained for all the 128 signals in the Y axis.</td>
</tr>
<tr class="odd">
<td style="text-align: left;">FreqBodyAccJerk.std.Z</td>
<td style="text-align: left;">numeric</td>
<td style="text-align: left;">Hz</td>
<td style="text-align: left;">The standard deviation obtained for all the 128 signals in the Z axis.</td>
</tr>
<tr class="even">
<td style="text-align: left;">FreqBodyAccJerk.meanFreq.X</td>
<td style="text-align: left;">numeric</td>
<td style="text-align: left;">Hz</td>
<td style="text-align: left;">The mean value obtained for all the 128 signals in the X axis.</td>
</tr>
<tr class="odd">
<td style="text-align: left;">FreqBodyAccJerk.meanFreq.Y</td>
<td style="text-align: left;">numeric</td>
<td style="text-align: left;">Hz</td>
<td style="text-align: left;">The mean value obtained for all the 128 signals in the Y axis.</td>
</tr>
<tr class="even">
<td style="text-align: left;">FreqBodyAccJerk.meanFreq.Z</td>
<td style="text-align: left;">numeric</td>
<td style="text-align: left;">Hz</td>
<td style="text-align: left;">The mean value obtained for all the 128 signals in the Z axis.</td>
</tr>
<tr class="odd">
<td style="text-align: left;">FreqBodyGyro.mean.X</td>
<td style="text-align: left;">numeric</td>
<td style="text-align: left;">Hz</td>
<td style="text-align: left;">The mean value obtained for all the 128 signals in the X axis.</td>
</tr>
<tr class="even">
<td style="text-align: left;">FreqBodyGyro.mean.Y</td>
<td style="text-align: left;">numeric</td>
<td style="text-align: left;">Hz</td>
<td style="text-align: left;">The mean value obtained for all the 128 signals in the Y axis.</td>
</tr>
<tr class="odd">
<td style="text-align: left;">FreqBodyGyro.mean.Z</td>
<td style="text-align: left;">numeric</td>
<td style="text-align: left;">Hz</td>
<td style="text-align: left;">The mean value obtained for all the 128 signals in the Z axis.</td>
</tr>
<tr class="even">
<td style="text-align: left;">FreqBodyGyro.std.X</td>
<td style="text-align: left;">numeric</td>
<td style="text-align: left;">Hz</td>
<td style="text-align: left;">The standard deviation obtained for all the 128 signals in the X axis.</td>
</tr>
<tr class="odd">
<td style="text-align: left;">FreqBodyGyro.std.Y</td>
<td style="text-align: left;">numeric</td>
<td style="text-align: left;">Hz</td>
<td style="text-align: left;">The standard deviation obtained for all the 128 signals in the Y axis.</td>
</tr>
<tr class="even">
<td style="text-align: left;">FreqBodyGyro.std.Z</td>
<td style="text-align: left;">numeric</td>
<td style="text-align: left;">Hz</td>
<td style="text-align: left;">The standard deviation obtained for all the 128 signals in the Z axis.</td>
</tr>
<tr class="odd">
<td style="text-align: left;">FreqBodyGyro.meanFreq.X</td>
<td style="text-align: left;">numeric</td>
<td style="text-align: left;">Hz</td>
<td style="text-align: left;">The mean value obtained for all the 128 signals in the X axis.</td>
</tr>
<tr class="even">
<td style="text-align: left;">FreqBodyGyro.meanFreq.Y</td>
<td style="text-align: left;">numeric</td>
<td style="text-align: left;">Hz</td>
<td style="text-align: left;">The mean value obtained for all the 128 signals in the Y axis.</td>
</tr>
<tr class="odd">
<td style="text-align: left;">FreqBodyGyro.meanFreq.Z</td>
<td style="text-align: left;">numeric</td>
<td style="text-align: left;">Hz</td>
<td style="text-align: left;">The mean value obtained for all the 128 signals in the Z axis.</td>
</tr>
<tr class="even">
<td style="text-align: left;">FreqBodyAccMag.mean</td>
<td style="text-align: left;">numeric</td>
<td style="text-align: left;">Hz</td>
<td style="text-align: left;">The mean value obtained after calculating the euclidean norm of all the signals in each of the axis (mean of the 3 euclidean norms).</td>
</tr>
<tr class="odd">
<td style="text-align: left;">FreqBodyAccMag.std</td>
<td style="text-align: left;">numeric</td>
<td style="text-align: left;">Hz</td>
<td style="text-align: left;">The standard deviation obtained after calculating the euclidean norm of all the signals in each of the axis (standard deviation of the 3 euclidean norms).</td>
</tr>
<tr class="even">
<td style="text-align: left;">FreqBodyAccMag.meanFreq</td>
<td style="text-align: left;">numeric</td>
<td style="text-align: left;">Hz</td>
<td style="text-align: left;">The mean value obtained after calculating the euclidean norm of all the signals in each of the axis (mean of the 3 euclidean norms).</td>
</tr>
<tr class="odd">
<td style="text-align: left;">FreqBodyBodyAccJerkMag.mean</td>
<td style="text-align: left;">numeric</td>
<td style="text-align: left;">Hz</td>
<td style="text-align: left;">The mean value obtained after calculating the euclidean norm of all the signals in each of the axis (mean of the 3 euclidean norms).</td>
</tr>
<tr class="even">
<td style="text-align: left;">FreqBodyBodyAccJerkMag.std</td>
<td style="text-align: left;">numeric</td>
<td style="text-align: left;">Hz</td>
<td style="text-align: left;">The standard deviation obtained after calculating the euclidean norm of all the signals in each of the axis (standard deviation of the 3 euclidean norms).</td>
</tr>
<tr class="odd">
<td style="text-align: left;">FreqBodyBodyAccJerkMag.meanFreq</td>
<td style="text-align: left;">numeric</td>
<td style="text-align: left;">Hz</td>
<td style="text-align: left;">The mean value obtained after calculating the euclidean norm of all the signals in each of the axis (mean of the 3 euclidean norms).</td>
</tr>
<tr class="even">
<td style="text-align: left;">FreqBodyBodyGyroMag.mean</td>
<td style="text-align: left;">numeric</td>
<td style="text-align: left;">Hz</td>
<td style="text-align: left;">The mean value obtained after calculating the euclidean norm of all the signals in each of the axis (mean of the 3 euclidean norms).</td>
</tr>
<tr class="odd">
<td style="text-align: left;">FreqBodyBodyGyroMag.std</td>
<td style="text-align: left;">numeric</td>
<td style="text-align: left;">Hz</td>
<td style="text-align: left;">The standard deviation obtained after calculating the euclidean norm of all the signals in each of the axis (standard deviation of the 3 euclidean norms).</td>
</tr>
<tr class="even">
<td style="text-align: left;">FreqBodyBodyGyroMag.meanFreq</td>
<td style="text-align: left;">numeric</td>
<td style="text-align: left;">Hz</td>
<td style="text-align: left;">The mean value obtained after calculating the euclidean norm of all the signals in each of the axis (mean of the 3 euclidean norms).</td>
</tr>
<tr class="odd">
<td style="text-align: left;">FreqBodyBodyGyroJerkMag.mean</td>
<td style="text-align: left;">numeric</td>
<td style="text-align: left;">Hz</td>
<td style="text-align: left;">The mean value obtained after calculating the euclidean norm of all the signals in each of the axis (mean of the 3 euclidean norms).</td>
</tr>
<tr class="even">
<td style="text-align: left;">FreqBodyBodyGyroJerkMag.std</td>
<td style="text-align: left;">numeric</td>
<td style="text-align: left;">Hz</td>
<td style="text-align: left;">The standard deviation obtained after calculating the euclidean norm of all the signals in each of the axis (standard deviation of the 3 euclidean norms).</td>
</tr>
<tr class="odd">
<td style="text-align: left;">FreqBodyBodyGyroJerkMag.meanFreq</td>
<td style="text-align: left;">numeric</td>
<td style="text-align: left;">Hz</td>
<td style="text-align: left;">The mean value obtained after calculating the euclidean norm of all the signals in each of the axis (mean of the 3 euclidean norms).</td>
</tr>
</tbody>
</table>
