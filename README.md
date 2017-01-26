
#Sea Surface Temperature ![Wadden Sea](https://github.com/gabrielamg24/SST/blob/extras/waddensea.jpg)

##Sea Surface Temperature throughout time
###Python program that generates a video from color temperature based maps by running an R-script on data of sea surface temperature (SST) in the Wadden Sea 
==================
##Index
  - [Usage](#usage)
    - [Shell](#shell)
    - [Python](#python)
    - [R script](#r-script)
    - [How to](#how-to)
  - [RESULTS!!!](#results)
  - [Features and advantages of this project](#features-and-advantages-of-this-project)
    - [Challenges](#challenges)
  - [Are we missing something?](#are-we-missing-something)
  - [License](#license)

---
##Usage 

For creating color temperature based maps and seeing them in gif format you need to run the following shell script! 

First step is heading over to http://www.esa-sst-cci.org/PUG/map.htm and downloading data from the region that interests you! 

For running the program in your computer you ned to have **Python** and **R 3.2.2** installed. You will also need to download the following files into a single folder: 

[Shell script](change link )
[Python script](https://github.com/gabrielamg24/SST/blob/master/format-data.py)
[R script](https://github.com/gabrielamg24/SST/blob/master/gganimate.r)
[Data files](https://github.com/gabrielamg24/SST/blob/master/SST%20all%20files.zip) (use these files as an example!)

###Shell 

###Python

This script will help you rearrange your data files and compile them into one!

          #! /usr/bin/env python

          import re
          import glob
     
          Header = 'Latitude,Longitude,Year.Month,Temperature\n'
          data = open("All_data.txt",'w')
          data.write(Header)
          data.close()

          for filename in glob.glob('*.csv'):
            with open(filename,'r') as f:
              for line in f:
               
                if "Latitude" in line:
                  Latitude = re.sub(r".\s\bLatitude\b\:\s(.*\d+\..*\d+)\n",r"\1",line)
                elif "Longitude" in line:
                  Longitude = re.sub(r".\s\bLongitude\b\:\s(.*\d+\..*\d+)\n",r"\1",line)			
                    else:
                  newline = "%s,%s,%s" % (Latitude,Longitude,line)
                                         
                                          match = re.sub(r'^(\w+.\w+),(-*\w+.\w+),(\w+)-(\w+)-\w+:\w+:\w+.\w+(\w+.\w{1,3}).*',r"\1,\2,\3-\4,\5",newline)                                        
                                          match = re.sub(r'^(\w+.\w+),(-*\w+.\w+),T.*',r"",match)                                       
                        match = re.sub(r'^\n',r"",match)
                  f2 = open ('All_data.txt','a')
                  f2.write(match)
                  f2.close()

[Python script with comments](https://github.com/gabrielamg24/SST/blob/master/format-data.py)

###R script

The following R-script generates color-based temperature maps per month from 1993 to 2010 of sea surface temperature. 

If you don't have ggplot2 and ggmap installed in your packages, just do it by writing install.packages("name of package")
         
          library(ggplot2)
          library(ggmap)

          data<-read.table("All_data.txt",sep=",",header=T)
          #str(data)

          lon<-mean(c(min(data$Longitude),max(data$Longitude)))
          lat<-mean(c(min(data$Latitude),max(data$Latitude)))
          map<-get_map(location=c(lon,lat),zoom=6,maptype="satellite")

          print
          
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
          #Save the plot into a .png file:
          ggsave(plot=p,filename=paste(year.month[i],".png",sep=""),width=8,height=8,dpi=100)
          }

          print("Your maps are plotted and will now be combined into a .gif file.")

[R script with comments](https://github.com/gabrielamg24/SST/blob/master/gganimate.r)

###How to 
      **If you want to learn the basics to write a code like ours click [here](link) !**
       
---
##RESULTS!!! 

![GIF FINALLY](https://github.com/gabrielamg24/SST/blob/master/maps.gif)

--- 
##Features and advantages of this project

You can run it directly from shell, you just need the files, R and python script in your computer and you're set!

You have a clear explanation of each step needed to create your .gif



###Challenges

- [ ] set year range (using raw_input in Python)
- [ ] extract data directly from python (program Selenium)
- [ ] set maximal temperature for a species survival -Rscript 

--- 
##Are we missing something? 

**Don't be shy, let us know!**
open an issue and we'll build this up together 

##License
>This project is licensed under the terms of the **GNU GENERAL PUBLIC LICENSE** license.
You can check out the full license [here](https://github.com/gabrielamg24/SST/blob/master/license.txt)


