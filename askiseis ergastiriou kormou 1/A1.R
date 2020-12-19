#AM:1110201800159
#Simopoulos Georgios
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

#Gia to megisto

lmax<-xmodel[which.max(ymodel)]
Teff<-2.8978*10^-3/(lmax*10^-9)
Teff

















#theoretical T=5780K (F sto SI)
Ttheory<-5780
c1<-2*3.14159*6.626*10^-34 *9*10^16*10^45
c2<-6.626*10^-34 *3*10^8/(1.380649 * 10^-23*Ttheory*10^-9)
c1a<-c1*(6.95508*10^8/(1.496*10^11))^2
c1a
c2
y<-c1a/x^5/(exp(c2/x)-1)
y<-y*10^-7


g <-ggplot()+
  geom_point(data=Rdata, aes(x,y), size = 2, color ="blue")+
  xlab("ë[nm]") +
  ylab("F[W/m^2]") +
  ggtitle("F=F(ë)")
g 


#ta metaferw sto excel gia na pane logger pro
write_xlsx(data.frame(x,y),"new2.xlsx")













#AKSHSH 2
swstes<- 0.2157/9*1000
swstes
dswstes<- swstes/0.2157*0.0007
dswstes
