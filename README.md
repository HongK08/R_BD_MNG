# R_BD_MNG

데이터랑 지도값을(ggplot//mapdata) 불러오고 소문자로 바꿔서 지도그릴준비
long+lat 잡아서 지도그려주기 기억나지
# ggChropleth

ggChoropleth(data=crime,aes(fill=state, map_id=state), map=state_map, interactive = T)
채울 데이터 준비 맵의 지역 aes내 지정은 원래 하던 그거대로 // interactive = T / 얜 반응하는거

tibble 패키지 사용 + 소문자로 변경한다.

# 대충 미국 투표율 그리기

library(tibble)
library(ggplot2)
library(maps) # 필수임

# dataset선택하기
data("votes.repub") 

# Convert to dataFrame 
votes.repub=as.data.frame(votes.repub)

vote=rownames_to_column(votes.repub, var="region")

vote$region = tolower(vote$region)

us_map=map_data("state")

vote%>%
  right_join(us_map, by='region') %>%
  ggplot(aes(x=long, y=lat,group = group , fill='1988'))+
  geom_polygon(color='red') + theme_void()



