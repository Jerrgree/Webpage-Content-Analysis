# Remove stop Words
library(tm)
# Clean up whitespace
library(qdap)


documents = c("She had toast for breakfast",
              "The coffee this morning was excellent", 
              "For lunch let's all have pancakes", 
              "Later in the day, there will be more talks",
              "Let's talk about this he talks to she",
              "The talks on the first day were great", 
              "The second day should have good presentations too")


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
  # Collapse the multi dimensional array into a single dimensional array
  document <- paste(document, collapse = " ")
  # Clean up the whitespace
  document <- Trim(clean(document))
  
  return(document)
}

d <- stopRemove(documents)

d