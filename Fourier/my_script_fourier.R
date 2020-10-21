rm(list = ls())
#Apo 0 ews L
L=2*pi
N=1024
dx=L/(N-1)
x=seq(0,L,dx)
#Dialegw synartiseis apo tis parakatw gia copy sto console
#1) f synartisi =1 endiamesa, =0 e3w
f<-function(N){
  z<- vector(length = N)
  for(i in 0:N){
    z[i]<-ifelse(i>N/4 & i<3*N/4, 1,0 )
  }
  z
}


#Mexri edw dialega synartiseis
#Twra ypologismoi

f_x<-data.frame(f(N))
f__x<- f_x$f[0:N]  #ayto thelw
#To parapanw mporousa na to kanw kai me to function pull()
A0<- 2/L*sum( f__x)*dx
fFS=A0/2



g_x<-function(n){
for(k in 1:N/n){
  Ak<- 2/L* sum(f__x*cos(pi*k*x/L))*dx
  Bk<- 2/L* sum(f__x*sin(pi*k*x/L))*dx
  fFS<-fFS+ Ak*cos(pi*k*x/L) + Bk*sin(pi*k*x/L)
  }   
  fFS
}
plot(x,g_x(0.01),type="l", col="green", lwd=5, xlab="x", ylab="f(x)", main="1")
dev.new()
plot(x,g_x(2),type="l", col="green", lwd=5, xlab="x", ylab="f(x)", main="2")
dev.new()
plot(x,g_x(20),type="l", col="green", lwd=5, xlab="x", ylab="f(x)", main="3")


#2) f synartisi |x-pi|
f<-function(N){
  z<- vector(length = N)
  for(i in 0:N){
    z[i]<-ifelse(i<N/2, (L/2)-L*(i/N),L*(i/N)-L/2 )
  }
  z
}
