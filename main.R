if(!exists("stopRemove", mode = "function")) source("stopword.R")
if(!exists("readFile", mode = "function")) source("fileIO.R")
if(!exists("documentStem", mode = "function")) source("stemming.R")


source("stopword.R")

# Can't figure out how to read from stdin
#f <- file("stdin")
#open(f, blocking=TRUE)

#line <- readLines(f,n=1)
#line

file = "test.txt"
document = readFile(file)
document
document <- stopRemove(document)
document
document <- documentStem(document)
document