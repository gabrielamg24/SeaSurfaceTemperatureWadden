
#SST Wadden Sea ![Wadden Sea](https://github.com/gabrielamg24/SST/blob/extras/waddensea.jpg)

##Sea Surface Temperature throughout time
###Python program that generates a video from color temperature based maps by running an R-script on data of sea surface temperature (SST) in the Wadden Sea 
==================
##Index
  - [Usage](#usage)
    - [Python](#python)
    - [R script](#r-script)
    - [How to](#how-to)
  - [Temperature map](#temperature-map)
  - [Features and advantages of this project](#features-and-advantages-of-this-project)
    - [Challenges](#challenges)
  - [Are we missing something?](#are-we-missing-something)
  - [License](#license)

---
##Usage 



###Python

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

The following script generates color-based temperature maps per month from 1993 to 2010 of sea surface temperature 

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

[R script with comments](https://github.com/gabrielamg24/SST/blob/master/gganimate.r)


###How to 
      **If you want to learn the basics to write a code like ours click [here](link) !**
       
---
##Temperature map 

![GIF FINALLY](https://github.com/gabrielamg24/SST/blob/master/1-iloveimg-compressed.gif)

--- 
##Features and advantages of this project


###Challenges

- [ ] set year range 
- [ ] extract data directly from python 
- [ ] set maximal temperature -Rscript

--- 
##Are we missing something? 

**Don't be shy, let us know!**
open an issue and we'll build this up together 

##License
>This project is licensed under the terms of the **GNU GENERAL PUBLIC LICENSE** license.
You can check out the full license [here](https://github.com/gabrielamg24/SST/blob/master/license.txt)


