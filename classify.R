library(plyr)
library(compare)

classify <- function(data, studentVocab, facultyVocab, courseVocab)
{
  margin = 200
  
  arrange(data, desc(count))
  
  sData = (studentVocab$word)[0:margin]
  fData = (facultyVocab$word)[0:margin]
  cData = (courseVocab$word)[0:margin]
  dData = (data$word)[0:margin]
  
  sData <- intersect(sData, dData)
  fData <- intersect(fData, dData)
  cData <- intersect(cData, dData)
  
  if (length(sData) >= length(fData) && length(sData) >= length(cData))
  {
    return("S") 
  }
  
  else if (length(fData) >= length(sData) && length(fData) >= length(cData))
  {
    return("F")
  }
  
  return("C")
}

