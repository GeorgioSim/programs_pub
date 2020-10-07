#include <stdio.h>
#include <stdlib.h>
#include <math.h>
int main()
{
int i;
double r0,x0,y0,z0,u0,ux0,uy0,uz0,a0,r,x,y,z,ux,uy,uz,G,Mplanet,tsmall,t,k,N;
FILE *X;
FILE *Y;
FILE *Z;
X=fopen("X_coordinates.txt","w");
Y=fopen("Y_coordinates.txt","w");
Z=fopen("Z_coordinates.txt","w");
ux=uy=uz=x=y=z=r=0.;
/* ta kalyrera input: x0=10^5 kai uy0=60000*/
    printf("\nGive initial conditions:\nx0=");
    scanf("%lf",&x0);
    printf("\ny0=");
    scanf("%lf",&y0);
    printf("\nz0=");
    scanf("%lf",&z0);
    printf("\nux0=");
    scanf("%lf",&ux0);
    printf("\nuy0=");
    scanf("%lf",&uy0);
    printf("\nuz0=");
    scanf("%lf",&uz0);
    printf("\n\nGive the amount of time you want to work for: t=");
    scanf("%lf",&t);
G=6.67408*pow(10,-11);
Mplanet=5.9722*pow(10,24);
tsmall=0.01;
k=G*Mplanet;
N=t/tsmall;
printf("\n N=%lf",N);
for (i=0; i<=N; i++)
{
if (x0<=100000000000 && y0<=100000000000 && z0<=100000000000)
{
    r=sqrt(pow(x0,2.)+pow(y0,2.)+pow(z0,2.));
    ux=ux0-k*x0*tsmall*pow(r,-3.);
    uy=uy0-k*y0*tsmall/pow(r,3.);
    uz=uz0-(k*z0*tsmall)/(pow(r,3.));
    x0=x0 + ux0*tsmall;
    y0=y0 + uy0*tsmall;
    z0=z0 + uz0*tsmall;
    printf("\n%lf",-k*x0*tsmall*pow(r,-3.));
    ux0=ux;
    uy0=uy;
    uz0=uz;


fprintf(X, "\n%lf",x0);
fprintf(Y, "\n%lf",y0);
fprintf(Z, "\n%lf",z0);
}
}

return 0;
}
