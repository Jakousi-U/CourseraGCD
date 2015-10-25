# Check file exists
print("START -->")
# Assume the folder was downloaded and unziped
folder <- "UCI HAR Dataset"
if(file.exists(folder)){
	#Training set
	file1 <- paste(folder,"/train/subject_train.txt",sep="")
	file2 <- paste(folder,"/train/y_train.txt",sep="")
	file3 <- paste(folder,"/train/X_train.txt",sep="")
	#Test set
	file4 <- paste(folder,"/test/subject_test.txt",sep="")
	file5 <- paste(folder,"/test/y_test.txt",sep="")
	file6 <- paste(folder,"/test/X_test.txt",sep="")
	#Labels
	file7 <- paste(folder,"/features.txt",sep="")
	file8 <- paste(folder,"/activity_labels.txt",sep="")

	#Step 4 Get variable names from de text files provided
	features <- read.table(file7, stringsAsFactor = FALSE)$V2
	activities <- read.table(file8, stringsAsFactor = FALSE)
	rm(file7)
	rm(file8)

	#Step 2 Extracts only the measurements on the mean and standard deviation for each measurement.
	meanAndStd <- sort(c(grep("-mean\\(\\)",features),grep("-std\\(\\)",features)))

	if(file.exists(file1) & file.exists(file2) & file.exists(file3) & 
		file.exists(file4) & file.exists(file5) & file.exists(file6) ){
		if(!exists("trainSet")){
			#Step 1, 2, 3, 4
			trainActivities <- as.data.frame(factor(read.table(file2)$V1, levels=activities$V1, labels=activities$V2))
			names(trainActivities) = c("activity")
			trainSet <- cbind(read.table(file1,col.names=c("subject")),
					trainActivities,
					read.table(file3,col.names=features)[,meanAndStd])
			rm(file1)
			rm(file2)
			rm(file3)
			rm(trainActivities)
		}
		if(!exists("testSet")){
			#Step 1, 2, 3, 4
			testActivities <- as.data.frame(factor(read.table(file5)$V1, levels=activities$V1, labels=activities$V2))
			names(testActivities) = c("activity")
			testSet <- cbind(read.table(file4,col.names=c("subject")),
					testActivities,
					read.table(file6,col.names=features)[,meanAndStd])
			rm(file4)
			rm(file5)
			rm(file6)
			rm(testActivities)
		}
		if(!exists("fullSet ")){
			#Step 1
			fullSet <- rbind(trainSet,testSet)
			rm(trainSet)
			rm(testSet)
			rm(activities)
			rm(features)
			rm(folder)
			rm(meanAndStd)

			#Step 5
			groups <- split(fullSet[,-c(1:2)],list(fullSet$subject,fullSet$activity))
			means <- t(sapply(groups, function(x) {sapply(x, function(y) {mean(y)})}))
			subject <- unlist(lapply(strsplit(rownames(means),"\\."), `[[`, 1),use.names=FALSE)
			activity <- unlist(lapply(strsplit(rownames(means),"\\."), `[[`, 2),use.names=FALSE)
			means <- data.frame(subject, activity, means)
			write.table(means,"data/tidyDataSet.txt",row.name=FALSE)
			rm(groups)
			rm(activity)
			rm(fullSet)
			rm(means)
			rm(subject)
		}
	}else{
		print("Missing files")
	}
} else {
	print(sprintf("Folder %s does not exists", folder))
}
print("<-- END")
