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


# 한국 지도에서 상세 지도 그려보기

kormaps2014 불러오기
korpop1

대충 단계 구분도의 조건 DATA , aes(fill, map_id, tooltip= 지정해주고)+interective set.
tooltip

1.데이터가 있어야 함 + 전처리
2. kormap - korpop1/2(상세인구수를 표현해서 보여줌) - 상세지역 이 순서로 지정을 해주어야 함
3. dataset을 df로 전환 후 총인구() , 대충 상세적으로 더 진입() 

이렇게하던지 filter박아서 %>% 로 넘기던지 

여기서 인구수까지 보고싶으면 2항의 내용을 가져와서
1안 또는 filter안으로 그리면 된다 filter(str_detect())+select() 해주면 되니까

  #KORPOP2 
  korpop2_kangwon = korpop2 %>%
    filter((code>=32000) & (code <33000)) %>%                                     ## 이거 아니면 str_detect 쓰던지 맘대로 해볼것
    select(code, 총인구_명 행정구역별_읍면동)
  korpop2_kangwon
  ggChoropleth(kormap2_kangWon, aes(fill=총인구_명,map_id = code , tooltip = 행정구역별_읍면동), map=kormap2 , interactive = T)
  
                                                  #이걸 통해 알수있는거 지도 데이터+지도에 표시할 데이터+중심축 이 필수적이라는 거읾..


