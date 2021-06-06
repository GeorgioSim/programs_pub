#Ergastirio kormou 2 askisi H1,H2
#Simopoulos Georgios, AM:1110201800159
library(data.table)
library(ggplot2)
library(dplyr)
library(tidyselect)
library(grid)

#Ç1 new

#1st
R1<-1000
Vd<-0.7
Vin<-5
VR<-Vin-Vd
I<-VR/R1
f<-1000
t_i<-1/f
n<-7
t_imax<-n*t_i

eq1 = function(x){
  y<- Vin * sin(2*pi*x/t_i)
  y
}


eq2 = function(x){
  y<- Vin*sin(2*pi*x/t_i)
  if(abs(Vin)>abs(Vd)){
    z<-ifelse(y>Vd, Vd, y )
    z
  }
  else{
    z<-ifelse(y>Vd, 0, y )
    z
  }
}


eq3 = function(x){
  y<- VR*sin(2*pi*x/t_i)
  if(abs(Vin)>abs(Vd)){
    z<-ifelse(y>0, y, 0 )
    z
  }
  else{
    z<-0
    z
  }
}

dev.new()
ggplot()+
  xlab("t[s]") +
  ylab("V[V]") +
  ggtitle("Vin=5V (red) AC, Vdiode (green), VR(blue), 7 periods")+
  geom_function(data.frame(x = seq(0, t_imax, t_imax/1000)), mapping=aes(x),fun = eq1, size=1, colour =2)+
  geom_function(data.frame(x = seq(0, t_imax, t_imax/1000)), mapping=aes(x),fun = eq2, colour =3)+
  geom_function(data.frame(x = seq(0, t_imax, t_imax/1000)), mapping=aes(x),fun = eq3, size=1, colour =4)






#2nd

R1<-1000
Vd1<-0.7
Vd2<-0.7
Vd<-0.7 ##isa ola ta lampakia
Vin<-5
VR<-Vin-Vd
Vr<- -VR
f<-1000
t_i<-1/f
n<-7
t_imax<-n*t_i

eq1 = function(x){
  y<- Vin * sin(2*pi*x/t_i)
  y
}


eq2 = function(x){
  y<- Vin*sin(2*pi*x/t_i)
  if(abs(Vin)>abs(Vd)){
    z<-ifelse(y>Vd, 0.7, -0.7 )
    z
  }
  else{
    z<-0
    z
  }
}


dev.new()
ggplot()+
  xlab("t[s]") +
  ylab("V[V]") +
  ggtitle("Vin=5V (red) AC, Vdiodes=Vout (green), 7 periods")+
  geom_function(data.frame(x = seq(0, t_imax, t_imax/1000)), mapping=aes(x),fun = eq1, colour =2)+
  geom_function(data.frame(x = seq(0, t_imax, t_imax/1000)), mapping=aes(x),fun = eq2, colour =3)




#3rd
R1<-1000
Vd<-0.7
Vrms<-15
Vin<-Vrms*sqrt(2)
VR<-Vin-Vd
f<-50
t_i<-1/f
n<-7
t_imax<-n*t_i

eq1 = function(x){
  y<- Vin * sin(2*pi*x/t_i)
  y
}


eq2 = function(x){
  y<- VR*sin(2*pi*x/t_i)
  if(abs(Vin)>abs(Vd)){
    z<-ifelse(y>Vd, y, 0 )
    z
  }
  else{
    z<-0
    z
  }
}

dev.new()
ggplot()+
  xlab("t[s]") +
  ylab("V[V]") +
  ggtitle("Vin=15*sqrt(2)V (red) AC, VR=Vout=Vin-0.7 (green), 7 periods")+
  geom_function(data.frame(x = seq(0, t_imax, t_imax/1000)), mapping=aes(x),fun = eq1, colour =2)+
  geom_function(data.frame(x = seq(0, t_imax, t_imax/1000)), mapping=aes(x),fun = eq2, colour =3)


#3rd_part2
R1<-1000
Vd<-0.7
Vrms<-15
Vin<-Vrms*sqrt(2)
VR<-Vin-Vd
f<-50
t_i<-1/f
n<-3
t_imax<-n*t_i

eq1 = function(x){
  y<- Vin * sin(2*pi*x/t_i)
  y
}


eq2 = function(x){
  y<- VR*sin(2*pi*x/t_i)
  if(abs(Vin)>abs(Vd)){
    z<-ifelse(y>Vd, y, -y )
    z
  }
  else{
    z<-0
    z
  }
}

dev.new()
ggplot()+
  xlab("t[s]") +
  ylab("V[V]") +
  ggtitle("Vin=15*sqrt(2)V (red) AC, VR=Vout=Vin-0.7 (green), 3 periods")+
  geom_function(data.frame(x = seq(0, t_imax, t_imax/1000)), mapping=aes(x),fun = eq1, colour =2)+
  geom_function(data.frame(x = seq(0, t_imax, t_imax/1000)), mapping=aes(x),fun = eq2, colour =3)



