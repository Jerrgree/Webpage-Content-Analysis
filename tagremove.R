# Module to remove HTML tags from a set of data
library(qdap)

removeTags <- function(document)
{
  return(bracketX(document, "angle", missing=" "))
}