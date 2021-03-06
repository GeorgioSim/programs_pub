##AM:1110201800159
##Askhsh D6 ergastiriou fysikis 4

#Gia na leitoyrgisei thelei etoima data morfhs
#x,y,x_SE,y_SE (standard errors) apo excel arxeio

library(readxl)
library(ggplot2)
library(dplyr)
library(broom)
library(tidyselect)
library(ggthemes)
library(ggrepel)
library(ggpubr)
args(ggplot)

Rdata<-read_excel("D6.xlsx")
View(Rdata)
x<-Rdata$`Ik[A]`
x2<-Rdata$`Ig[A]`
y<-Rdata$`Vk[V]`
y2<-Rdata$`Vg[V]`
y3<-Rdata$`a`
SE_x<-Rdata$`d_Ik[A]`
SE_x2<-Rdata$`d_Ig[A]`
SE_y<-Rdata$`d_Vk[V]`
SE_y2<-Rdata$`d_Vg[V]`
SE_y3<-Rdata$`d_a`

#linear regression, tha xreiastei meta sto geom_abline
mod<-lm(y ~ x)
summary(mod)
attributes(mod) #gia na dw ti exei san attributes
mod$coefficients  #slope kai intercept

mod2<-lm(y2 ~ x2)
summary(mod2)
attributes(mod2) #gia na dw ti exei san attributes
mod2$coefficients  #slope kai intercept

mod3<-lm(y3 ~ x2)
summary(mod3)
attributes(mod3) #gia na dw ti exei san attributes
mod3$coefficients  #slope kai intercept

# selida 563
p <-ggplot()+
  geom_point(data=Rdata, aes(x,y), size = 2, color ="blue")+
  xlab("Ik[A]") +
  ylab("Vk[V]") +
  ggtitle("1100 RPM")+
  geom_errorbar(data=Rdata,mapping=aes(x=x,ymin = y-SE_y,ymax = y+SE_y), width=0.01) +
  geom_errorbarh(data=Rdata,mapping=aes(y=y,xmin = x-SE_x,xmax = x+SE_x))
p  


#geom_abline eytheia elaxistwn + text gia abline
p<-p+ geom_abline(intercept = mod$coefficients[[1]], slope = mod$coefficients[[2]], color="blue")
p
xtext<- 0.05*(max(x)-min(x))+min(x)
ytext<- 0.99*(max(y)-min(y))+min(y)
cat(sprintf("y=%s x+ %s\n",  mod$coefficients[[2]],  mod$coefficients[[1]]),"\n",file="test.txt")
test2 <- readLines("test.txt")
p<-p + annotate("text", x = xtext, y = ytext, label = test2)
p




# g gennitria
g <-ggplot()+
  geom_point(data=Rdata, aes(x2,y2), size = 2, color ="red")+
  xlab("I2[A]") +
  ylab("V2[V]") +
  ggtitle("1100 RPM")+
  geom_errorbar(data=Rdata,mapping=aes(x=x2,ymin = y2-SE_y2,ymax = y2+SE_y2), width=0.01) +
  geom_errorbarh(data=Rdata,mapping=aes(y=y2,xmin = x2-SE_x2,xmax = x2+SE_x2), height=0.1)
  g 


#geom_abline eytheia elaxistwn + text gia abline
g<-g+ geom_abline(intercept = mod2$coefficients[[1]], slope = mod2$coefficients[[2]], color="red")
g
xtext<- 0.8*(max(x2)-min(x2))+min(x2)
ytext<- 0.99*(max(y2)-min(y2))+min(y2)
cat(sprintf("y=%s x+ %s\n",  mod2$coefficients[[2]],  mod2$coefficients[[1]]),"\n",file="test.txt")
test2 <- readLines("test.txt")
g<-g + annotate("text", x = xtext, y = ytext, label = test2)
g




# selida 563
h <-ggplot()+
  geom_point(data=Rdata, aes(x2,y3), size = 2, color ="orange")+
  xlab("Ig[A]") +
  ylab("a") +
  ggtitle("1100 RPM")+
  geom_errorbar(data=Rdata,mapping=aes(x=x2,ymin = y3-SE_y3,ymax = y3+SE_y3), width=0.01) +
  geom_errorbarh(data=Rdata,mapping=aes(y=y3,xmin = x2-SE_x2,xmax = x2+SE_x2), height=0.01)
h  


#geom_abline eytheia elaxistwn + text gia abline
h<-h+ geom_abline(intercept = mod3$coefficients[[1]], slope = mod3$coefficients[[2]], color="blue")
h
xtext<- 0.05*(max(x2)-min(x2))+min(x2)
ytext<- 0.99*(max(y3)-min(y3))+min(y3)
cat(sprintf("y=%s x+ %s\n",  mod3$coefficients[[2]],  mod3$coefficients[[1]]),"\n",file="test.txt")
test2 <- readLines("test.txt")
h<-h + annotate("text", x = xtext, y = ytext, label = test2)
h


#timh toy x gia to maximum y.
y_max<-max(ymodel)
y_maxwhich<-which.max(ymodel)
x_max<-xmodel[y_maxwhich]
x_max

rm(p)
rm(g)
rm(h)


rm(list = ls())