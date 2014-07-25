###Summary
The run_analysis.R script takes data from the accelerometers from the Samsung Galaxy S smartphone in which experiements were carried out with a group of 30 volunteers within an age bracket of 19-48 years. 

Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. 

###Script Details
The script unzips the file and loads each file separately into R:

- Test File (with data)
- Test Labels
- Test Subjects
- Train File (with data)
- Train Labels
- Train Subjects
- Features file

###Merging of Files
The script then merges all the Test files and all the Train files (adds columns) to get a complete Test and Train data file (with Activity lookup).  It then merges the master Test and master Train files into a Master Data file.

Isolating any column with the word "mean" or "std", the script selects only those columns and calculates the mean of each column up for every subject.

###Re-naming columns with Descriptive titles
The script also reads in a file with column names that are more descriptive than those found in the source files (features2.txt).  It uses these names to rename the columns in the final output file.

###Output
Then end result is a tidy data set where each row represents a subject and all Mean/STD columns are averaged for each subject.  This data set is exported to the working directory as tidy.txt.