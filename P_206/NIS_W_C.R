library(hash)
library(tau)
library(Sejong)
library(KoNLP)
library(dplyr)
library(stringr)
library(tm)
library(SnowballC)
library(RColorBrewer)
library(wordcloud)
library(ggplot2)
library(cli)

useNIADic()

twitter1 = read.csv("C:/R24_bb/P_206/twitter.csv", header = T , encoding = "UTF-8")

twitter = rename(twitter1 ,
                 no = 번호,
                 id = 계정이름,
                 date = 작성일,
                 tw = 내용)

twitter$tw = str_replace_all(twitter$tw, "\\W" , " ")

head(twitter$tw)

nouns=extractNoun(twitter$tw)
wordcount_twit = table(unlist(nouns))

df_word_twit = as.data.frame(wordcount_twit, stringAsFactors = F)
class(df_word_twit)

df_word_twit = rename(df_word_twit,word=Val1,freq=Freq)
df_word_twit= filter(df_word_twit,ncharr(word)>=2)

top20_twit = df_word_twit %>%
arrange(desc(freq)) %>%
head(20)

order = arrange(top20_twit, freq)$word

ggplot(data= top20_twit, aes(x =word, y = freq))+
  ylim(0,2500) + geom_col() + coord_flip()+ scale_x_discrete(limit = order()+ geom_text(aes(label = freq),hjust = -0.3))

ggplot(data= top20_twit, aes(x =word, y = freq))+
  ylim(0,2500) + geom_col() + coord_flip()+ scale_x_discrete(limit= order() + geom_text(aes(lable = freq) , hjust = -0.3)) ## 이게 그래프 옆에 숫자의 근사위치

??freq
