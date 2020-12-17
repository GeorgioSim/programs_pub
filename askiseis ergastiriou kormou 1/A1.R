
#Askisi 1

library(readxl)
library("writexl")
library(ggplot2)
library(dplyr)
library(broom)
library(tidyselect)
library(ggthemes)
library(ggrepel)
library(ggpubr)
args(ggplot)

Rdata<-read_excel("new.xlsx")
View(Rdata)

x<-Rdata$lambda
y<-Rdata$F

#try nonlinear
# Take the assumed values and fit into the models:
#y
model<- nls(y ~ (b1/x^5)/(exp(b2/x)-1), start=list(b1=10^18,b2=0.1))


#to geom_abline allazei kathe fora, isws prepei na to allazw kai gw, selida 563
p <-ggplot()+
  geom_point(data=Rdata, aes(x,y), size = 2, color ="blue")+
  xlab("ë[nm]") +
  ylab("F[W*10^-3/(m^2*A)]") +
  ggtitle("F=F(ë)")
p  

#geom_line: Plot the chart with new data by fitting it to a prediction from 10000 data points.
new.data <- data.frame(x = seq(min(x),max(x),len = 1000))
xmodel<-new.data$x
ymodel<-predict(model,newdata = new.data)
neo.data<- data.frame(xmodel,ymodel)

p<-p+ geom_point(data=neo.data, aes(xmodel, ymodel),size = 0,col = "yellow") +
  geom_line(data=neo.data,aes(xmodel, ymodel), col = "red")

p


func<-function (x){
  (1.162*10^18/x^5)/(exp(2668/x) - 1)
}
integ<-integrate(func, min(xmodel),max(xmodel))
f<-integ[["value"]]/100
f





rm(p)


rm(list = ls())


