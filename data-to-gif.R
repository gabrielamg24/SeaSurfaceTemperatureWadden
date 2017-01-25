#This script is used to produce a .gif image of the data.

#Load packages
library(ggplot2)
library(animation)

#Load data
data<-read.table("All_data.txt",sep=",",header=T)
str(data)

#Make plots and save them as a .gif file
saveGIF({
    for (i in unique(data$"Year.Month")) {
        print(
ggplot(data,aes(Longitude,Latitude,color=Temperature))+geom_point()+
scale_colour_gradient2(limits=c(min(data$Temperature),
max(data$Temperature)),low="turquoise1",mid="goldenrod1",high="red2",
midpoint=283.5)+ggtitle(data$Year)
)
    }
}, interval = 0.2, movie.name = "ggplot2-brownian-motion.gif", ani.width = 600, ani.height = 600)

