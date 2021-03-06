library(plyr)

# Include all other modules
source("classify.R")


# A static webpage for testing changes
#analyzeWebPage("projectdata/test/course/http_^^cs.cornell.edu^Info^Courses^Current^CS415^CS414.html")

# Each revelant folder

# Training files
#trainStudent <- list.files(path="output/projectdata/train/student", full.names = T, recursive = T)
#trainFaculty <- list.files(path="output/projectdata/train/faculty", full.names = T, recursive = T)
#trainCourse <- list.files(path="output/projectdata/train/course", full.names = T, recursive = T)

# Test files
#testStudent <- trainStudent #list.files(path="output/projectdata/test/student", full.names = T, recursive = T)
#testFaculty <- trainFaculty #list.files(path="output/projectdata/test/faculty", full.names = T, recursive = T)
#testCourse <- trainCourse #list.files(path="output/projectdata/test/course", full.names = T, recursive = T)

# Global vocabs for each train set
#studentVocab <- read.csv("output/student.csv")
#studentVocab <- within(studentVocab, rm(X))

#facultyVocab <- read.csv("output/faculty.csv")
#facultyVocab <- within(facultyVocab, rm(X))

#courseVocab <- read.csv("output/course.csv")
#courseVocab <- within(courseVocab, rm(X))

analyzeData <- function(testStudent, testFaculty, testCourse, studentVocab, facultyVocab, courseVocab, trainStudent, trainFaculty, trainCourse)
{
  # Initialize Confusion matrix
  
  SasS = 0
  SasF = 0
  SasC = 0
  FasS = 0
  FasF = 0
  FasC = 0
  CasS = 0
  CasF = 0
  CasC = 0
  
  # Classify each test document and note errors
  
  for (i in 1:length(testStudent))
  {
    sample = within(read.csv(testStudent[i]), rm(X))
    
    decision1 <- naive_classify(sample, studentVocab, facultyVocab, courseVocab)
    decision2 <- knn_classify(sample, trainStudent, trainFaculty, trainCourse)
    
    decision = decide(decision1, decision2)
    
    if (decision == "S")
    {
      SasS = SasS + 1
    }
    
    if (decision == "F")
    {
      SasF = SasF + 1
    }
    
    if (decision == "C")
    {
      SasC = SasC + 1
    }
  }
  
  for (i in 1:length(testFaculty))
  {
    sample = within(read.csv(testFaculty[i]), rm(X))
    
    decision1 <- naive_classify(sample, studentVocab, facultyVocab, courseVocab)
    decision2 <- knn_classify(sample, trainStudent, trainFaculty, trainCourse)
    
    
    decision = decide(decision1, decision2)
    
    if (decision == "S")
    {
      FasS = FasS + 1
    }
    
    if (decision == "F")
    {
      FasF = FasF + 1
    }
    
    if (decision == "C")
    {
      FasC = FasC + 1
    }
  }
  
  for (i in 1:length(testCourse))
  {
    sample = within(read.csv(testCourse[i]), rm(X))
    
    decision1 <- naive_classify(sample, studentVocab, facultyVocab, courseVocab)
    decision2 <- knn_classify(sample, trainStudent, trainFaculty, trainCourse)
    
    
    decision = decide(decision1, decision2)
    
    if (decision == "S")
    {
      CasS = CasS + 1
    }
    
    if (decision == "F")
    {
      CasF = CasF + 1
    }
    
    if (decision == "C")
    {
      CasC = CasC + 1
    }
  }
  
  # Print a confusion matrix
  accuracy = (CasC + SasS + FasF) / (CasC + SasS + FasF + CasF + SasC + FasS + CasS + SasF + FasC)
  print(" |S | F | C")
  print(paste("S|", SasS, " | ", SasF, " | ", SasC))
  print(paste("F|", FasS, " | ", FasF, " | ", FasC))
  print(paste("C|", CasS, " | ", CasF, " | ", CasC))
  print(accuracy)
  
  return(accuracy)
}

#AnalyzeData(testStudent, testFaculty, testCourse, studentVocab, facultyVocab, courseVocab, trainStudent, trainFaculty, trainCourse)