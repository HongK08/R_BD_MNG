library(ggplot2) # 12.18 wed TEST
library(dplyr)

us_map <- map_data('state')
head(us_map)

################################################################################
us_map %>%
  filter(region %in% c('north carolina' , 'south carolina')) %>%
  ggplot(aes(x = long , y=lat)) # point 안쓰면 당연히 안나오겠지?

us_map %>%
  filter(region %in% c('north carolina' , 'south carolina')) %>%
  ggplot(aes(x = long , y=lat)) + geom_point() # 이게 메인 방법
################################################################################
us_map %>%
  filter(region %in% c('north carolina','south carolina')) %>%
  ggplot(aes(x = long , y=lat)) + geom_path()   #Path // 정확한 테두리 라인을 잡음.
################################################################################
us_map %>%
  filter(region %in% c('north carolina','south carolina')) %>%
  ggplot(aes(x = long , y=lat , group=group)) + geom_path()   #Path // 정확한 테두리 라인을 잡은거에서 보조선 제거
################################################################################

#시험문제 폴리곤에서 색상 채우기 (아웃라인/인라인 개념)
us_map %>%
  filter(region %in% c('north carolina','south carolina')) %>%
  ggplot(aes(x = long , y=lat , group=group)) + geom_polygon(color="pink" , fill = "cyan") # cr =outline/fill = inbox

################################################################################

# 미국 전체 지도 // 그냥 filter값을 날려버리기.
ggplot(data=us_map, aes(long,lat, group = group)) + geom_polygon(color = 'red' , fill = "black")

#상위 지도에서 테마마를 날려버리고 그림만 뽑기 / x/y 그래프 축 값 표시 삭제
ggplot(data=us_map, aes(long,lat, group = group)) + geom_polygon(color = 'red' , fill = "black") +theme_void()

################################################################################

#해당 주에서 내부 도시명 이런거 뽑기 //sub region
maryland=map_data('county')
head(maryland,5)

baltimore = maryland %>%
filter(subregion %in% c('baltimore' , 'baltimore city'))
head(baltimore, 5)

maryland %>%
  filter(subregion %in%  c('baltimore' , 'baltimore city'))%>%
  ggplot(aes(long,lat,group = group))+ geom_polygon(color = 'red',fill = 'black') + theme_void()
  
  #자기가 원하는 지도 그려보기 즉 나라 to 주 to 도시 구분시켜서 뽑아보기
