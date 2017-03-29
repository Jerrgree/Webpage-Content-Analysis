# Include all other modules
source("stopword.R")
if(!exists("readFile", mode = "function")) source("fileIO.R")
if(!exists("toVocab", mode = "function")) source("vocab.R")
if(!exists("removeTags", mode = "function")) source("tagremove.R")


# A static webpage for testing changes
#analyzeWebPage("projectdata/test/course/http_^^cs.cornell.edu^Info^Courses^Current^CS415^CS414.html")

# Each revelant folder

# Train folders
trainStudent <- list.files(path="output/projectdata/train/student", full.names = T, recursive = T)
trainFaculty <- list.files(path="output/projectdata/train/faculty", full.names = T, recursive = T)
trainCourse <- list.files(path="output/projectdata/train/course", full.names = T, recursive = T)

# Test folders
testStudent <- list.files(path="output/projectdata/test/student", full.names = T, recursive = T)
testFaculty <- list.files(path="output/projectdata/test/faculty", full.names = T, recursive = T)
testCourse <- list.files(path="output/projectdata/test/course", full.names = T, recursive = T)

# Global vocabs for each train set
studentVocab <- read.csv("output/student.csv")
facultyVocab <- read.csv("output/faculty.csv")
courseVocab <- read.csv("output/course.csv")

# Build a classifier for all train documents

# Classify each test document and note errors

# Build a confusion matrix