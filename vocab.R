# Module to convert a list of words into a structured vocabulary

countWords <- function(document, uWords)
{
  # Initialize vector of zeroes
  count <- rep(0, length(uWords))
  
  for (i in 1:length(document))
  {
    word = document[[i]]
    pos = match(word, uWords)
    count[[pos]] <- count[[pos]] + 1
  }
  
  return(count)
}

toVocab <- function(document)
{
  # Get all of the unique words as a document
  uWords = unique(document)
  # Count those words
  uCount = countWords(document, uWords)
  
  vocab = data.frame(word=uWords, count=uCount, stringsAsFactors=FALSE)
  return(vocab)
}