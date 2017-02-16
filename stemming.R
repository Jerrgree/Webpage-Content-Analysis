# Module to perform stemming over a list of words

library(SnowballC)

documentStem <- function(document)
{
  return(wordStem(document))
}