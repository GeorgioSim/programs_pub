##me beltistopoihsh prepei na to kanw: function gia ta plots.
library(readtext)
##watch at https://cran.r-project.org/web/packages/readtext/vignettes/readtext_vignette.html
library(readxl)
library("writexl")
library(ggplot2)
library(dplyr)
library(broom)
library(tidyselect)
library(ggthemes)
library(ggrepel)
library(ggpubr)
library(rgl)
##read.delim for manual choice
Rdata <- read.delim(file.choose())
View(Rdata)


x<-Rdata$y/Rdata$b
y<-Rdata$n
z<-Rdata$func

pl1<-plot3d( 
  x=x, y=y, z=z, 
  col = "green", 
  type = 's', 
  radius = .1,
  xlab="y/b", ylab="n", zlab="f")

#Rdata2 me 0.19<x/b<0.2
kxb<-Rdata$x/Rdata$b
Rdata2<-data.frame(filter(Rdata, kxb < 0.2 & kxb>0.19))

  
x<-Rdata2$y/Rdata2$b
y<-Rdata2$n
z<-Rdata2$func

pl2<-plot3d( 
  x=x, y=y, z=z, 
  col = "green", 
  type = 's', 
  radius = .1,
  xlab="y/b", ylab="n", zlab="f")



#Rdata3 me 0.29<x/b<0.3
kxb<-Rdata$x/Rdata$b
Rdata3<-data.frame(filter(Rdata, kxb < 0.3 & kxb>0.29))


x<-Rdata3$y/Rdata3$b
y<-Rdata3$n
z<-Rdata3$func

pl3<-plot3d( 
  x=x, y=y, z=z, 
  col = "green", 
  type = 's', 
  radius = .1,
  xlab="y/b", ylab="n", zlab="f")



#Rdata4 me 0.39<x/b<0.40
kxb<-Rdata$x/Rdata$b
Rdata4<-data.frame(filter(Rdata, kxb < 0.40 & kxb>0.39))


x<-Rdata4$y/Rdata4$b
y<-Rdata4$n
z<-Rdata4$func

pl4<-plot3d( 
  x=x, y=y, z=z, 
  col = "green", 
  type = 's', 
  radius = .1,
  xlab="y/b", ylab="n", zlab="f")



#Rdata5 me 0.49<x/b<0.50
kxb<-Rdata$x/Rdata$b
Rdata5<-data.frame(filter(Rdata, kxb < 0.50 & kxb>0.49))


x<-Rdata5$y/Rdata4$b
y<-Rdata5$n
z<-Rdata5$func

pl5<-plot3d( 
  x=x, y=y, z=z, 
  col = "green", 
  type = 's', 
  radius = .1,
  xlab="y/b", ylab="n", zlab="f")


#Rdata6 me 0.59<x/b<0.62
kxb<-Rdata$x/Rdata$b
Rdata6<-data.frame(filter(Rdata, kxb < 0.62 & kxb>0.59))


x<-Rdata6$y/Rdata6$b
y<-Rdata6$n
z<-Rdata6$func

pl6<-plot3d( 
  x=x, y=y, z=z, 
  col = "green", 
  type = 's', 
  radius = .1,
  xlab="y/b", ylab="n", zlab="f")
