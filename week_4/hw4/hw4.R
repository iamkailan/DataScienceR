require("Rfacebook")
library(NLP)
library(tm)
library(jiebaRD)
library(jiebaR)
library(RColorBrewer)
library(wordcloud)
#抓取臉書資料
token <-"EAACEdEose0cBAEkjMBQPustP041kxGh1nHBX5x4dvkqbjqTuGyMS7kEWqfPzaMuQRdr1dZARVZCvvXXnkeFRXLT3JEVIOCGPjs6qlctrwHD7mk0ZBDZBnLMEfkQYZAZBWn9tez77mqOJfdnCPWKOoebuZBKVVDtZBSmx1z1BtDdCdILnp7NT0RoZAGbySZBZANrPaIX58xSkC9wBwZDZD"
me <- getUsers("me", token, private_info = TRUE)
me$name
page.id <- "445164788956922" 
page <- getPage(page.id, token, n = 300)
#文本清理
docs <-Corpus(VectorSource(page$message))
toSpace <- content_transformer(function(x, pattern){
  return(gsub(pattern," ", x))}
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
#文字雲
mixseg = worker()
jieba_tokenizer=function(d){
  unlist(segment(d[[1]],mixseg))
}
seg = lapply(docs, jieba_tokenizer)
freqFrame = as.data.frame(table(unlist(seg)))
freqFrame = freqFrame[-c(1:34),]
wordcloud(freqFrame$Var1,freqFrame$Freq,
          scale=c(5,0.5),min.freq=10,max.words=50,
          random.order=FALSE, random.color=TRUE, 
          rot.per=0, colors=brewer.pal(8, "Dark2"),
          ordered.colors=FALSE,use.r.layout=FALSE,
          fixed.asp=TRUE)

