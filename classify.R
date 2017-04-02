library(plyr)
library(compare)

# Naive classification
naive_classify <- function(data, studentVocab, facultyVocab, courseVocab)
{
  margin = 650
  
  data <- arrange(data, desc(count))
  
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

distance <- function(data, vocab)
{
  data <- arrange(data, desc(count))
  
  val = 0
  
  #margin = min(200, nrow(data))
  margin = nrow(data)
  for(i in 1:margin)
  {
    line = data[i,]
    word <- as.character(line$word)
    count <- line$count
    
    vCount <- vocab[vocab$word==word,]$count
    
    if(length(vCount) == 0)
    {
      vCount <- 0
    }
    
    val <- val + (count - vCount)**2
  }
  
  val <- sqrt(val)
  
  return(val)
}

# Classification based on K nearest neighbors
knn_classify <- function(data, studentList, facultyList, courseList)
{
  K = 500
  sVal = 0
  cVal = 0
  fVal = 0
  
  data <- arrange(data, desc(count))
  
  distances <- data.frame(class=character(), dist=double())
  
  for (i in 1:length(studentList))
  {
    vocab = within(read.csv(studentList[i]), rm(X))
    d <- distance(data, vocab)
    newRow <- data.frame(class="S", dist=d)
    distances <- rbind(distances, newRow)
  }
  
  for (i in 1:length(facultyList))
  {
    vocab = within(read.csv(facultyList[i]), rm(X))
    d <- distance(data, vocab)
    newRow <- data.frame(class="F", dist=d)
    distances <- rbind(distances, newRow)
  }
  
  for (i in 1:length(courseList))
  {
    vocab = within(read.csv(courseList[i]), rm(X))
    d <- distance(data, vocab)
    newRow <- data.frame(class="C", dist=d)
    distances <- rbind(distances, newRow)
  }
  
  # Arrange the distances with smallest first
  distances <- arrange(distances, dist)
  
  K <- min(K, nrow(distances))
  
  for (i in range(1:K))
  {
    line = distances[i,]
    class <- as.character(line$class)
    
    if (class == "S")
    {
      sVal = sVal + 1
    }
    
    else if (class == "F")
    {
      fVal = fVal + 1
    }
    
    else
    {
      cVal = cVal + 1
    }
  }
  
  maxVal = max(sVal, fVal, cVal)
  
  if (maxVal == sVal)
  {
    return("S") 
  }
  
  else if (maxVal == fVal)
  {
    return("F")
  }
  
  return("C")
}

