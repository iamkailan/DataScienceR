# Load packages
library('ggplot2') # visualization
library('ggthemes') # visualization
library('scales') # visualization
library('dplyr') # data manipulation
library('mice') # imputation
library('rpart')
library('randomForest') # classification algorithm
# 導入資料
train <- read.csv('/Users/sophiasufas/Desktop/R/GitHub/DataScienceR/DataScienceR/week_8/hw8/train.csv', stringsAsFactors = F)
test  <- read.csv('/Users/sophiasufas/Desktop/R/GitHub/DataScienceR/DataScienceR/week_8/hw8/test.csv', stringsAsFactors = F)
test$Survived <- NA
train_test <- rbind(train,test)
# 處理資料中缺少的變量
sapply(train_test,function(x) sum(is.na(x)))
sapply(train_test,function(x) sum(x == ""))
# 查看Fare缺失值的乘客基本信息
faremiss <- which(is.na(train_test$Fare))
train_test[faremiss,]  
# 視覺化其他人票價
Fareage <- ggplot(train_test[train_test$Pclass=='3' & train_test$Embarked=='S' & train_test$Age>=50 ,],
                aes( x=Fare )) +
  geom_density( fill = '#99d6ff',alpha=0.4 ) + #畫密度曲線
  geom_vline(aes(xintercept=median(Fare,na.rm=T)),colour='red',linetype='dashed') +
  ggtitle("Fare1:Age considered") +
  scale_x_continuous(labels=dollar_format()) +
  theme_few()
Fareothers <- ggplot(train_test[train_test$Pclass=='3' & train_test$Embarked=='S',], 
                     aes( x=Fare )) +
  geom_density(fill = '#99d6ff',alpha=0.4 ) +
  geom_vline(aes(xintercept=median(Fare,na.rm=T)),colour='red',linetype='dashed' ) +
  ggtitle("Fare2:Regardless of age") + 
  scale_x_continuous(labels=dollar_format()) +
  theme_few()
library(gridExtra)
grid.arrange(Fareage, Fareothers, ncol=2, nrow=1)
#看具體數值(中位數)來比較繪圖的精準度
Fareage <- median(train_test[train_test$Pclass=='3' & train_test$Embarked=='S' & train_test$Age>=50 ,]$Fare,
                  na.rm = TRUE)
Fareage
Fareothers <- median(train_test[train_test$Pclass=='3' & train_test$Embarked=='S' ,]$Fare,
                     na.rm = TRUE)
Fareothers
train_test$Fare[faremiss] <- 8.00
#觀察票價與存活率的相關程度
ggplot(train_test[1:891,], aes(x = Fare, color = factor(Survived))) +
  geom_line(stat='count', position='dodge') +
  theme_few()
# Embarked
embarkedmiss <- which(train_test$Embarked=="")
train_test[embarkedmiss,]
embark_fare <- train_test %>% #去除有缺值的行
  filter(PassengerId != 62 & PassengerId != 830)
# 視覺化登船港口與艙等和票價的關係
ggplot(embark_fare, aes(x = Embarked, y = Fare, fill = factor(Pclass))) +
  geom_boxplot() +
  geom_hline(aes(yintercept=80), 
             colour='red', linetype='dashed', lwd=2) +
  scale_y_continuous(labels=dollar_format()) +
  theme_few()
train_test$Embarked[c(62, 830)] <- 'C'
train_test$Embarked <- factor(train_test$Embarked)
# 新特徵-家庭規模
train_test$familysize <- train_test$SibSp + train_test$Parch +1
# 視覺化家庭規模與存活率的關係
ggplot(train_test[1:891,], aes(x = familysize, fill = factor(Survived))) +
  geom_bar(stat='count', position='dodge') +
  scale_x_continuous(breaks=c(1:11)) +
  labs(x = 'Family Size') +
  theme_few()
train_test$familysize <- as.factor(train_test$familysize)
# 乘客頭銜
train_test$Ptitle <- gsub('(.*, )|(\\..*)', '', train_test$Name)
table(train_test$Sex, train_test$Ptitle) #根據性別來顯示頭銜
#整理
rare_title <- c('Dona', 'Lady', 'the Countess','Capt', 'Col', 'Don', 
                'Dr', 'Major', 'Rev', 'Sir', 'Jonkheer')
train_test$Ptitle[train_test$Ptitle == 'Mlle']        <- 'Miss' 
train_test$Ptitle[train_test$Ptitle == 'Ms']          <- 'Miss'
train_test$Ptitle[train_test$Ptitle == 'Mme']         <- 'Mrs' 
train_test$Ptitle[train_test$Ptitle %in% rare_title]  <- 'Rare Title'
train_test$Ptitle <- as.factor(train_test$Ptitle)
table(train_test$Sex, train_test$Ptitle)
# Age
age_model <- rpart(Age~Pclass+Sex+SibSp+Parch+Fare+Embarked+Ptitle+familysize,
                   data=train_test[!is.na(train_test$Age),],method='anova')
train_test$Age[is.na(train_test$Age)] <- predict(age_model,train_test[is.na(train_test$Age),])
# 查看年齡、性別與存活率的關係
ggplot(train_test[1:891,], aes(Age, fill = factor(Survived))) + 
  geom_histogram() + 
  facet_grid(.~Sex) + 
  theme_few()
## 新特徵-年齡段
train_test$Age_group[train_test$Age <= 12] <- 'Child'
train_test$Age_group[train_test$Age > 12 & train_test$Age < 18] <- 'youth'
train_test$Age_group[train_test$Age >= 18] <- 'Adult'
train_test$Age_group  <- factor(train_test$Age_group)
mosaicplot(table(train_test$Age_group,
                 train_test$Survived),main='Comparison of child and adult',
           color=c("pink","lightblue"))
#建模預測
train_test$Sex <- as.factor(train_test$Sex)
train <- train_test[1:891,]
test <- train_test[892:1309,]
set.seed(754) #隨機種子
rf_model <- randomForest(factor(Survived) ~ Sex + Ptitle + Pclass + Embarked +
                           Age_group + Fare + familysize, data = train)
prediction <- predict(rf_model, test)
solution <- data.frame(PassengerID = test$PassengerId, Survived = prediction)
write.csv(solution, file = 'hw8.csv', row.names = F)
