
# We assume that the Samsung data is in 'UCI HAR Dataset' directory in the working directory
#
#
#

# Reading appropriate tables
#       a) tables common for test and train sets

tab_features <- read.table("UCI HAR Dataset/features.txt")
tab_act_labels <- read.table("UCI HAR Dataset/activity_labels.txt")

#       b) test and train sets

for (segment in c("test","train")) {
  
  assign(paste("tab_",segment,"_subject",sep=""), read.table(paste("UCI HAR Dataset/",segment,"/subject_",segment,".txt",sep="")))
  assign(paste("tab_",segment,"_act_labels",sep=""), read.table(paste("UCI HAR Dataset/",segment,"/y_",segment,".txt",sep="")))
  assign(paste("tab_",segment,"_X",sep=""), read.table(paste("UCI HAR Dataset/",segment,"/X_",segment,".txt",sep="")))
   
}

# Binding test and train 'X' tables by rows
tab_X <- rbind(tab_train_X, tab_test_X)

# Assigning features names
names(tab_X) <- tab_features[,2]

# We keep only features having 'mean' or 'std' in the name
tab_X_mean_std <- tab_X[,c(grep("mean",colnames(tab_X)),grep("std",colnames(tab_X)))]

# Assigning subjects to the main (tab_X_mean_std) set
tab_subject <- rbind(tab_train_subject, tab_test_subject)
tab_X_mean_std$subject <- tab_subject[,1]

# Assigning activities with appropriate label to the main (tab_X_mean_std) set
tab_total_act_labels <- rbind(tab_train_act_labels, tab_test_act_labels)
tab_X_mean_std$activityLabel <- tab_total_act_labels[,1]
#       labelling activities
tab_X_mean_std$activityLabel <- factor(tab_X_mean_std$activityLabel, 
                                       levels = tab_act_labels[,1],
                                       labels = tab_act_labels[,2]
                                      )


# Creating a tidy set (average of every variable from tab_X_mean_std per subject & activity)
# We are using dcast method from reshape2 library

library(reshape2)

# First, we need to melt the data
tmp_melted <- melt(tab_X_mean_std, id.vars=c("subject","activityLabel"))
# Then we reshape data to tidy format
tidy_set <- dcast(tmp_melted, subject + activityLabel ~ variable, mean)


# Saving final tidy dataset according from the assignment instructions.
# We save the file in the working directory
write.table(tidy_set, file="tidy_data.txt", row.name=FALSE)

