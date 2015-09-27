library(dplyr)
setwd("/Users/xxxxxx/Desktop/R Work/Getting and Cleaning Data")
if(!file.exists("./cleaning_data_W3")){dir.create("./cleaning_data_W3")}
fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url=fileurl,destfile="./cleaning_data_W3/",method="curl")
unzip ("./cleaning_data_W3/*zip", exdir = "./cleaning_data_W3/")

setwd("/Users/abhiwapure/Desktop/R Work/Getting and Cleaning Data/cleaning_data_W3/UCI HAR Dataset")
features <- read.table("features.txt")
features
names(features)
activity_labels <- read.table("activity_labels.txt")
activity_labels
names(activity_labels)[1] <- "activity_id"
names(activity_labels)[2] <- "activity"

subject_test <- read.table("./test/subject_test.txt")
X_test <- read.table("./test/X_test.txt")
y_test <- read.table("./test/y_test.txt")
nrow(subject_test)
subject_train <- read.table("./train/subject_train.txt")
X_train <- read.table("./train/X_train.txt")
y_train <- read.table("./train/y_train.txt")
nrow(subject_train)
head(subject_test)
head(X_test)
head(y_test)
View(X_test)
head(subject_train)
head(X_train)
head(y_train)

subject_c <- rbind(subject_test,subject_train)
X_c <- rbind(X_test,X_train)
y_c <- rbind(y_test,y_train)
View(subject_c)
names(subject_c) <- "Subject"
names(X_c)<-features$V2[match(names(X_c),features$V1)]
colnames(X_c)<-features[1:ncol(X_c),"V2"]
head(X_c,1)
names(y_c)
activity_labels
View(y_c)

ncol(y_c)

names(X_c)
new_x_c <- X_c[,grepl("mean|std", colnames(X_c))] 
head(new_x_c,1)

head(new_x_c,3)

New_data <- cbind(subject_c,y_c,new_x_c)
head(New_data,3)
View(New_data)

nrow(New_data)
tidy_data <- New_data %>% group_by(Subject,V1) %>% summarise_each(funs(mean))
View(tidy_data)

tidy_data_1 <- merge(tidy_data,activity_labels,by.x="V1",by.y="activity_id",all="TRUE")

View(tidy_data_1)

tidy_data_2 <- cbind(tidy_data_1[,2],tidy_data_1[,"activity"],tidy_data_1[,3:81])

View(tidy_data_2)   
names(tidy_data_2)
                     
write.csv(tidy_data_2, "tidy.csv", row.names=FALSE)

names(tidy_data_2)


