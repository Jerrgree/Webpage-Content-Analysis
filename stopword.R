# Remove stop Words
library(tm)
# Clean up whitespace
library(qdap)

stopRemove <- function(document)
{
  # Convert the character array to a corpus
  document <- documents <- Corpus(VectorSource(document))
  # Make all characters lowercase
  document = tm_map(document, content_transformer(tolower))
  # Strip all punctuation
  document = tm_map(document, removePunctuation)
  # Remove stopwords
  document = tm_map(document, removeWords, stopwords("english"))
  # Convert the corpus to a data frame
  document <-data.frame(text=unlist(sapply(document, `[`, "content")), stringsAsFactors=F)
  # Convert the data frame to a text array
  document <- document[, "text"]
  # Collapse the multi dimensional array into a single string array
  document <- paste(document, collapse = " ")
  # Clean up the whitespace
  document <- Trim(clean(document))
  # Split the string into a psuedo single dimensional array
  document <- strsplit(document," ")
  # Convert it into a single dimensional array
  document <- document[[1]]
  
  return(document)
}