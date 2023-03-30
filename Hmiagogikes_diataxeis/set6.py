import numpy as np
import sympy as sp
tp=4*10**-7
tn=1*10**-7
t0=(tp+tn)/2
kT=0.026
A=10**-4
ni=10**10 
μp=477 
μn=801 
Na=5*10**15
Nd=10**15
q=1.61*10**-19
Dn=33.75
Dp=12.4
ks=11.8
e0=8.85*10**-14
Va=-10
#Va=-0.1
Vbi=kT*np.log(Nd*Na/ni**2)
#print(Vbi)
W=(2*ks*e0*(Vbi-Va)/q*(Na+Nd)/(Na*Nd))**0.5
#print(W)
G=ni/(2*t0)
#print(G)
I_RG=-q*A*G*W
#print(I_RG*10**12)

#c
Ln = (Dn*tn)**0.5
Lp = (Dp*tp)**0.5
I0 = q*A*ni**2*(Dn/(Ln*Na)+Dp/(Lp*Nd))
#print(I0)
#print(I_RG/I0)

#d
Va=0.1
W=(2*ks*e0*(Vbi-Va)/q*(Na+Nd)/(Na*Nd))**0.5
#print(W)
G=ni/(2*t0)
#print(G)
I_RG=-q*A*G*W
#print(I_RG*10**12)
Idiff = I0*np.exp(Va/kT)
#print(Idiff*10**12)
#print(I_RG/Idiff)

#e
Vaa = kT*np.log(2*t0/(q*A*ni*W)*I0+1)
#print(Vaa)


#ex4.8
kT=0.026
#1
a1 = 19.59
b1=-16.9
n1=1/(kT*a1)
I01=np.exp(b1)
print(n1)
print(I01)
#2
a2 = 32.16
b2=-23.5
n2=1/(kT*a2)
I02=np.exp(b2)
print(n2)
print(I02)
#3
a2 = 37.48
b3=-27.43
n2=1/(kT*a2)
I03=np.exp(b3)
print(n2)
print(I03)
