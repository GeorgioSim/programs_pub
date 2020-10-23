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

Rdata<-read_excel("D8.xlsx")
View(Rdata)
x<-Rdata$`x1[cm]`
y<-Rdata$`B1[mT]`
SE_x<-Rdata$`d_x1[cm]`
SE_y<-Rdata$`d_B1[mT]`
x2<-Rdata$`x2[cm]`
y2<-Rdata$`B2[mT]`
SE_x2<-Rdata$`d_x2[cm]`
SE_y2<-Rdata$`d_B2[mT]`
d1<-Rdata$`d1[cm]`
d1<-d1[1]
d2<-Rdata$`d2[cm]`
d2<-d2[1]
L<-19
b<-Rdata$m0_real *Rdata$N1 * Rdata$`I1[A]` / (2* Rdata$`L[cm]` )
b<-b[1]
  
#function [x,B]
eq = function(y){
  k<-b*10^5*((L/2+y-median(x))/sqrt((L/2+y-median(x))^2+d2^2)+(L/2-y+median(x))/sqrt((L/2-y+median(x))^2+d2^2))
  k
}

eq2 = function(y) y^2

#linear regression, tha xreiastei meta sto geom_abline
mod<-lm(y ~ x)
summary(mod)
attributes(mod) #gia na dw ti exei san attributes
mod$coefficients  #slope kai intercept

#try nonlinear
# Take the assumed values and fit into the models:
#y=a/x+b
model1 <- nls(y ~ b1/x+b2,start = list(b1 = -100,b2 = 300))
#y=ax^2+b
model2 <- nls(y ~ b1*x^2+b2,start = list(b1 = -100,b2 = 300))
#y=a*(x^2+b^2)^(-3/2))
model3 <- nls(y ~ b1*d2^2/((x-median(x))^2+d2^2)^(3/2),start = list(b1 =20))
#y=a*(x^2+b^2)^(-3/2))  
model4 <- nls(y ~ b1*d1^2/((x-median(x))^2+d1^2)^(3/2),start = list(b1 =20))
#y=a*(costheta1+costheta2)
model5<- nls(y ~  b1*((L/2+x-median(x))/sqrt((L/2+x-median(x))^2+d1^2)+(L/2-x+median(x))/sqrt((L/2-x+median(x))^2+d1^2)) , start = list(b1=10))



# plots 33mm
g <-ggplot()+
  geom_point(data=Rdata, aes(x,y), size = 2, color ="red")+
  xlab("x[cm]") +
  ylab("B[mT]") +
  ggtitle("d=33 mm")+
  geom_errorbar(data=Rdata,mapping=aes(x=x,ymin = y-SE_y,ymax = y+SE_y)) +
  geom_errorbarh(data=Rdata,mapping=aes(y=y,xmin = x-SE_x,xmax = x+SE_x))
g  


#geom_line: Plot the chart with new data by fitting it to a prediction from 10000 data points.
new.data <- data.frame(x = seq(min(x),max(x),len = 1000))
xmodel<-new.data$x
ymodel<-predict(model5,newdata = new.data)
neo.data<- data.frame(xmodel,ymodel)

g<-g+ geom_point(data=neo.data, aes(xmodel, ymodel),size = 0,col = "orange") +
  geom_line(data=neo.data,aes(xmodel, ymodel), col = "orange")

g
g<-g+geom_function(data.frame(x = seq(min(x),max(x),1000)), mapping=aes(x),fun = eq, colour = "red")
g


# plots 41mm
p <-ggplot()+
  geom_point(data=Rdata, aes(x2,y2), size = 2, color ="blue")+
  xlab("x[cm]") +
  ylab("B[mT]") +
  ggtitle("d=41mm")+
  geom_errorbar(data=Rdata,mapping=aes(x=x2,ymin = y2-SE_y2,ymax = y2+SE_y2)) +
  geom_errorbarh(data=Rdata,mapping=aes(y=y2,xmin = x2-SE_x2,xmax = x2+SE_x2))
p  

y<-y2
x<-x2
#y=a*(costheta1+costheta2)
# previous try : model6<- nls(y ~  b1*((x-median(x))/sqrt((x-median(x))^2+d2^2)+(L-x+median(x))/sqrt((L-x+median(x))^2+d2^2)) , start = list(b1=10))
model6<- nls(y ~  b1*((L/2+x-median(x))/sqrt((L/2+x-median(x))^2+d2^2)+(L/2-x+median(x))/sqrt((L/2-x+median(x))^2+d2^2)) , start = list(b1=10))

#geom_line: Plot the chart with new data by fitting it to a prediction from 10000 data points.
new.data <- data.frame(x = seq(min(x2),max(x2),len = 1000))
xmodel<-new.data$x
ymodel<-predict(model6,newdata = new.data)
neo.data<- data.frame(xmodel,ymodel)

p<-p+ geom_point(data=neo.data, aes(xmodel, ymodel),size = 0,col = "orange") +
  geom_line(data=neo.data,aes(xmodel, ymodel), col = "orange")
p

#Function eq draw.
p<-p+geom_function(data.frame(x = seq(min(x2),max(x2),1000)), mapping=aes(x),fun = eq, colour = "red")
p


#timh toy x gia to maximum y.
y_max<-max(ymodel)
y_maxwhich<-which.max(ymodel)
x_max<-xmodel[y_maxwhich]
x_max



rm(p)


rm(list = ls())