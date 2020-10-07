#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#include <time.h>
#define M_PI  3.14159265358979323846

int main(void)
{
    FILE *fp;
    int i,j,Np=500,Np1=20,Np2=500;
    double t=0.,t0,x=0.,x0,vstop2=0.999,vstart=-0.999,vstop1,vstop=-0.3,v=0.,h,h1,h2,g=0.;
    vstop1=-vstop;
    h=(vstop-vstart)/Np;
    h1=(vstop1-vstop)/Np1;
    h2=(vstop2-vstop1)/Np2;
    printf("\nGive t0=");
    scanf("%lf",&t0);
    printf("\nGive x0=");
    scanf("%lf",&x0);
        fp=fopen("Results.txt", "w");
        t=x=0.;
        for (j=1;j<Np;j++)
        {
            v=vstart+h*j;
            g=1./(sqrt(1.-pow(v,2.)));
            t=g*(t0-v*x0);
            fprintf(fp,"%lf\n",t);
        }
        for (j=1;j<Np1;j++)
        {
            v=vstop+h1*j;
            g=1./(sqrt(1.-pow(v,2.)));
            t=g*(t0-v*x0);
            fprintf(fp,"%lf\n",t);
        }
        for (j=1;j<=Np2;j++)
        {
            v=vstop1+h2*j;
            g=1./(sqrt(1.-pow(v,2.)));
            t=g*(t0-v*x0);
            fprintf(fp,"%lf\n",t);
        }

        v=0.;
        fprintf(fp,"\n\nPosition\n\n");
        for (j=1;j<Np;j++)
        {
            v=vstart+h*j;
            g=1./(sqrt(1.-pow(v,2.)));
            x=g*(x0-v*t0);
            fprintf(fp,"%lf\n",x);
        }
        for (j=1;j<Np1;j++)
        {
            v=vstop+h1*j;
            g=1./(sqrt(1.-pow(v,2.)));
            x=g*(x0-v*t0);
            fprintf(fp,"%lf\n",x);
        }
        for (j=1;j<=Np2;j++)
        {
            v=vstop1+h2*j;
            g=1./(sqrt(1.-pow(v,2.)));
            x=g*(x0-v*t0);
            fprintf(fp,"%lf\n",x);
        }
         v=0.;
        fprintf(fp,"\n\nVelocity\n\n");
        for (j=1;j<Np;j++)
        {
            v=vstart+h*j;
            fprintf(fp,"%lf\n",v);
        }
        for (j=1;j<Np1;j++)
        {
            v=vstop+h1*j;
            fprintf(fp,"%lf\n",v);
        }
        for (j=1;j<=Np2;j++)
        {
            v=vstop1+h2*j;
            fprintf(fp,"%lf\n",v);
        }

fclose(fp);
    return 0;
}
