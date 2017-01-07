#README 

##INTRODUCTION
The repository contains a script (run_analysis.r) for transforming the "Samsung data" into a tidy data set. 

## BEFORE RUNNING THE SCRIPT
To run the script in R, the working directory must be set to the main directory of this repository. 

## WHAT DOES THIS SCRIPT DO?
run_analysis.r executes the following steps to create the tidy data set:
*read raw data into r
*merge train and test data
*map the activity values from integers to descriptive labels
*map feature names to a descriptive name 
*only keep features containing mean and standard deviation data
*calculate mean of all numerical features per combination of "activity" and "subject"
*export tidy data set to file

All these steps are well documented in the script. 
