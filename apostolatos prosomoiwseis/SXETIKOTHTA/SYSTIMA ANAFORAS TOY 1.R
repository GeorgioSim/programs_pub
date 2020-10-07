#se monades c=1
v1x=0.99
v1y=0.01
v1z=0 
v2x=0.5 
v2y=0.01
v2z=0
v1<-c(v1x, v1y, v1z)
v2<-c(v2x, v2y, v2z)
vd<-v1%*%v2
norm_vec <- function(x) sqrt(sum(x^2))
g1<-1/sqrt(1-norm_vec(v1)^2)
g2<-1/sqrt(1-norm_vec(v2)^2)
u2sq<-norm_vec(v2)^2
#g kai v systhmatos 2
gs2<-g1*g2*(1-vd)
vs2<-(g1*v1-g1*g2*v2+((g2-1)*g1*vd*v2)/u2sq)/gs2
vs2
vs2*299792458