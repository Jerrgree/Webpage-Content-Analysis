library(SnowballC)
library(tm)

# Include all other modules
if(!exists("stopRemove", mode = "function")) source("stopword.R")
if(!exists("readFile", mode = "function")) source("fileIO.R")
if(!exists("toVocab", mode = "function")) source("vocab.R")
if(!exists("removeTags", mode = "function")) source("tagremove.R")

analyzeWebPage <- function(file)
{
  # Output retains same file heirarchy as the input folder
  outfile = paste("output/", file, ".csv", sep = "")
  # Read in the file
  document <- readFile(file)
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
  # Write the vocabulary to a file
  write.csv(vocab, outfile)
}

globalVocab <- function(document)
{
  # Only one output file
  outfile = "output/global.csv"
  # Collapse the list of documents into a single string
  document <- paste(document, collapse = " ")
  # Remove html tags
  document <- removeTags(document)
  # Remove stopwords
  document <- stopRemove(document)
  # Stem words
  document <- wordStem(document)
  # Get the vocabulary
  vocab <- toVocab(document)
  # Write the vocabulary to a file
  write.csv(vocab, outfile)
}

# A static webpage for testing changes
#analyzeWebPage("projectdata/test/course/http_^^cs.cornell.edu^Info^Courses^Current^CS415^CS414.html")

files <- list.files(path="projectdata", full.names = T, recursive = T)

# Build local vocabulary for every file
lapply(files, analyzeWebPage) 

# Build global vocabulary
t <- lapply(files, readFile)
globalVocab(t)