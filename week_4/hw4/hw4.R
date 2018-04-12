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
