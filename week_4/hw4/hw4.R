require("Rfacebook")
library(NLP)
library(tm)
library(jiebaRD)
library(jiebaR)
library(RColorBrewer)
library(wordcloud)

token <-"EAACEdEose0cBAKMbgO5ZBLStLpYYscaKTy3PglgNyXYn3msmuIbr4BPPmln6BzIL7D5yAy5iM7fZAbSYgj3J8RTZAFPZBDzzI2ue7ebr6Td3Glz6GqtYevNVmIAWpjuZC7kXcJxldGeHplx5UwiuISlxSbA50uZCZAjf9wxQ7sLqUrxyXycuzrVXt3OfPrK4wZBHznJGjAF5yQZDZD"
me <- getUsers("me", token, private_info = TRUE)
me$name
page.id <- "445164788956922" 
page <- getPage(page.id, token, n = 300)
str(page)
