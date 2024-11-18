library(tibble)
library(ggplot2) # 지도그릴거잖아 + 맵 라이브러리 올려줘
install.packages("ggiraphExtra") # 이게 메인 지도네
library(ggiraphExtra)
library(maps)

str(USArrests) # 기본으로 데이터값이 들어있는 DF

crime=rownames_to_column(USArrests, var = "state") # 주라는 항목의 Atri를 정의해주기 / 비었으니까
head(crime)

crime$state = tolower(crime$state) # 소문자로 바꿔주기

head(crime,5)
str(crime)

####
??map_data
state_map=map_data("state")

head(state_map,5)
str(state_map)

#ggplot 으로 미국 지도 그리기 for state
ggplot(data=state_map, aes(long,lat, group = group)) + geom_polygon(color = 'white')

ggChoropleth(data=crime,aes(fill=state, map_id=state, tooltip=name), map=state_map, interactive = T)
# 해석 (data를 Crime 쓴다는거고 aes ggplot이랑 같아 fill= 채운다 (즉 데이터 값으로) , tooltip은 이름 + mapdata+interactive =T) 해주기
# fill value 에 state 넣으면 지도 싹 나옴

map('usa', fill=TRUE , col = 1:10)
us1 <- rnaturalearth::ne_states("usa")
## Maps lib 사용해서 프랑스 지도 그리기
map('france', fill = TRUE, col = 1:10)
fr1 <- rnaturalearth::ne_states("france")
france2 <- map(fr1, xlim=c(-20, 20), ylim=c(30, 60), lforce="e", 
               fill=TRUE, plot=FALSE)

## ggplot으로 France 그리기
France_map=map_data('france')
ggplot(data=France_map, aes(long, lat , group = group)) + geom_polygon(color = 'white') # 이런식으로 그려지게 된다잉.

## 다른나라 그려보기.
# region 써서 map으로 못끌고오는거 수동으로 지정해준다
ISL_Map=map_data("world", region = 'Israel') 
ggplot(ISL_Map, aes(long, lat, group = group)) + geom_polygon(color = "black" , fill = "cyan")

## KOREA S.
KR_Map=map_data("world", region = 'South Korea') 
ggplot(KR_Map, aes(long, lat, group = group)) + geom_polygon(color = "black" , fill = "cyan")
##DPRK
DPRK_Map=map_data("world", region = 'North Korea') 
ggplot(DPRK_Map, aes(long, lat, group = group)) + geom_polygon(color = "black" , fill = "cyan")
## N+S =K MAP
korea <- map_data("world", region = c("North Korea", "South Korea")) #레이아웃의 병합이 가능함.  c()
ggplot() + geom_polygon(data=korea, aes(x=long, y=lat, group=group, fill=region),colour="black") + scale_fill_brewer(palette="Set1")


##다음번에는 DataSet을 넣어보자.

