library(SnowballC)
library(tm)

# Include all other modules
source("stopword.R")
if(!exists("readFile", mode = "function")) source("fileIO.R")
if(!exists("toVocab", mode = "function")) source("vocab.R")
if(!exists("removeTags", mode = "function")) source("tagremove.R")


analyzeDocument <- function(document)
{
  # Collapse the document array into a single string
  document <- paste(document, collapse = " ")
  # Remove the html tags
  document <- removeTags(document)
  # Remove stop words
  document <- stopRemove(document)
  # Stem words
  document <- wordStem(document)
  # Get the vocabulary
  vocab <- toVocab(document)
  return(vocab)
}

# Reads and writes the vocabulary of a single file
singleVocab <- function(file)
{
  outfile = paste("output/", file, ".csv", sep = "")
  
  document <- readFile(file)
  vocab <- analyzeDocument(document)
  write.csv(vocab, outfile)
}

findThatBrocolli <- function(file)
{
  document <- readFile(file)
  vocab <- analyzeDocument(document)
  if (is.element("pooooooooooooooch", vocab$word))
  {
    write(file, "data.txt")
  }
}

# Reads and writes the vocabulary of a document
multiVocab <- function(document, outfile)
{
  # Collapse the list of documents into a single string
  document <- paste(document, collapse = " ")

  # Analyze the document
  vocab <- analyzeDocument(document)
  
  # Write the vocabulary to a file
  write.csv(vocab, outfile)
}

# A static webpage for testing changes
#analyzeWebPage("projectdata/test/course/http_^^cs.cornell.edu^Info^Courses^Current^CS415^CS414.html")

files <- list.files(path="projectdata", full.names = T, recursive = T)
lapply(files, findThatBrocolli)

# Build local vocabulary for every file
lapply(files, singleVocab) 

# Build global vocabulary
t <- lapply(files, readFile)
multiVocab(t, "output/global.csv")

# List and read all files in the train folder
trainFiles <- list.files(path="projectdata/test", full.names = T, recursive = T)
trainFiles <- lapply(trainFiles, readFile)

# List and read all files in the test folder
testFiles <- list.files(path="projectdata/train", full.names = T, recursive = T)
testFiles <- lapply(testFiles, readFile)

multiVocab(trainFiles, "output/train.csv")
multiVocab(testFiles, "output/test.csv")