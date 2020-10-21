#include <stdio.h>
#include <stdlib.h>
#include <math.h>
int main()
{
    int i,N;
    double u,x,x0,a,g,a1,an,t,e,m1,m,G,Mplanet,H,R,u0,t0,k;
FILE *X;
FILE *Y;
X=fopen("Velocity.txt","w");
Y=fopen("N_engines.txt","w");
k=20.;
printf("\t---Welcome to INITIAL VELOCITY CALCULATOR V2 By Simgeorge (ft. Tsiobieman).\n It calculates the initial velocity spaceships should have so as to stop on time!---\n");
    printf("\n Give mass of ONE of the engines used for deceleration in kg: m1=");
    scanf("%lf", &m1);
    printf("\n Give mass of the aircraft in kg (without considering the working engines!): m=");
    scanf("%lf", &m);
    printf("\n Give the acceleration of the spaceship caused by only ONE engine (remove the working ones to do the experiment\nand put them back later: a1=");
    scanf("%lf",&a1);
    printf("\n Give the change of rate k in u0 (u0=u0+k) (k<< means more accurate): k=");
    scanf("%lf",&k);
    for (N=1; N<=50; N++)
    { printf("\n\n\t---- For %d/50 working engines we have the following results:\n",N);
    G=6.67408*pow(10,-11);
    Mplanet=5.9722*pow(10,24);
    H=35000;
    R=6360*pow(10,3);
    u0=100;
    u=u0;
    x0=0;
    x=x0;
    e=0.001;
    t0=0.;
    t=t0;
    an=a1*(m+m1)/(m/N+m1);
    while (u0<=1000 && x<H)
    {
        u=u0;
        x=x0;
        t=t0;
        g=G*Mplanet/(pow(H+R-x,2));
        u0=u0+k;
        a=g-an;
        while (t<=100 && u>=0 && x<H)
        {
            t=t+e;
            x=x+u*e;
            u=u+a*e;
        }
/*printf("\n\t x=%lf, u0=%lf",x,u0-50.);*/

    }
printf("\nu=%lf", u0-50.);
printf("\nN=%d",N);
fprintf(X, "\n%lf", u0-50.);
fprintf(Y, "\n%d",N);
    }
fclose(X);
fclose(Y);
    return 0;
}
