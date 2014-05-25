# assumption: this script is in the same folder as the unzipped UCI HAR data folder.

#getwd()
#list.files("./test")

#read files
# Y vector data is the Activity Vector
# X vector data is the Feature data

#read test data files
data.tst.y <- read.table("./test/y_test.txt")
#str(data.tst.y)
#head(data.tst.y)
#tail(data.tst.y)

data.tst.x <- read.table("./test/x_test.txt")
#str(data.tst.x)
#head(data.tst.x,2)
#tail(data.tst.x)

#read training data files
data.trn.y <- read.table("./train/y_train.txt")
#str(data.trn.y)
#head(data.trn.y)
#tail(data.trn.y)

data.trn.x <- read.table("./train/x_train.txt")
#str(data.trn.x)
#head(data.trn.x,2)
#tail(data.trn.x)

#read subject data files
subj.trn <- read.table("./train/subject_train.txt")
#str(subj.trn)
#head(subj.trn)
#tail(subj.trn)

subj.tst <- read.table("./test/subject_test.txt")
#str(subj.tst)
#head(subj.tst)
#tail(subj.tst)


#read features file
features <- read.table("features.txt")

#select row numbers and feature names which have either "mean" or "std' in them
feature.rows <- grep(paste(c("mean\\(\\)", "std\\(\\)"),collapse="|"), features$V2, value=FALSE)
feature.names <- grep(paste(c("mean\\(\\)", "std\\(\\)"),collapse="|"), features$V2, value=TRUE)

#merge data sets
merged.dataset <- rbind(cbind(subj.trn, data.trn.y, data.trn.x[,feature.rows]), cbind(subj.tst, data.tst.y, data.tst.x[,feature.rows]))

#clear some memory now
rm(data.trn.x)
rm(data.trn.y)
rm(data.tst.x)
rm(data.tst.y)
rm(subj.trn)
rm(subj.tst)

feature.names <- gsub("\\(\\)", "", feature.names)
feature.names <- gsub("-",".",feature.names)
feature.names <- tolower(feature.names)  

#read activity labels file 
#and prep the field names as per convention
activities <- read.table("activity_labels.txt")
activities[, 2] = gsub("_", ".", tolower(as.character(activities[, 2])))
                      
#rename columns and activity names 
names(merged.dataset) <- c("Subject","Activity", c(feature.names))
                      
# Activity names
merged.dataset$Activity[merged.dataset$Activity==1] <- activities[1,2]
merged.dataset$Activity[merged.dataset$Activity==2] <- activities[2,2]
merged.dataset$Activity[merged.dataset$Activity==3] <- activities[3,2]
merged.dataset$Activity[merged.dataset$Activity==4] <- activities[4,2]
merged.dataset$Activity[merged.dataset$Activity==5] <- activities[5,2]
merged.dataset$Activity[merged.dataset$Activity==6] <- activities[6,2]

# Melt data and reshape to get averages
library(reshape2)
temp.melt <- melt(merged.dataset, id=c("Subject","Activity"))
final.dataset <- dcast(temp.melt, Subject + Activity ~ variable, mean)

# Output data to files
write.table(final.dataset, file = "final_dataset.txt", sep = ",")