#3rd_part3
R1<-1000
Vd<-0.7
Vrms<-15
Vin<-Vrms*sqrt(2)
VR<-Vin-2*Vd
f<-50
t_i<-1/f
n<-3
t_imax<-n*t_i

eq1 = function(x){
  y<- Vin * sin(2*pi*x/t_i)
  y
}


eq2 = function(x){
  y<- VR*sin(2*pi*x/t_i)
  if(abs(Vin)>abs(Vd)){
    z<-ifelse(y>Vd, y, -y )
    z
  }
  else{
    z<-0
    z
  }
}

dev.new()
ggplot()+
  xlab("t[s]") +
  ylab("V[V]") +
  ggtitle("Vin=15*sqrt(2)V (red) AC, VR=Vout=Vin-1.4 (green), 3 periods")+
  geom_function(data.frame(x = seq(0, t_imax, t_imax/1000)), mapping=aes(x),fun = eq1, colour =2)+
  geom_function(data.frame(x = seq(0, t_imax, t_imax/1000)), mapping=aes(x),fun = eq2, colour =3)






#H2

#1st
Vbe<-0.7
R1<-10000
R2<-1000
Rk<-2000
Vin<-5
Vcc<-15
beta<-100

Ib<-(Vin-Vbe)/(R1+(beta+1)*Rk)
Ic<-beta*Ib
Ie<-(beta+1)*Ib
VR1<-Ib*R1
VR2<-Ic*R2
VRk<-Ie*Rk


new<-c("B","C","E")
data1<-data.table(I=c(Ib,Ic,Ie),V=c(VR1,VR2,VRk))
data1<-data.matrix(data1)
rownames(data1) <- new
data1



#2nd

Vbe<-0.7
Vce<-0.2
VLED<-2
R1<-1000
R2<-1000
Vin<-5
Vcc<-15
beta<-100
f=100
Icmax<-(Vcc-Vce-VLED)/R2
#koros, ara Ic=beta*Ib
Ib<-Ic/beta
Vindown<-0.7
Vinup<-Ib*R1+Vbe
VR1<-Ib*R1
VR2<-Ic*R2

t_i<-1/f
n<-7
t_imax<-n*t_i

eq1 = function(x){
  y<- Vin * sin(2*pi*x/t_i)
  y
}


eq2 = function(x){
  y<- Vin*sin(2*pi*x/t_i)
  if(abs(Vin)>abs(Vindown)){
    z<-ifelse(y>Vindown, Vindown, y )
    z
  }
  else{
    z<-ifelse(y>Vindown, 0, y )
    z
  }
}


eq3 = function(x){
  y<- Vin*sin(2*pi*x/t_i)
  if(abs(Vin)>abs(Vindown)){
    z<-ifelse(y>0, Vce, Vcc )
    z
  }
  else{
    z<-0
    z
  }
}

dev.new()
ggplot()+
  xlab("t[s]") +
  ylab("V[V]") +
  ggtitle("Vin=5V (red) AC, Vb (green), Vc(blue), 7 periods")+
  geom_function(data.frame(x = seq(0, t_imax, t_imax/1000)), mapping=aes(x),fun = eq1, size=1, colour =2)+
  geom_function(data.frame(x = seq(0, t_imax, t_imax/1000)), mapping=aes(x),fun = eq2, colour =3)+
  geom_function(data.frame(x = seq(0, t_imax, t_imax/1000)), mapping=aes(x),fun = eq3, size=1, colour =4)



#3rd

Vce<-0.2
R1<-47000
R2<-10000
Rc<-2700
Re<-1000
C1<-220*10^-9
C2<-470*10^-9
Vin<-2
Vcc<-12
beta<-100
f=1000


Icmax<-(Vcc-Vce)/(Rc+Re)
Vcmax<-Icmax*Re
Vcmax
re<-16/((beta+1)*Icmax)
Aur<-Rc/re
Vinmax<-Vcmax/Aur
Vinmax



t_i<-1/f
n<-7
t_imax<-n*t_i


eq1 = function(x){
  y<- Vin * sin(2*pi*x/t_i)
  y
}


eq2 = function(x){
  y<- Vout*sin(2*pi*x/t_i)
  y
}

dev.new()
ggplot()+
  xlab("t[s]") +
  ylab("V[V]") +
  ggtitle("Vin=2V (red) AC, Vout (green), 7 periods")+
  geom_function(data.frame(x = seq(0, t_imax, t_imax/1000)), mapping=aes(x),fun = eq1, size=1, colour =2)+
  geom_function(data.frame(x = seq(0, t_imax, t_imax/1000)), mapping=aes(x),fun = eq2, colour =3)
