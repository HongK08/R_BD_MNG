library(stringi)
library(dplyr)
library(ggiraphExtra)
library(ggplot2)
library(kormaps2014)
library(stringr)

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



  



