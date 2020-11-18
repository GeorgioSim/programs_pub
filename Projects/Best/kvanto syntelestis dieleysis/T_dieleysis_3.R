##install.packages(c("rgl","plotly"))

library(dplyr)
library(dbplyr)
library(tidyverse)
library(ggplot2)
library(ggrepel)
library(scatterplot3d)

T_dieleysis_2 <- read.csv2("C:/Users/Simgeorge/Desktop/CODEBLOCKS_SAVES/PROGRAMS gia panepistimio/extra dika mou/prosomoiwseis/kvanto/T_dieleysis_2.csv", header=FALSE)
View(T_dieleysis_2)


##V1=m  V2=L  V3=E  V4=V  V5=T
V1<-select(T_dieleysis_2, V1)
V2<-select(T_dieleysis_2, V2)
V3<-select(T_dieleysis_2, V3)
V4<-select(T_dieleysis_2, V4)
T<-select(T_dieleysis_2, V5)
##boithitikes metablites (statheres). Tha tis allazw kathe fora analoga me ta data, wste na mhn exw error
sm<-511000
sL<-0.000298
sE<-5.5
sV<-8.6

##boithitikes metablites (xrhsh statherwn gia apomonosi)

##gia 4D
rm(m)
rm(L)
rm(E)
rm(V)
m <- filter(T_dieleysis_2, V1==sm )
L <- filter(T_dieleysis_2, V2==sL )
E <- filter(T_dieleysis_2, V3==sE )
V <- filter(T_dieleysis_2, V4==sV )


##gia 3D
mL <- filter(T_dieleysis_2, V1==sm & V2==sL)
mE <- filter(T_dieleysis_2, V1==sm & V3==sE)
mV <- filter(T_dieleysis_2, V1==sm & V4==sV)
LE <- filter(T_dieleysis_2, V2==sL & V3==sE)
LV <- filter(T_dieleysis_2, V2==sL & V4==sV)
EV <- filter(T_dieleysis_2, V3==sE & V4==sV)

##gia 2D
mLE <- filter(T_dieleysis_2, V1==sm & V2==sL & V3==sE)
mEV <- filter(T_dieleysis_2, V1==sm & V3==sE & V4==sV)
LEV <- filter(T_dieleysis_2, V2==sL & V3==sE & V4==sV)
mLV <- filter(T_dieleysis_2, V1==sm & V2==sL & V4==sV)

mLEV <- filter(T_dieleysis_2, V1==sm & V2==sL & V3==sE & V4==sV)






##2D plots:
##px: plot to L mhkos me to T. An exw wxyz tote to format data_wxy shmainei oti thelw data_z
data_mEV=data.frame(mEV)
data_T=data_mEV$V5
data_L=data_mEV$V2
plot(data_L,data_T,type="l", col="green", lwd=5, xlab="L", ylab="T", main="1")
dev.new()
rm(data_T)
rm(data_E)
rm(data_V)
rm(data_L)
rm(data_m)

##px: plot to m maza me to T
data_LEV=data.frame(LEV)
data_T=data_LEV$V5
data_m=data_LEV$V1
plot(data_m,data_T,type="l", col="green", lwd=5, xlab="m", ylab="T", main="2")
dev.new()
rm(data_T)
rm(data_E)
rm(data_V)
rm(data_L)
rm(data_m)

##px: plot thn E me to T
data_mLV=data.frame(mLV)
data_T=data_mLV$V5
data_E=data_mLV$V3
plot(data_E,data_T,type="l", col="green", lwd=5, xlab="E", ylab="T", main="3")
dev.new()
##px: plot thn E/V me to T
data_V=data_mLV$V4
data_E_dia_V=data_E/data_V
plot(data_E_dia_V,data_T,type="l", col="green", lwd=5, xlab="E/V" , ylab="T", main="4")
dev.new()
rm(data_T)
rm(data_E)
rm(data_V)
rm(data_L)
rm(data_m)

##px: plot 3D E,V,T
data_mL=data.frame(mL)
data_T=data_mL$V5
data_E=data_mL$V3
data_V=data_mL$V4
data_new_mL=data.frame(data_E,data_V, data_T)
library(rgl)
x=data_E
y=data_V
z=data_T
plot3d( 
  x=x, y=y, z=z, 
  col = "green", 
  type = 's', 
  radius = .1,
  xlab="E", ylab="L", zlab="T")
dev.new()
rm(data_T)
rm(data_E)
rm(data_V)
rm(data_L)
rm(data_m)
rm(data_E_dia_V)

##px: plot 3D E/V,L,T
data_m=data.frame(m)
data_T=data_m$V5
data_E=data_m$V3
data_V=data_m$V4
data_L=data_m$V2
data_E_dia_V=data_E/data_V
data_new_m=data.frame(data_E_dia_V,data_L, data_T)

library(rgl)
x=data_E_dia_V
y=data_L
z=data_T
plot3d( 
  x=x, y=y, z=z, 
  col = "green", 
  type = 's', 
  radius = .05,
  xlab="E/V", ylab="L", zlab="T")


library(akima)
x=data_E_dia_V
y=data_L
z=data_T
im <- with(data_new_m,interp(x,y,z))
with(im,image(x,y,z))
dev.new()


##h alliws (dn douleyei)
##library(plotly)
##plot_ly(x=data_E,y=data_V,z=data_T, type="surface")
#h alliws (dn douleyei)
##plot3d(x, y, z, col = rainbow(1000))
rm(data_T)
rm(data_E)
rm(data_V)
rm(data_L)
rm(data_m)
