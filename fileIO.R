readFile <- function(name)
{
  document = readLines(name, n = -1)
  return(document)
}
