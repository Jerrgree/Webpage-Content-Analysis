# Get-ChildItem SomeFolder | Get-Random -Count $x | Move-Item -Destination SomeOtherFolder
# Powershell script

library(plyr)

# Include all other modules
source("classify.R")
source("neoglobal.R")
source("Stage2.R")

makeGlobals <- function()
{
  # P1 FIles
  p1Student <- list.files(path="output/p1/student", full.names = T, recursive = T)
  p1Faculty <- list.files(path="output/p1/faculty", full.names = T, recursive = T)
  p1Course <- list.files(path="output/p1/course", full.names = T, recursive = T)
  
  p2Student <- list.files(path="output/p2/student", full.names = T, recursive = T)
  p2Faculty <- list.files(path="output/p2/faculty", full.names = T, recursive = T)
  p2Course <- list.files(path="output/p2/course", full.names = T, recursive = T)
  
  p3Student <- list.files(path="output/p3/student", full.names = T, recursive = T)
  p3Faculty <- list.files(path="output/p3/faculty", full.names = T, recursive = T)
  p3Course <- list.files(path="output/p3/course", full.names = T, recursive = T)
  
  p4Student <- list.files(path="output/p4/student", full.names = T, recursive = T)
  p4Faculty <- list.files(path="output/p4/faculty", full.names = T, recursive = T)
  p4Course <- list.files(path="output/p4/course", full.names = T, recursive = T)
  
  p5Student <- list.files(path="output/p5/student", full.names = T, recursive = T)
  p5Faculty <- list.files(path="output/p5/faculty", full.names = T, recursive = T)
  p5Course <- list.files(path="output/p5/course", full.names = T, recursive = T)
  
  # Create the global vocabs
  neoglobal(p1Student, p1Course, p1Faculty, "p1")
  neoglobal(p2Student, p2Course, p2Faculty, "p2")
  neoglobal(p3Student, p3Course, p3Faculty, "p3")
  neoglobal(p4Student, p4Course, p4Faculty, "p4")
  neoglobal(p5Student, p5Course, p5Faculty, "p5")
}

#makeGlobals()

accuracies = 0

# Each partitions files, indexed in partition order
studentFiles = c("output/p1/student", "output/p2/student", "output/p3/student", "output/p4/student", "output/p5/student")
courseFiles = c("output/p1/course", "output/p2/course", "output/p3/course", "output/p4/course", "output/p5/course")
facultyFiles = c("output/p1/faculty", "output/p2/faculty", "output/p3/faculty", "output/p4/faculty", "output/p5/faculty")

# Each partition vocabulary, indexed in partition order
studentVocabs = c("output/p1Student.csv", "output/p2Student.csv", "output/p3Student.csv", "output/p4Student.csv", "output/p5Student.csv")
courseVocabs = c("output/p1Course.csv", "output/p2Course.csv", "output/p3Course.csv", "output/p4Course.csv", "output/p5Course.csv")
facultyVocabs = c("output/p1Faculty.csv", "output/p2Faculty.csv", "output/p3Faculty.csv", "output/p4Faculty.csv", "output/p5Faculty.csv")

for (i in 1:5)
{
  # Grab the partition to be tested
  testStudent <- list.files(path=studentFiles[i], full.names = T, recursive = T)
  testFaculty <- list.files(path=facultyFiles[i], full.names = T, recursive = T)
  testCourse <- list.files(path=courseFiles[i], full.names = T, recursive = T)
  
  # Initialize empty lists
  argsS = c()
  argsF = c()
  argsC = c()
  lS = c()
  lF = c()
  lC = c()
  
  for (j in 1:5)
  {
    # For every partition that is not the test
    if (j != i)
    {
      # Get the other partition vocabularies
      argsS <- c(argsS, studentVocabs[j])
      argsF <- c(argsF, facultyVocabs[j])
      argsC <- c(argsC, courseVocabs[j])
      
      # Get the other partition files
      lS = c(lS, studentFiles[j])
      lF = c(lF, courseFiles[j])
      lC = c(lC, facultyFiles[j])
    }
  }
  
  # Create the training vocabularies for naive
  studentVocab <- combineVocabs(argsS[1], argsS[2], argsS[3], argsS[4])
  courseVocab <- combineVocabs(argsC[1], argsC[2], argsC[3], argsC[4])
  facultyVocab <- combineVocabs(argsF[1], argsF[2], argsF[3], argsF[4])
  
  # Gather the training  files for KNN
  trainStudent <- mergeLists(lS[1], lS[2], lS[3], lS[4])
  trainFaculty <- mergeLists(lF[1], lF[2], lF[3], lF[4])
  trainCourse <- mergeLists(lC[1], lC[2], lC[3], lC[4])
  
  accuracy = analyzeData(testStudent, testFaculty, testCourse, studentVocab, facultyVocab, courseVocab, trainStudent, trainFaculty, trainCourse)
  accuracies = accuracies + accuracy
}

print(accuracies / 5)
