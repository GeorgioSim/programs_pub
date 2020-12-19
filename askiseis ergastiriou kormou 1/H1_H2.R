#Ergastirio kormou 1 askisi H1,H2
#Simopoulos Georgios, AM:1110201800159
library(data.table)
library(ggplot2)
library(dplyr)
library(tidyselect)
library(grid)

#H1



#Experiment 1

#function [x,sinx]
AC_P<-2
AC_PP<-2
AC_rms<-2
AC_ip<-c(AC_P,AC_PP/2,AC_rms*sqrt(2))
f_i<-c(1000,1000,1000)
t_i<-1/f_i
N<-7*t_i

i=1
eq = function(x){
  y<- AC_ip[i] * sin(2*pi*x/t_i[i])
  y
}
dev.new()
ggplot()+
  xlab("t[s]") +
  ylab("Vp[V]") +
  ggtitle("2V DC peak, 7 periods")+
  geom_function(data.frame(x = seq(0, 0.007, 0.007/1000)), mapping=aes(x),fun = eq, colour = i+1)

i=2
eq = function(x){
  y<- AC_ip[i] * sin(2*pi*x/t_i[i])
  y
}
dev.new()
ggplot()+
  xlab("t[s]") +
  ylab("Vp[V]") +
  ggtitle("2V DC peak-peak, 7 periods")+
  geom_function(data.frame(x = seq(0, 0.007, 0.007/1000)), mapping=aes(x),fun = eq, colour =  i+1)

i=3
eq = function(x){
  y<- AC_ip[i] * sin(2*pi*x/t_i[i])
  y
}
dev.new()
ggplot()+
  xlab("t[s]") +
  ylab("Vp[V]") +
  ggtitle("2V DC rms, 7 periods")+
  geom_function(data.frame(x = seq(0, 0.007, 0.007/1000)), mapping=aes(x),fun = eq, colour =i+1)


eq1 = function(x){
  y<- AC_ip[1] * sin(2*pi*x/t_i[1])
  y
}
eq2 = function(x){
  y<- AC_ip[2] * sin(2*pi*x/t_i[2])
  y
}
eq3 = function(x){
  y<- AC_ip[3] * sin(2*pi*x/t_i[3])
  y
}

#separately

dev.new()
ggplot()+
  xlab("t[s]") +
  ylab("Vp[V]") +
  ggtitle("2V DC all, 7 periods")+
  geom_function(data.frame(x = seq(0, 0.007, 0.007/1000)), mapping=aes(x),fun = eq1, colour =2)+
geom_function(data.frame(x = seq(0, 0.007, 0.007/1000)), mapping=aes(x),fun = eq2, colour =3)+
geom_function(data.frame(x = seq(0, 0.007, 0.007/1000)), mapping=aes(x),fun = eq3, colour =4)






#Experiment 2

#2 [SI]
V<-2
R1<-1000
V1<-V
I1<-V1/R1
V1
I1




#4 [SI]
V<-1.5
R1<-1000
R2<-3300
V1<-V*(R1/(R1+R2))
V2<-V*(R2/(R1+R2))
I1<-V1/R1
I2<-V2/R2
V1
V2
I1
I2





#5
Vp<-2
V<-Vp
R1<-1000
R2<-3300
Vrms<-Vp/sqrt(2)
V1rms<-Vrms*(R1/(R1+R2))
V2rms<-Vrms*(R2/(R1+R2))
V1<-V1rms*sqrt(2)
V2<-V2rms*sqrt(2)

f<-1000
t<-1/f
eq1 = function(x){
  y<- V1 * sin(2*pi*x/t)
  y
}
dev.new()
ggplot()+
  xlab("t[s]") +
  ylab("V1[V]") +
  ggtitle("2V AC, 7 periods")+
  geom_function(data.frame(x = seq(0, 0.007, 0.007/1000)), mapping=aes(x),fun = eq1, colour =2)

eq2 = function(x){
  y<- V2 * sin(2*pi*x/t)
  y
}
dev.new()
ggplot()+
  xlab("t[s]") +
  ylab("V2[V]") +
  ggtitle("2V AC, 7 periods")+
  geom_function(data.frame(x = seq(0, 0.007, 0.007/1000)), mapping=aes(x),fun = eq2, colour =3)


#separately
dev.new()
ggplot()+
  xlab("t[s]") +
  ylab("V1[V], V2[V]") +
  ggtitle("2V (peak) AC all, 7 periods")+
  geom_function(data.frame(x = seq(0, 0.007, 0.007/1000)), mapping=aes(x),fun = eq1, colour =2)+
  geom_function(data.frame(x = seq(0, 0.007, 0.007/1000)), mapping=aes(x),fun = eq2, colour =3)






#6
Vp<-2
V<-Vp
R1<-1000
R2<-3300
Vrms<-Vp/sqrt(2)

