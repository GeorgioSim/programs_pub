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

Rdata<-read_excel("Rdata.xlsx")
View(Rdata)
x<-Rdata$`x`
y<-Rdata$`y`
SE_x<-Rdata$`x_SE`
SE_y<-Rdata$`y_SE`

#linear regression, tha xreiastei meta sto geom_abline
mod<-lm(y ~ x)
summary(mod)
attributes(mod) #gia na dw ti exei san attributes
mod$coefficients  #slope kai intercept


#to geom_abline allazei kathe fora, isws prepei na to allazw kai gw, selida 563
p <-ggplot()+
  geom_point(data=Rdata, aes(x,y), size = 2, color ="blue")+
  xlab("x") +
  ylab("y") +
  ggtitle("Trial")+
  geom_errorbar(data=Rdata,mapping=aes(x=x,ymin = y-SE_y,ymax = y+SE_y)) +
  geom_errorbarh(data=Rdata,mapping=aes(y=y,xmin = x-SE_x,xmax = x+SE_x))
p  

#geom_abline eytheia elaxistwn + text gia abline
p<-p+ geom_abline(intercept = mod$coefficients[[1]], slope = mod$coefficients[[2]])
p
xtext<- 0.8*(max(x)-min(x))+min(x)
ytext<- 0.99*(max(y)-min(y))+min(y)
cat(sprintf("y=%s x+ %s\n",  mod$coefficients[[2]],  mod$coefficients[[1]]),"\n",file="test.txt")
test2 <- readLines("test.txt")
p<-p + annotate("text", x = xtext, y = ytext, label = test2)
p

#geom_line: Plot the chart with new data by fitting it to a prediction from 10000 data points.
new.data <- data.frame(x = seq(min(x),max(x),len = 1000))
xmodel<-new.data$x
ymodel<-predict(model,newdata = new.data)
neo.data<- data.frame(xmodel,ymodel)

p<-p+ geom_point(data=neo.data, aes(xmodel, ymodel),size = 0,col = "yellow") +
  geom_line(data=neo.data,aes(xmodel, ymodel), col = "yellow")

p

rm(p)













#sites pou boithisan:
#https://www.tutorialspoint.com/r/r_nonlinear_least_square.htm

#diafora tries parakatw:

#An to panw den douleyei, enallaktikh:
pl<-plot(data_m,data_lambda)
pl+abline(mod, col=1, lwd=1)


#try nonlinear
# Take the assumed values and fit into the models:
#y=a/x+b
model <- nls(y ~ b1/x+b2,start = list(b1 = -100,b2 = 300))
#y=ax^2+b
model2 <- nls(y ~ b1*x^2+b2,start = list(b1 = -100,b2 = 300))

AUGdata<-augment(model)


#mono gia to aplo plot:
lines(xmodel,ymodel)

#geom_line kampylh
p<-p+  geom_point(data=AUGdata,aes(x, y)) +
  geom_line(data=AUGdata,aes(x, .fitted), col = "blue")

#geom_area, ftiagmeno gia to parakatw new.data
p<-p+geom_line(aes(xmodel,ymodel))+
  geom_area(mapping = aes(x = ifelse(x>=min(x) & x<= max(x) , x, 0)), fill = "green")
p