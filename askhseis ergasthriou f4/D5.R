##AM: 1110201800159
##Askhsh D5 ergastirio f4

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

Rdata<-read_excel("D5_data.xlsx")
View(Rdata)
x<-Rdata$`I2[A]`
y<-Rdata$`V2[V]`
SE_x<-Rdata$s_oliko_I_V
SE_y<-Rdata$s_oliko_I_V
x2<-Rdata$`I2[A]`
y2<-Rdata$`I1[A]`
SE_x2<-Rdata$s_oliko_I_V
SE_y2<-Rdata$s_oliko_I_V
x3<-Rdata$`I2[A]`
y3<-Rdata$`cos(ö)_epi_sqrt(2)`
SE_x3<-Rdata$s_oliko_I_V
SE_y3<-Rdata$`s_cos(ö)`
x4<-Rdata$`I2[A]`
y4<-Rdata$a
SE_x4<-Rdata$s_oliko_I_V
SE_y4<-Rdata$s_a
  


#linear regression, tha xreiastei meta sto geom_abline
mod<-lm(y ~ x)
summary(mod)
attributes(mod) #gia na dw ti exei san attributes
mod$coefficients  #slope kai intercept
rstderror<-sqrt(deviance(mod)/df.residual(mod))

mod2<-lm(y2 ~ x2)
summary(mod2)
attributes(mod2) #gia na dw ti exei san attributes
mod2$coefficients  #slope kai intercept
rstderror2<-sqrt(deviance(mod2)/df.residual(mod2))

#try nonlinear
# Take the assumed values and fit into the models:
#y=a/x+b
model1 <- nls(y ~ b1/x+b2,start = list(b1 = -100,b2 = 300))




# plots 
p <-ggplot()+
  geom_point(data=Rdata, aes(x2,y2), size = 2, color ="blue")+
  xlab("I2[A]") +
  ylab("I1[A]") +
  ggtitle("I1=f(I2)")+
  geom_errorbar(data=Rdata,mapping=aes(x=x2,ymin = y2-SE_y2,ymax = y2+SE_y2)) +
  geom_errorbarh(data=Rdata,mapping=aes(y=y2,xmin = x2-SE_x2,xmax = x2+SE_x2))
#2 geom_abline eytheia elaxistwn + text gia abline
p<-p+ geom_abline(intercept = mod2$coefficients[[1]], slope = mod2$coefficients[[2]])
xtext<- 0.1*(max(x2)-min(x2))+min(x2)
ytext<- 1.6*(max(y2)-min(y2))+min(y2)
cat(sprintf("y2=%s x+ (%s)\n",  mod2$coefficients[[2]],  mod2$coefficients[[1]]),"\n",file="test2.txt")
test2 <- readLines("test2.txt")
p<-p + annotate("text", x = xtext, y = ytext, label = test2)
p




# plots V2=f(I2)
g <-ggplot()+
  geom_point(data=Rdata, aes(x,y), size = 2, color ="red")+
  xlab("I2[A]") +
  ylab("V2[V]") +
  ggtitle("V2=f(I2)")+
  geom_errorbar(data=Rdata,mapping=aes(x=x,ymin = y-SE_y,ymax = y+SE_y)) +
  geom_errorbarh(data=Rdata,mapping=aes(y=y,xmin = x-SE_x,xmax = x+SE_x))
g  

#2 geom_abline eytheia elaxistwn + text gia abline
g<-g+ geom_abline(intercept = mod$coefficients[[1]], slope = mod$coefficients[[2]])
xtext<- 0.1*(max(x)-min(x))+min(x)
ytext<- 1.6*(max(y)-min(y))+min(y)
cat(sprintf("y2=%s x+ (%s)\n",  mod$coefficients[[2]],  mod$coefficients[[1]]),"\n",file="test2.txt")
test2 <- readLines("test2.txt")
g<-g + annotate("text", x = xtext, y = ytext, label = test2)
g





# plots cos_phi=f(I2)
h <-ggplot()+
  geom_point(data=Rdata, aes(x3,y3), size = 2, color ="red")+
  xlab("I2[A]") +
  ylab("cos_phi") +
  ggtitle("cos_phi=f(I2)")+
  geom_errorbar(data=Rdata,mapping=aes(x=x3,ymin = y3-SE_y3,ymax = y3+SE_y3)) +
  geom_errorbarh(data=Rdata,mapping=aes(y=y3,xmin = x3-SE_x3,xmax = x3+SE_x3))
h  

y<-y3
x<-x3
#y=ax^5+bx^4+cx^3+dx^2+ex+f
model3 <- nls(y ~ b1*x^5+b2*x^4+b3*x^3+b4*x^2+b5*x+b6,start = list(b6=0.1,b1 = 0.1,b2 = 0.1,b3=0.1,b4=0.1,b5=0.1))

#geom_line: Plot the chart with new data by fitting it to a prediction from 10000 data points.
new.data <- data.frame(x = seq(min(x3),max(x3),len = 1000))
xmodel<-new.data$x
ymodel<-predict(model3,newdata = new.data)
neo.data<- data.frame(xmodel,ymodel)

h<-h+ geom_point(data=neo.data, aes(xmodel, ymodel),size = 0,col = "orange") +
  geom_line(data=neo.data,aes(xmodel, ymodel), col = "orange")
h


# plots a=f(I2)
k <-ggplot()+
  geom_point(data=Rdata, aes(x4,y4), size = 2, color ="red")+
  xlab("I2[A]") +
  ylab("a") +
  ggtitle("a=f(I2)")+
  geom_errorbar(data=Rdata,mapping=aes(x=x4,ymin = y4-SE_y4,ymax = y4+SE_y4)) +
  geom_errorbarh(data=Rdata,mapping=aes(y=y4,xmin = x4-SE_x4,xmax = x4+SE_x4))
k  

x<-x4
y<-y4
#y=ax^2+b
model4 <- nls(y ~ b1*x^2+b2*x+b3,start = list(b1 = -0.1,b2 = 0.3,b3=1))


#geom_line: Plot the chart with new data by fitting it to a prediction from 10000 data points.
new.data <- data.frame(x = seq(min(x4),max(x4),len = 1000))
xmodel<-new.data$x
ymodel<-predict(model4,newdata = new.data)
neo.data<- data.frame(xmodel,ymodel)

k<-k+ geom_point(data=neo.data, aes(xmodel, ymodel),size = 0,col = "orange") +
  geom_line(data=neo.data,aes(xmodel, ymodel), col = "orange")
k

#timh toy x gia to maximum y.
y_max<-max(ymodel)
y_maxwhich<-which.max(ymodel)
x_max<-xmodel[y_maxwhich]
x_max
