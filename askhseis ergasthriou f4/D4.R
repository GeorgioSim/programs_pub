##AM:1110201800159
##Askhsh D4 ergastirio fysikis 4

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

Rdata<-read_excel("D4.xlsx")
View(Rdata)
x<-Rdata$`f1[Hz]`
x2<-Rdata$`f2[Hz]`
y<-Rdata$`Vs1[V]`
y2<-Rdata$`Vs2[V]`
SE_x<-Rdata$`d_f1[Hz]`
SE_x2<-Rdata$`d_f2[Hz]`
SE_y<-Rdata$`d_Vs1[V]`
SE_y2<-Rdata$`d_Vs2[V]`
h<-Rdata$`h[Js]`
d_h<-Rdata$`d_h[Js]`

#linear regression, tha xreiastei meta sto geom_abline
mod<-lm(y ~ x)
summary(mod)
attributes(mod) #gia na dw ti exei san attributes
mod$coefficients  #slope kai intercept
rstderror1<-sqrt(deviance(mod)/df.residual(mod))

mod2<-lm(y2 ~ x2)
summary(mod2)
attributes(mod2) #gia na dw ti exei san attributes
mod2$coefficients  #slope kai intercept
rstderror2<-sqrt(deviance(mod2)/df.residual(mod2))


# selida 563
p <-ggplot()+
  geom_point(data=Rdata, aes(x,y), size = 2, color ="blue")+
  xlab("f1[Hz]") +
  ylab("Vs1[V]") +
  ggtitle("d=4 mm")+
  geom_errorbar(data=Rdata,mapping=aes(x=x,ymin = y-SE_y,ymax = y+SE_y), width=0.01) +
  geom_errorbarh(data=Rdata,mapping=aes(y=y,xmin = x-SE_x,xmax = x+SE_x))
p  


#geom_abline eytheia elaxistwn + text gia abline
p<-p+ geom_abline(intercept = mod$coefficients[[1]], slope = mod$coefficients[[2]], color="blue")
p
xtext<- 0.2*(max(x)-min(x))+min(x)
ytext<- 0.99*(max(y)-min(y))+min(y)
cat(sprintf("y=%s x+ %s\n",  mod$coefficients[[2]],  mod$coefficients[[1]]),"\n",file="test.txt")
test2 <- readLines("test.txt")
p<-p + annotate("text", x = xtext, y = ytext, label = test2)
p




# g graph d=8mm
g <-ggplot()+
  geom_point(data=Rdata, aes(x2,y2), size = 2, color ="red")+
  xlab("f2[Hz]") +
  ylab("Vs2[V]") +
  ggtitle("d=8 mm")+
  geom_errorbar(data=Rdata,mapping=aes(x=x2,ymin = y2-SE_y2,ymax = y2+SE_y2), width=0.01) +
  geom_errorbarh(data=Rdata,mapping=aes(y=y2,xmin = x2-SE_x2,xmax = x2+SE_x2), height=0.1)
g 


#geom_abline eytheia elaxistwn + text gia abline
g<-g+ geom_abline(intercept = mod2$coefficients[[1]], slope = mod2$coefficients[[2]], color="red")
g
xtext<- 0.2*(max(x2)-min(x2))+min(x2)
ytext<- 0.99*(max(y2)-min(y2))+min(y2)
cat(sprintf("y=%s x+ %s\n",  mod2$coefficients[[2]],  mod2$coefficients[[1]]),"\n",file="test.txt")
test2 <- readLines("test.txt")
g<-g + annotate("text", x = xtext, y = ytext, label = test2)
g


hallo<-ggplot()+
  geom_point(data=Rdata, aes(x2,y2), size = 2, color ="red")+
  geom_point(data=Rdata, aes(x,y), size = 2, color ="blue")+
  xlab("f[Hz]") +
  ylab("Vs[V]") +
  ggtitle("same diagram")

#sd=standard deviation
hmean<-mean(c(h[1], h[2]))
std <- function(x) sd(x)/sqrt(length(x))
hstd<-std(c(h[1], h[2]))
hdata<-data.frame(hmean[1],hstd[1],(hstd+c(d_h[1],d_h[2]))/hmean[1]*100)
View(hdata)


#timh toy x gia to maximum y.
f1<--mod$coefficients[[1]]/mod$coefficients[[2]]
f2<--mod2$coefficients[[1]]/mod2$coefficients[[2]]
f1
f2

fmean<-mean(c(f1,f2))
std <- function(x) sd(x)/sqrt(length(x))
fstd<-std(c(f1,f2))
fdata<-data.frame(fmean,fstd,fstd/fmean*100)
View(fdata)
