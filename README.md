# CourseraGCD
For activities of the course Getting and Cleaning Data

Content:
<ul>
<li>run_analysis.R</li>
<li>Code_Book.txt</li>
</ul>

<b>run_analysis.R</b>

This script is used for the course project of Getting and Cleaning Data. Assumes the following folder was downloaded and unzipped in the working directory and that exists a writable folder named data:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The script does the following:
<ol>
<li>Read the train and text data files and the labels file using read.table()</li>
<li>Transform the "y" file from numeric to factor, taking the labels in the file activity_labels.txt</li>
<li>Use the grep() function to found the mean and std of the measurements (66 / 561 columns). I exclude meanFreq because there are measurements without that value. Subsetting the data.frame of measurement to only have the columns founded</li>
<li>For the train and test data, use cbind to merge files of subject, activity and measurements. At the moment columns names have been explicitly named to significant names taken from the file features.txt.</li>
<li>Use rbind() to merge the train and test data frames previously generated.</li>
<li>Use split() to cut the data by subject and activity. The result only contains the numeric data.</li>
<li>Use sapply() two times in the object gotten by the previous split(). The first sapply runs over the groups, the second over each column to get the mean of each variable.</li>
<li>Transpose the matrix of the previous step.</li>
<li>Insert the columns of subject and activity (they get lost in the split()).</li>
<li>Use write.table() with row.name=FALSE to generate the file data/tidyDataSet.txt</li>
</ol>

Check Code_Book.txt for details of the variables in the final data frame.

<b>Source:</b>
Jorge L. Reyes-Ortiz(1,2), Davide Anguita(1), Alessandro Ghio(1), Luca Oneto(1) and Xavier Parra(2)
1 - Smartlab - Non-Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova, Genoa (I-16145), Italy. 
2 - CETpD - Technical Research Centre for Dependency Care and Autonomous Living
Universitat Politècnica de Catalunya (BarcelonaTech). Vilanova i la Geltrú (08800), Spain
activityrecognition '@' smartlab.ws

<b>Citation Request:</b>
Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. A Public Domain Dataset for Human Activity Recognition Using Smartphones. 21th European Symposium on Artificial Neural Networks, Computational Intelligence and Machine Learning, ESANN 2013. Bruges, Belgium 24-26 April 2013.
