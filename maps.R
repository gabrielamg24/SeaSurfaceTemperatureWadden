library(ggplot2)
library(cowplot)
library(ggmap)
library(gganimate)
library(grid)


setwd("~/Downloads")
data<-read.table("All_data.txt",sep=",",header=T)
str(data)

lon<-mean(c(min(data$Longitude),max(data$Longitude)))
lat<-mean(c(min(data$Latitude),max(data$Latitude)))
map<-get_map(location=c(lon,lat),zoom=6,maptype="satellite")


year.month<-as.factor(unique(data$"Year.Month"))
for( i in seq_along(year.month)){
p<-ggplot(data[data$"Year.Month"==year.month[i],],
aes(Longitude,Latitude,color=Temperature))
p<-ggmap(map,base_layer=p)+
theme_minimal()+geom_point(cex=2)+
scale_colour_gradient2(limits=c(min(data$Temperature),
max(data$Temperature)),low="turquoise1",mid="goldenrod1",high="red2",
midpoint=283.5)+xlab("Longitude (°East)")+ylab("Latitude (°North)")+
theme(plot.background = element_blank(),panel.grid.major = element_blank(),
panel.grid.minor = element_blank())+theme(panel.border= element_blank())+
theme(legend.position="right")+
theme(plot.title = element_text(size=25),axis.title = element_text(size=22),
axis.text = 
element_text(size=22),legend.title=element_text(size=18),legend.text=element_text(size=15))+
theme(strip.text.x=element_blank())+
theme(plot.background = element_rect(fill = "white",colour="white"))+ggtitle(year.month[i])
ggsave(plot=p,filename=paste(year.month[i],".png",sep=""),width=8,height=8,dpi=100)
}
