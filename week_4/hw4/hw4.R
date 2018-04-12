require("Rfacebook")
library(NLP)
library(tm)
library(jiebaRD)
library(jiebaR)
library(RColorBrewer)
library(wordcloud)

token <-"EAACEdEose0cBANNQvF3w8KoVLeIo2vFfZAxdSz2OFsN9tGeoX7AksqYdG6hUEO4uDM1KugVs9h5w6vFADyhZBLudWfwzcDJcIfOxpqVwsjg9C1CZABQAMpx0ZCIkzgL5JNIjgMBzRZBIpPRWiJtUZCrWrbqM2DnudrK6bBquJsnPZAyZBRk2Mguz6bByjtOno3oDLqOgBnB0eQZDZD"
me <- getUsers("me", token, private_info = TRUE)
me$name
page.id <- "445164788956922 
page <- getPage(page.id, token, n = 100)
docs <- Corpus(VectorSource(page$message))
toSpace <- content_transformer(function(x, pattern) {
  return (gsub(pattern, " ", x))}
)
docs <- tm_map(docs, toSpace, "的")
docs <- tm_map(docs, toSpace, "啊")
docs <- tm_map(docs, toSpace, "站")
docs <- tm_map(docs, toSpace, "有")
docs <- tm_map(docs, toSpace, "了")
docs <- tm_map(docs, toSpace, "是")
docs <- tm_map(docs, toSpace, "很")
docs <- tm_map(docs, toSpace, "都")
docs <- tm_map(docs, toSpace, "在")
docs <- tm_map(docs, toSpace, "和")
docs <- tm_map(docs, toSpace, "這")
docs <- tm_map(docs, toSpace, "讓")
docs <- tm_map(docs, toSpace, "跟")
docs <- tm_map(docs, toSpace, "就")
docs <- tm_map(docs, toSpace, "真")
docs <- tm_map(docs, toSpace, "上")
docs <- tm_map(docs, toSpace, "但")
docs <- tm_map(docs, toSpace, "又")
docs <- tm_map(docs, removePunctuation)
docs <- tm_map(docs, removeNumbers)
docs <- tm_map(docs, stripWhitespace)
          
