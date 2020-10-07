#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#include <time.h>
#define M_PI  3.14159265358979323846
 double f(double t, double Q, double dQ, double parameters[3]);

 int main (void)
 {
 FILE *fp;
 fp=fopen("BULLET.txt","w");
 double g,m,b;
 g=9.807;
 m=0.12;
 b=0.1;
 double u0[3]={300.,1200.,1700.}, parameters[3]={g, m, b};
 double t=0., Q, dQ;
 int Np=1000;
 double t_start=0., t_end=10., h=(t_end-t_start)/(Np+0.);

 for (int j=0; j<3; j++){
 Q=0., dQ=u0[j];/*starting conditions*/
 for (int i=1; i<=Np; i++){
 t = t_start + h*i;
 Q = Q + h*dQ; /*estimating Q*/
 dQ = dQ + h*f(t, Q, dQ, parameters);/*estimating dQ/dt*/

 fprintf(fp, "%lf \t,\t %lf\n", t, Q);/*saving results*/
 }
 }
 return 0;
 }

 double f(double t, double Q, double dQ, double parameters[3])
 {
 double g=parameters[0], m=parameters[1], b=parameters[2];
 return (-b/m*dQ);
 }

 /*exw ftia3ei mono thn orizontia thesh me antistash aera. leipei h y synistwsa*/
