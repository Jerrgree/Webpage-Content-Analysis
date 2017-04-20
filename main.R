source("Stage2.R")

# Training files
trainStudent <- list.files(path="output/projectdata/train/student", full.names = T, recursive = T)
trainFaculty <- list.files(path="output/projectdata/train/faculty", full.names = T, recursive = T)
trainCourse <- list.files(path="output/projectdata/train/course", full.names = T, recursive = T)

# Test files
testStudent <- list.files(path="output/projectdata/test/student", full.names = T, recursive = T)
testFaculty <- list.files(path="output/projectdata/test/faculty", full.names = T, recursive = T)
testCourse <- list.files(path="output/projectdata/test/course", full.names = T, recursive = T)

# Global vocabs for each train set
studentVocab <- read.csv("output/student.csv")
studentVocab <- within(studentVocab, rm(X))

facultyVocab <- read.csv("output/faculty.csv")
facultyVocab <- within(facultyVocab, rm(X))

courseVocab <- read.csv("output/course.csv")
courseVocab <- within(courseVocab, rm(X))

analyzeData(testStudent, testFaculty, testCourse, studentVocab, facultyVocab, courseVocab, trainStudent, trainFaculty, trainCourse)
