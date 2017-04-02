library(plyr)
library(compare)

# Classification based on distance
dist_classify <- function(data, studentVocab, facultyVocab, courseVocab)
{
  sVal = 0
  cVal = 0
  fVal = 0
  
  arrange(data, desc(count))
  
  margin = min(500, length(data))
  #margin = length(data)
  for(i in 1:margin)
  {
    line = data[i,]
    word <- as.character(line$word)
    count <- line$count
    
    sCount <- studentVocab[studentVocab$word==word,]$count
    fCount <- facultyVocab[facultyVocab$word==word,]$count
    cCount <- courseVocab[courseVocab$word==word,]$count
    
    if(length(sCount) == 0)
    {
      sCount <- 0
    }
    
    if(length(fCount) == 0)
    {
      fCount <- 0
    }
    
    if(length(cCount) == 0)
    {
      cCount <- 0
    }
    
    # Sum up the distance formula values
    sVal <- sVal + (count - sCount)**2
    cVal <- cVal + (count - cCount)**2
    fVal <- fVal + (count - fCount)**2
  }
  
  # To finish the distance formula, get the square root of the values
  sVal <- sqrt(sVal)
  fVal <- sqrt(fVal)
  cVal <- sqrt(cVal)
  
  # Find the minimum value
  minVal <- min(sVal, fVal, cVal)
  
  if (minVal == sVal)
  {
    return("S") 
  }
  
  else if (minVal == fVal)
  {
    return("F")
  }
  
  return("C")
}

# Naive classification
naive_classify <- function(data, studentVocab, facultyVocab, courseVocab)
{
  margin = 650
  
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

