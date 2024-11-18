install.packages("KoNLP")
library(KoNLP)

useNIADic()
extractNoun("대한민국은 민주공화국이다")

a1="대한민국은 민주공화국이다"
a2=data.frame(a1)

extractNoun("나는 집에 간다")


#########################################
install.packages("stringr")
library(stringr)

txt2 = read.csv("C:/R24_bb/P_206/wordCloud/txt2.txt")
head(txt2)



# df로 정의해서 File Imp 해서 쪼개서 값을 나눠서 쓴다 //TextMineing

df_word = as.data.frame(wordcount, stringAsFactors=F)
library(dplyr)
df_word = rename(df.word , word = Value , freq=Freq)

??rename

install.packages("wordcloud")
library(wordcloud)
library(RcolorBrewer)
wordcount = table(uninst(nouns))
wordcount

pal = brewer.pal(8, "dark2")
set.seed(1234)
wordcloud(words=)

install.packages("SnowballC")


#패키지로드
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

useNIADic()
useNIADic()

# 파일을 읽는다
txt <- readLines("C:/R24_bb/P_206/wordCloud/txt2.txt")
class(txt)
txt

# 문장으로 부터 명사를 추출한다
extractNoun(txt, autoSpacing = FALSE )

nouns <- extractNoun(txt,autoSpacing = FALSE)
nouns

library(wordcloud)
wordcount = table(unlist(nouns))
wordcount

df_word <- as.data.frame(wordcount , stringsAsFactors = F) ## rename <-- dyployr 에서 Improt 됨.
head(df_word)

df_word <- rename(df_word,
                  word = Var1,
                  freq = Freq)  ## 여기서 Df의 구조를 Redef 해내는거임

head(df_word)

df_word <- df_word %>% filter(nchar(word)>= 2) ## 글자를 골라낼건데 2자 이상의 글자만 골라낼거야 즉 filter값을 씀. <-- dyployr


top_20 <- df_word %>%
  arrange(desc(freq)) %>% ## 큰거부터 정렬시킨다 decs - 
  head(10) ## Head Value 에서 너가 골라낼 1부터 n까지의 수를 지정.
top_20


pal <- brewer.pal(8, "Dark2")

set.seed(1234)

wordcloud(words = df_word$word,  # 단어
          freq = df_word$freq,   # 빈도
          min.freq = 2,          # 최소 단어 빈도
          max.words = 200,       # 표현 단어 수
          random.order = F,      # 고빈도 단어 중앙 배치
          rot.per = .1,          # 회전 단어 비율
          scale = c(4, 0.3),     # 단어 크기 범위
          colors = pal)          # 색깔 목록


# 막대형 그래프 생성 (평균값 기준)
library(ggplot2)

df_word <- df_word %>% arrange(freq)

# 왼쪽부터 빈도수가 낮은 순서대로 막대 그래프 생성
ggplot(data = df_word, aes(x = reorder(word, freq), y = freq)) +
  geom_col(fill = "pink") +labs(title = "TOP 10 Words",x = "단어",y = "빈도수") +coord_flip()  # 좌표축 반전하여 막대를 세로로 표현





## Table 쓴 코드 재작성 해보고 word count // Data in R == data.frame <--으로 저장되어 있으니.

