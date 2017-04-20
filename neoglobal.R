library(sqldf)

# Merge two dataframes

mergeDF <- function(df1, df2)
{
  word1 <- as.character(df1$word)
  word2 <- as.character(df2$word)
  uWords = unique(c(word1, word2))
  
  count <- rep(0, length(uWords))
  
  vocab = data.frame(word=uWords, count=count, stringsAsFactors=FALSE)
  
  vocab <- sqldf("select * from vocab left join df1 using (word) left join df2 using (word)")
  
  vocab <- transform(vocab, count = rowSums(vocab[, 2:4], na.rm = TRUE))
  
  vocab <- within(vocab, rm(count.1))
  vocab <- within(vocab, rm(count.2))
  
  return(vocab)
}

# Make global vocabs great again
neoglobal <- function(studentList, courseList, facultyList, name)
{
  vocab = within(read.csv(studentList[1]), rm(X))
  for (i in 2:length(studentList))
  {
    sample = within(read.csv(studentList[i]), rm(X))
    vocab <- mergeDF(sample, vocab)
  }
  
  outfile = paste("output/", name, "Student.csv", sep = "")
  write.csv(vocab, outfile)
  
  vocab = within(read.csv(facultyList[1]), rm(X))
  for (i in 2:length(facultyList))
  {
    sample = within(read.csv(facultyList[i]), rm(X))
    vocab <- mergeDF(sample, vocab)
  }
  
  outfile = paste("output/", name, "Faculty.csv", sep = "")
  write.csv(vocab, outfile)
  
  vocab = within(read.csv(courseList[1]), rm(X))
  for (i in 2:length(courseList))
  {
    sample = within(read.csv(courseList[i]), rm(X))
    vocab <- mergeDF(sample, vocab)
  }
  
  outfile = paste("output/", name, "Course.csv", sep = "")
  write.csv(vocab, outfile)
}

# Merges four vocabularies together
combineVocabs <- function(v1, v2, v3, v4)
{
  # Read the four vocabs
  v1 = within(read.csv(v1), rm(X))
  v2 = within(read.csv(v2), rm(X))
  v3 = within(read.csv(v3), rm(X))
  v4 = within(read.csv(v4), rm(X))

  # Merge v1 and v2
  v1 <- mergeDF(v1, v2)
  
  # Merge v1 and v3
  v1 <- mergeDF(v1, v3)
  
  # Merge v1 and v4
  v1 <- mergeDF(v1, v4)
  
  # Return the newly merged vocab
  return(v1)
}

mergeLists <- function(l1, l2, l3, l4)
{
  l1 <- list.files(path=l1, full.names = T, recursive = T)
  l2 <- list.files(path=l2, full.names = T, recursive = T)
  l3 <- list.files(path=l3, full.names = T, recursive = T)
  l4 <- list.files(path=l4, full.names = T, recursive = T)
  
  return(c(l1, l2, l3, l4))
}