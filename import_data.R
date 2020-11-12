library(tidyverse)
library(tidyr)
library(tidyverse)

url<-c("https://raw.githubusercontent.com/hamishgibbs/colocation_dashboard/master/UK/data/mean_ts.csv")

raw<-read.csv(url)

face<-raw%>%
  filter(type=="abs_value")%>%
  rename(region=polygon1_name)%>%
  rename(date=ds)%>%
  rename(country=NAME_1)%>%
  rename(gid_1=GID_2)%>%
  rename(region_type=TYPE_2)%>%
  mutate(date=as.Date(date, format="%Y-%m-%d"))

face%>%
  ggplot(aes(date, mean_colocation, colour=region))+
  geom_line(show.legend = FALSE)+
  theme_bw()+
  scale_x_date(date_breaks = "1 month", date_labels = "%b")+
  labs(x="", y="Mean colocation, by UK GADM region")


