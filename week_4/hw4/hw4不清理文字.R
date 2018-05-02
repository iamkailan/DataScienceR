require("Rfacebook")
library(NLP)
library(tm)
library(jiebaRD)
library(jiebaR)
library(RColorBrewer)
library(wordcloud)
#?????y?Ѹ???
token <-"EAACEdEose0cBAI7rLkn5SPSWSSS3hyYYDdhFObKJC1NWQsw7vQbzZCqrLDOzi8hk6p3PEZC4uxhqw4o8TYYZBA1Ls6yhpNsZCtQ3mYDhYWvuO2AhtIrZBP62tqUm3MjzqU7Lu5G1ZC2CNXdj3y4ZBpmJCZBVi9AiS32DLUqUJc16YpYeKjJxMxnRz1fTIFPQNjzZA6FFOOZAw4TwZDZD"
page.id <- "445164788956922" 
page <- getPage(page.id, token, n = 300)
wordcloud(page$message)
