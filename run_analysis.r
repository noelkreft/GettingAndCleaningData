##########################  IMPORT PACKAGES ################################

library(dplyr)

##########################  INIT FUNCTIONS  ################################

#import and merge raw train and test data 
import_and_merge_data<-function(){

        #import datasets
        X_train <- read.table("data/train/X_train.txt", quote="\"", comment.char="", stringsAsFactors=FALSE)
        Y_train <- read.table("data/train/Y_train.txt", quote="\"", comment.char="", stringsAsFactors=FALSE)
        subject_train <- read.table("data/train/subject_train.txt", quote="\"", comment.char="", stringsAsFactors=FALSE)
        X_test <- read.table("data/test/X_test.txt", quote="\"", comment.char="", stringsAsFactors=FALSE)
        Y_test <- read.table("data/test/Y_test.txt", quote="\"", comment.char="", stringsAsFactors=FALSE)
        subject_test <- read.table("data/test/subject_test.txt", quote="\"", comment.char="", stringsAsFactors=FALSE)
        
        #import description of features
        description_features<- read.table("data/features.txt", quote="\"", comment.char="", stringsAsFactors=FALSE)        
        
        #merge train and test datasets
        df<-rbind(X_train,X_test)
        
        #change column names
        names(df)<-description_features$V2
        
        #add subject to data
        df$subject<-rbind(subject_train,subject_test)$V1
        
        #add activity to data
        df$activity<-rbind(Y_train,Y_test)$V1
        
        #return merged data
        df
}

# function for extracting the mean en standard deviation of the numerical features
extract_relevant_features<-function(data) {
        
        #extract indices of mean and standard deviation columns
        indices<-grep("mean|std",names(data))
        
        #construct vector with relevant column names to extract from data frame
        columnnames<-c("activity","subject",names(data)[indices])
        
        #return 
        data[,columnnames]
}

map_activity_variable<-function(data){
        
        # import activity labels
        activity_labels<- read.table("data/activity_labels.txt", quote="\"", comment.char="", stringsAsFactors=FALSE)        
        
        #map "activity" variable values and transform to factor 
        data$activity<-factor(activity_labels[data$activity,2])
        
        #transform variable "subject" to factor to point out that it is nominal
        data$subject<-factor(data$subject)
        
        #return data
        data
}

mean_per_category<-function(data){
      data2<-  data %>% group_by(activity,subject) %>% summarise_each(funs(mean))
}


#########################  CORE PROGRAM  ##############################



# (1) import and merge train and test data and rename column names descriptive
data<-import_and_merge_data()  

# (2) extract only the mean and standard deviation of features
data<-extract_relevant_features(data)        
        
# (3) name the values in variable "activity" more descriptive
data<-map_activity_variable(data)

# (5) create data set with mean values of all combinations of "activity" and "subject"
data2<-mean_per_category(data)

#export data set
write.table(x=data2,file="tidy_dataset.txt",row.names = FALSE)

