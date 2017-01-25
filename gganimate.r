library(ggplot)
library(cowplot)
library(ggmap)
library(gganimate)


setwd("~/Downloads")
data<-read.table("All_data.txt",sep=",",header=T)
str(data)

lon<-mean(min(data$Longitude),max(data$Longitude))
lat<-mean(min(data$Latitude),max(data$Latitude))
map<-get_map(location=c(lon,lat),zoom=6,maptype="watercolor")

p<-ggmap(map,base_layer=ggplot(data,aes(Longitude,Latitude,color=Temperature,frame=Year.Month)))+
geom_point()+
scale_colour_gradient2(limits=c(min(data$Temperature),
max(data$Temperature)),low="turquoise1",mid="goldenrod1",high="red2",
midpoint=283.5)

gganimate(p)
