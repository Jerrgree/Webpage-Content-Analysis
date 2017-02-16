
# Include all other modules
if(!exists("stopRemove", mode = "function")) source("stopword.R")
if(!exists("readFile", mode = "function")) source("fileIO.R")
if(!exists("documentStem", mode = "function")) source("stemming.R")
if(!exists("toVocab", mode = "function")) source("vocab.R")
if(!exists("removeTags", mode = "function")) source("tagremove.R")

# Can't figure out how to read from stdin
#f <- file("stdin")
#open(f)

#line <- readLines(f,n=1)
#line

name = "http_^^cam.cornell.edu^~baggett^index"
infile = paste(name, "html", sep = ".")
outfile = paste(name, "csv", sep = ".")
document <- readFile(infile)
document <- paste(document, collapse = " ")
document <- removeTags(document)
document <- stopRemove(document)
document <- documentStem(document)
vocab <- toVocab(document)
write.csv(vocab, outfile)