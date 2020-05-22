# 1. 

# Training

x_Train <- read.table("train/X_train.txt", header=FALSE)
y_Train <- read.table("train/Y_train.txt", header=FALSE)

# Test

x_Test <- read.table("test/X_test.txt", header=FALSE)
y_Test <- read.table("test/Y_test.txt", header=FALSE)

# Subjects

sTrain <- read.table("train/subject_train.txt", header=FALSE)
sTest <- read.table("test/subject_test.txt", header=FALSE)

#Merge data

xMerged <- rbind(xTrain, xTest)
yMerged <- rbind(yTrain, yTest)
s <- rbind(subjectTrain, subjectTest)

# 3. Uses descriptive activity names to name the activities in the data set
# 4. 

# Build Features and Labels then apply

features <- scan("features.txt", what = "character", sep = " ")
labels <- scan("activity_labels.txt", what = "character", sep=" ")

ID <- seq(2,length(features), by= 2)
Feat <- features[ID]
ID <- seq(2, length(labels), by= 2)
Labels <- labels[ID]

colnames(xMerged) <- Features
colnames(yMerged) <- c("Activity")
colnames(subject) <- c("Subject")
yMerged$Activity <- factor(yMerged$Activity, labels = Labels)

Data <- cbind(yMerged, subject, xMerged)

# 2.

mean <- grep("MEAN", toupper(names(allData)))
sDev <- grep("std", names(allData))  # select std's
vars <- append(mean, sDev, after = length(mean))
vars <- append(c(1,2), vars, after = length(c(1,2)))
vars <- sort(vars)
tidyDataMean <- allData[,vars]

# 5. 


library(plyr)
library(reshape)
library(reshape2)

unPivoted <- melt(tidyDataMean, id = c("Subject", "Activity"))  
unPivoted$value <- as.numeric(unPivoted$value)
activtySubject <- aggregate(unPivoted$value, list(unPivoted$Activity, unPivoted$variable), mean)

# Write out the data file
write.csv(tidyDataMean, file= "tidyData.txt", row.names=FALSE)
