require("Rfacebook")
library(NLP)
library(tm)
library(jiebaRD)
library(jiebaR)
library(RColorBrewer)
library(wordcloud)
#?????y?Ѹ???
token <-"EAACEdEose0cBAEkjMBQPustP041kxGh1nHBX5x4dvkqbjqTuGyMS7kEWqfPzaMuQRdr1dZARVZCvvXXnkeFRXLT3JEVIOCGPjs6qlctrwHD7mk0ZBDZBnLMEfkQYZAZBWn9tez77mqOJfdnCPWKOoebuZBKVVDtZBSmx1z1BtDdCdILnp7NT0RoZAGbySZBZANrPaIX58xSkC9wBwZDZD"
page.id <- "445164788956922" 
page <- getPage(page.id, token, n = 300)
