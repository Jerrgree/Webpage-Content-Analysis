# Module to read data from a file

readFile <- function(name)
{
  document = readLines(name, n = -1)
  
  # Strip beggining metadata
  document <- document[7:length(document)]
  return(document)
}