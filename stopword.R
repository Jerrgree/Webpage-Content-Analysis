library(tm)

documents = c("She had toast for breakfast",
              "The coffee this morning was excellent", 
              "For lunch let's all have pancakes", 
              "Later in the day, there will be more talks", 
              "The talks on the first day were great", 
              "The second day should have good presentations too")


stopRemove <- function(document)
{
  # Convert the character array to a corpus
  document <- documents <- Corpus(VectorSource(document))
  # Make all characters lowercase
  document = tm_map(document, content_transformer(tolower))
  #Strip all punctuation
  document = tm_map(document, removePunctuation)
  #Remove stopwords
  document = tm_map(document, removeWords, stopwords("english"))
  #Convert the corpus to a data frame
  document <-data.frame(text=unlist(sapply(document, `[`, "content")), 
                                 stringsAsFactors=F)
  
  return(document)
}

d <- stopRemove(documents)

d