Vout_in_rms = function(x){
  y<- (R2*x)/(R1*x+R2*x+R1*R2)
  y
}
dev.new()
ggplot()+
  xlab("Rk[Ohm]") +
  ylab("Vout/Vin") +
  ggtitle("2V (peak) AC, max(Rk)=5*R2")+
  geom_function(data.frame(x = seq(0, 5*R2, 5*R2/1000)), mapping=aes(x),fun = Vout_in_rms, colour =3)
dev.new()
ggplot()+
  xlab("Rk[Ohm]") +
  ylab("Vout/Vin") +
  ggtitle("2V (peak) AC, max(Rk)=10*R2")+
  geom_function(data.frame(x = seq(0, 10*R2, 10*R2/1000)), mapping=aes(x),fun = Vout_in_rms, colour =4)
dev.new()
ggplot()+
  xlab("Rk[Ohm]") +
  ylab("Vout/Vin") +
  ggtitle("2V (peak) AC, max(Rk)=50*R2")+
  geom_function(data.frame(x = seq(0, 50*R2, 50*R2/1000)), mapping=aes(x),fun = Vout_in_rms, colour =5)






#7

Vcc<-5
Vcc
R1<-1000
R2<-10000
R3<-100
R4<-4700
R23<-R2*R3/(R2+R3)
V2<-(R23/(R1+R23))*Vcc
V3<-V2
V1<-Vcc-V3
V4<-0
I1<-V1/R1
I2<-V2/R2
I3<-V3/R3
I4<-V4/R4
dat<-data.frame(c("A","B","Γ","Δ","E","Z"),c(Vcc,V2,V3,V4,V4,V4))
setnames(dat, old = colnames(dat), new = c("Σημεία", "Δυναμικό (Volts)"))
dat2<-data.frame(c("R1","R2","R3","R4"),c(V1,V2,V3,V4),c(I1,I2,I3,I4))
setnames(dat2, old = colnames(dat2), new = c("", "Τάση V (Volts)","Ρεύμα I (A)"))
View(dat)
View(dat2)




#8

Vcc<- -5
Vcc
R1<-1000
R2<-10000
R3<-100
R4<-4700
R23<-R2*R3/(R2+R3)
V2<-(R23/(R1+R23))*Vcc
V3<-V2
V1<-Vcc-V3
V4<-0
I1<-V1/R1
I2<-V2/R2
I3<-V3/R3
I4<-V4/R4
dat2<-data.frame(c("R1","R2","R3","R4"),c(V1,V2,V3,V4),c(I1,I2,I3,I4))
setnames(dat2, old = colnames(dat2), new = c("", "Τάση V (Volts)","Ρεύμα I (A)"))
View(dat2)





#H2
f<-1000
t_i<-1/f
AC_p<-1
eq1 = function(x){
  y<- AC_p * sin(2*pi*x/t_i)
  y
}
#separately
n<-7
t_imax<-n*t_i

dev.new()
ggplot()+
  xlab("t[s]") +
  ylab("Vp[V]") +
  ggtitle("1V (peak) AC, 7 periods")+
  geom_function(data.frame(x = seq(0, t_imax, t_imax/1000)), mapping=aes(x),fun = eq1, colour =2)


#separately

eq2 = function(x){
  y<- sin(2*pi*x/t_i)
  z<-ifelse(y>0, 12,-12 )
  z
}

dev.new()
ggplot()+
  xlab("t[s]") +
  ylab("Vout[V]") +
  ggtitle("1V (peak) AC, 7 periods")+
geom_function(data.frame(x = seq(0, t_imax, t_imax/1000)), mapping=aes(x),fun = eq2, colour =3)

dev.new()
ggplot()+
  xlab("t[s]") +
  ylab("V[V]") +
  ggtitle("1V (peak) AC, 7 periods")+
  geom_function(data.frame(x = seq(0, t_imax, t_imax/700)), mapping=aes(x),fun = eq2, colour =2)+
  geom_function(data.frame(x = seq(0, t_imax, t_imax/1000)), mapping=aes(x),fun = eq1, colour =3)

#anastrofi polosi
eq2 = function(x){
  y<- sin(2*pi*x/t_i)
  z<-ifelse(y>0, -12,12 )
  z
}

dev.new()
ggplot()+
  xlab("t[s]") +
  ylab("Vout[V]") +
  ggtitle("1V (peak) AC, 7 periods")+
  geom_function(data.frame(x = seq(0, t_imax, t_imax/1000)), mapping=aes(x),fun = eq2, colour =3)

dev.new()
ggplot()+
  xlab("t[s]") +
  ylab("V[V]") +
  ggtitle("1V (peak) AC, 7 periods")+
  geom_function(data.frame(x = seq(0, t_imax, t_imax/700)), mapping=aes(x),fun = eq2, colour =2)+
  geom_function(data.frame(x = seq(0, t_imax, t_imax/1000)), mapping=aes(x),fun = eq1, colour =3)
