##AM:1110201800159

#Gia na leitoyrgisei thelei etoima data morfhs
#x,y,x_SE,y_SE (standard errors) apo excel arxeio
#kalo tha itan na tou kanw beltistopoihsh me loop

##install.packages(c("rgl","plotly"))

library(dplyr)
library(dbplyr)
library(ggplot2)
library(ggrepel)
library(readxl)
library(tidyselect)
library(ggthemes)
library(ggpubr)
args(ggplot)

Rdata<-read_excel("D1.xlsx")
View(Rdata)

V<-select(Rdata, `V[V]`)
sV1<-302*sqrt(2)
sV2<-250*sqrt(2)
sV3<-200*sqrt(2)
sV4<-155*sqrt(2)
V1 <- filter(Rdata, V==sV1 )
V2 <- filter(Rdata, V==sV2 )
V3 <- filter(Rdata, V==sV3 )
V4 <- filter(Rdata, V==sV4 )
##V_all <- data.frame(c(V1,V2,V3,V4))
Á <- 0.715*1.2566*10^-6*130/0.15
I <- V1$`I1[A]`
I2 <- V2$`I1[A]`
I3 <- V3$`I1[A]`
I4 <- V4$`I1[A]`
dI <- V1$`dI1[A]`
dI2 <- V2$`dI1[A]`
dI3 <- V3$`dI1[A]`
dI4 <- V4$`dI1[A]`
dia_r <- 1/V1$`r1[mm]`
dia_r2 <- 1/V2$`r1[mm]`
dia_r3 <- 1/V3$`r1[mm]`
dia_r4 <- 1/V4$`r1[mm]`
d_dia_r <- 1/(V1$`dr1[mm]`)^2 * dia_r
d_dia_r2 <- 1/(V2$`dr1[mm]`)^2 * dia_r2
d_dia_r3 <- 1/(V3$`dr1[mm]`)^2 * dia_r3
d_dia_r4 <- 1/(V4$`dr1[mm]`)^2 * dia_r4
B <- A * I
B2 <- A * I2
B3 <- A * I3
B4 <- A * I4
dB <- B * dI/I
dB2 <- B2 * dI2/I2
dB3 <- B3 * dI3/I3
dB4 <- B4 * dI4/I4


#linear regression, tha xreiastei meta sto geom_abline
mod<-lm(B ~ dia_r)
summary(mod)
attributes(mod) #gia na dw ti exei san attributes
mod$coefficients  #slope kai intercept
rstderror1<-sqrt(deviance(mod)/df.residual(mod))
#linear regression, tha xreiastei meta sto geom_abline
mod2<-lm(B2 ~ dia_r2)
summary(mod2)
attributes(mod2) #gia na dw ti exei san attributes
mod2$coefficients  #slope kai intercept
rstderror2<-sqrt(deviance(mod2)/df.residual(mod2))
#linear regression, tha xreiastei meta sto geom_abline
mod3<-lm(B3 ~ dia_r3)
summary(mod3)
attributes(mod3) #gia na dw ti exei san attributes
mod3$coefficients  #slope kai intercept
rstderror3<-sqrt(deviance(mod3)/df.residual(mod3))
#linear regression, tha xreiastei meta sto geom_abline
mod4<-lm(B4 ~ dia_r4)
summary(mod4)
attributes(mod4) #gia na dw ti exei san attributes
mod4$coefficients  #slope kai intercept
rstderror4<-sqrt(deviance(mod4)/df.residual(mod4))




# plots
p <-ggplot()+
  geom_point(data=V1, aes(dia_r,B), size = 3, color ="blue")+
  geom_point(data=V2, aes(dia_r2,B2), size = 3, color ="red")+
  geom_point(data=V3, aes(dia_r3,B3), size = 3, color ="green")+
  geom_point(data=V4, aes(dia_r4,B4), size = 3, color ="purple")+
  xlab("1/r[mm]") +
  ylab("B[T]") +
  ggtitle("V1=302[V],V2=250[V],V3=200[V],V4=155[V]")+
  geom_errorbar(data=V1,mapping=aes(x=dia_r,ymin = B-dB,ymax = B+dB)) +
  geom_errorbarh(data=V1,mapping=aes(y=B,xmin = dia_r-d_dia_r,xmax = dia_r+d_dia_r))+
  geom_errorbar(data=V2,mapping=aes(x=dia_r2,ymin = B2-dB2,ymax = B2+dB2)) +
  geom_errorbarh(data=V2,mapping=aes(y=B2,xmin = dia_r2-d_dia_r2,xmax = dia_r2+d_dia_r2))+
  geom_errorbar(data=V3,mapping=aes(x=dia_r3,ymin = B3-dB3,ymax = B3+dB3)) +
  geom_errorbarh(data=V3,mapping=aes(y=B3,xmin = dia_r3-d_dia_r3,xmax = dia_r3+d_dia_r3))+
  geom_errorbar(data=V4,mapping=aes(x=dia_r4,ymin = B4-dB4,ymax = B4+dB4)) +
  geom_errorbarh(data=V4,mapping=aes(y=B4,xmin = dia_r4-d_dia_r4,xmax = dia_r4+d_dia_r4))


