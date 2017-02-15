library(tm)

documents = c("She had toast for breakfast",
 "The coffee this morning was excellent", 
 "For lunch let's all have pancakes", 
 "Later in the day, there will be more talks", 
 "The talks on the first day were great", 
 "The second day should have good presentations too")

documents <- documents <- Corpus(VectorSource(documents))
documents = tm_map(documents, content_transformer(tolower))
documents = tm_map(documents, removePunctuation)
documents = tm_map(documents, removeWords, stopwords("english"))

documents[[1]]$content
documents[[2]]$content
documents[[3]]$content
documents[[4]]$content
documents[[5]]$content
documents[[6]]$content