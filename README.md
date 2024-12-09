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



    library(stringi)
    library(dplyr)
    library(ggiraphExtra)
    library(ggplot2)
    library(kormaps2014)
    library(stringr)
    library(readxl)
    
    # 이 코드들이 전체 남한 지도를 나타내는 거임임
    
    korpop1 = kormaps2014::korpop1
    kormap1 = kormaps2014::kormap1
    
    korpop1 = rename(korpop1, pop=총인구_명, name = 행정구역별_읍면동)
    
    ggChoropleth(data = korpop1, aes(fill = pop, map_id = code, tooltip = name) , map = kormap1, interactive = T)
    
    # 그러면 이제 강원도도 해보자
    ex_pop_kw= data.frame(총인구_명 = c(1518040), 행정구역별_읍면동=c('강원도'),code=c(32))
    ggChoropleth(ex_pop_kw, aes(fill = 총인구_명, map_id = code, tooltip = 행정구역별_읍면동), map=kormap1, interactive = T)
    
    
    # 그다음으로 강원도 세부 지역을 보는거임 (korpop2 를 안 쓰니 뭐가 없는거임임)
    ex_pop_kw_1 = korpop1 %>%
      filter(str_detect(행정구역별_읍면동, 'A강원도')) %>%
      select(총인구_명, code, 행정구역별_읍면동)
    ggChoropleth(ex_pop_kw_1, aes(fill = 총인구_명 , map_id = code , tooltip = 행정구역별_읍면동), map = kormap1, interactive = T)
    
    
    # 다음 kormap2를 써서 그려내는 작업이야
    korpop2_kangwon = korpop2 %>%
      filter((code >= 32000) & (code <= 33000)) %>%
      select(code, 총인구_명 , 행정구역별_읍면동)
    ggChoropleth(korpop2_kangwon, aes(fill= 총인구_명, map_id = code , tooltip = 행정구역별_읍면동),map=kormap2, interactive = T)
    
    
    # 그다음 군 단위로 방식의 다른 방식을 사용한거야
    korpop2_kangwon_str = korpop2 %>%
      filter(str_detect(code, '^32'))%>%
      select(code, 총인구_명, 행정구역별_읍면동)
    ggChoropleth(korpop2_kangwon_str, aes(fill= 총인구_명 , map_id = code , tooltip = 행정구역별_읍면동),map=kormap2, interactive = T)
    
    
    # 해봤으면 다른 시시를 찍어먹어보기
    korpop2 = kormaps2014::korpop2
    kormap2 = kormaps2014::kormap2
    
    korpop2_changWon_str = korpop2%>%
      filter(str_detect(code, '^38'))%>%
      select(code, 총인구_명 , 행정구역별_읍면동)
    ggChoropleth(korpop2_changWon_str, aes(fill = 총인구_명, map_id = code , tooltip = 행정구역별_읍면동),map=kormap2, interactive = T)
    
    # 그다음으로 다른 도 뽑아보자
    korpop3 = kormaps2014::korpop3
    kormap3 = kormaps2014::kormap3
    
    korpop3_Gyeongsangnam_do = korpop3 %>%
      filter(str_detect(code, '^38'))%>%
      select(code, 총인구_명, 행정구역별_읍면동)
    
    gido_korpop3_Gyeongsangnam_do_dong=ggChoropleth(korpop3_Gyeongsangnam_do, aes(fill = 총인구_명, map_id = code , tooltip = 행정구역별_읍면동), map=kormap3, interactive = T)
    
    gido_korpop3_Gyeongsangnam_do_dong

# 여기까지가 지도 그리기였구 이제는 지도 셋에 데이터를 추가해보자

## 서울에서의 코로나 지도 그리기
CV_UN_DT = kormaps2014::korpop3
CV_UN_DA = kormaps2014::kormap3
COVID_MM = read_excel('C:/Users/user/Desktop/FN.xlsx')

DT_DST<- df1 %>%> left_join()


korpop3_SUL_CORONA_M = DT_DST %>%
  filter(str_detect(code, '^32'))%>%
  select(code, 누적확진자_명 , 누적사망자_명)
ggChoropleth(korpop3_SUL_CORONA_M, aes(fill = 누적확진자_명 , map_id = code, tooltip =시군구),map = kormap2, interactive = T)