#1 geom_abline eytheia elaxistwn + text gia abline
p<-p+ geom_abline(intercept = mod$coefficients[[1]], slope = mod$coefficients[[2]])
xtext<- 2*(max(dia_r)-min(dia_r))+min(dia_r)
ytext<- 2*(max(B)-min(B))+min(B)
cat(sprintf("y1=%s x+ %s\n",  mod$coefficients[[2]],  mod$coefficients[[1]]),"\n",file="test.txt")
test1 <- readLines("test.txt")
p<-p + annotate("text", x = xtext, y = ytext, label = test1)

#2 geom_abline eytheia elaxistwn + text gia abline
p<-p+ geom_abline(intercept = mod2$coefficients[[1]], slope = mod2$coefficients[[2]])
xtext<- 1.7*(max(dia_r2)-min(dia_r2))+min(dia_r2)
ytext<- 1.6*(max(B2)-min(B2))+min(B2)
cat(sprintf("y2=%s x+ %s\n",  mod2$coefficients[[2]],  mod2$coefficients[[1]]),"\n",file="test2.txt")
test2 <- readLines("test2.txt")
p<-p + annotate("text", x = xtext, y = ytext, label = test2)

#3 geom_abline eytheia elaxistwn + text gia abline
p<-p+ geom_abline(intercept = mod3$coefficients[[1]], slope = mod3$coefficients[[2]])
xtext<- 1.1*(max(dia_r3)-min(dia_r3))+min(dia_r3)
ytext<- 1.2*(max(B3)-min(B3))+min(B3)
cat(sprintf("y3=%s x+ %s\n",  mod3$coefficients[[2]],  mod3$coefficients[[1]]),"\n",file="test3.txt")
test3 <- readLines("test3.txt")
p<-p + annotate("text", x = xtext, y = ytext, label = test3)

#4 geom_abline eytheia elaxistwn + text gia abline
p<-p+ geom_abline(intercept = mod4$coefficients[[1]], slope = mod4$coefficients[[2]])
xtext<- 0.7*(max(dia_r4)-min(dia_r4))+min(dia_r4)
ytext<- 0.80*(max(B4)-min(B4))+min(B4)
cat(sprintf("y4=%s x+ %s\n",  mod4$coefficients[[2]],  mod4$coefficients[[1]]),"\n",file="test4.txt")
test4 <- readLines("test4.txt")
p<-p + annotate("text", x = xtext, y = ytext, label = test4)
p

H<- data.frame(B1_Tesla= B,dB1_Tesla=dB,B2_Tesla= B2,dB2_Tesla=dB2,B3_Tesla= B3,dB3_Tesla=dB3,B4_Tesla= B4,dB4_Tesla=dB4)
#linear regression, tha xreiastei meta sto geom_abline
Klisi<- data.frame(k1=mod$coefficients[[2]], d_k1= rstderror1,k2=mod2$coefficients[[2]], d_k2= rstderror2,k3=mod3$coefficients[[2]], d_k3= rstderror3,k4=mod4$coefficients[[2]], d_k4= rstderror4 )
#klisi se monades me mm.
e_dia_m1<- 2*(sV1/((Klisi$k1)^2 * 10^-6))
e_dia_m2<- 2*(sV2/((Klisi$k2)^2 * 10^-6))
e_dia_m3<- 2*(sV3/((Klisi$k3)^2 * 10^-6))
e_dia_m4<- 2*(sV4/((Klisi$k4)^2 * 10^-6))
d_e_dia_m1<- e_dia_m1* sqrt((mean(V1$`dV1[V]`)/sV1)^2+4*(rstderror1/mod$coefficients[[2]])^2)
d_e_dia_m2<- e_dia_m2* sqrt((mean(V2$`dV1[V]`)/sV2)^2+4*(rstderror2/mod2$coefficients[[2]])^2)
d_e_dia_m3<- e_dia_m3* sqrt((mean(V3$`dV1[V]`)/sV3)^2+4*(rstderror3/mod3$coefficients[[2]])^2)
d_e_dia_m4<- e_dia_m4* sqrt((mean(V4$`dV1[V]`)/sV4)^2+4*(rstderror4/mod4$coefficients[[2]])^2)

m_e_dia_mol <- c(e_dia_m1,e_dia_m2,e_dia_m3,e_dia_m4)
dd_m_e_dia_mol <- c(d_e_dia_m1,d_e_dia_m2,d_e_dia_m3,d_e_dia_m4)

mesi_e_dia_mol <- mean(m_e_dia_mol)
std <- function(x) sd(x)/sqrt(length(x))
d_mesi_e_dia_mol <-std(m_e_dia_mol)

e_m_final<-data.frame(e_m=mesi_e_dia_mol,d_e_m=d_mesi_e_dia_mol)
em<-1.75*10^11
e_m<- data.frame(e_m_all=m_e_dia_mol, d_e_m_all= dd_m_e_dia_mol ,  e_m_final,diff_percentage=(mesi_e_dia_mol-em)/em*100, relative_percentage=(d_mesi_e_dia_mol)/mesi_e_dia_mol*100)

e_m<-format(e_m, scientific = TRUE)

View(H)
View(Klisi)
View(e_m)

