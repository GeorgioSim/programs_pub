#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#define M_PI 3.14159265358979323846
#define E 2.718281828459

 double f(double S, double Q, double dQ, double parameters[2]);
 char integer[10] = "0123456789";/*for iterating filenames*/

 int main (void)
 {
 FILE *fp;
 double L,n=2.;
 int i,k=0,cnt=0;
 char filename[11] = "Results.txt";
 printf("\nGive Length between 2 desmous proseggistika L=");
 scanf("%lf",&L);
 do
 {
    printf("\nGive n=; (epipleon desmoi ektos twn 2 akrwn)");
    scanf("%lf",&n);
 }while(n<1);

 double F[4]={0, 30./pow(L,2), 50./pow(L,2), 60./pow(L,2)}, parameters[2]={0, 50.};
 double S, Q,Q0=0.8, dQ;
 int Np=500;
 double S_start=0, S_end=2.*n*L, h=(S_end-S_start)/(Np+0.);        /*Poia einai h swsth synoriakh synthiki gia to S_end?*/
 for (int j=0; j<4; j++){
    S=0.;
    filename[11]='\0';
    filename[6] = integer[j+1];
    fp = fopen(filename, "w");
    parameters[0] = F[j];
    Q=Q0, dQ=0.;/*starting conditions*/
    double SQ=0.,CQ=0.;
    SQ=h*sin(Q);
    CQ=h*cos(Q);
    cnt=0;
    for (i=1; i<=Np; i++){
        S = S_start + h*i;
        Q = Q + h*dQ; /*estimating Q*/
        dQ = dQ + h*f(S, Q, dQ, parameters);
        SQ+=h*sin(Q);
            if ((SQ<h*sin(Q0)/2.) && (SQ>-h*sin(Q0)/2.))
            {
                cnt++;
                printf("%d\n",cnt);
            }
            if (cnt>n)
            {
                    break;
            }
        fprintf(fp, "%lf\n", SQ);
        }
        fprintf(fp,"\n\n\n");
        cnt=0;
    for(k=1;k<=Np;k++)
        {
            if (k<=i)
            {
                S = S_start + h*k;
                Q = Q + h*dQ; /*estimating Q*/
                dQ = dQ + h*f(S, Q, dQ, parameters);
                CQ+=h*cos(Q);
                fprintf(fp, "%lf\n", CQ);
            }
            else
            {
                break;
            }

        }
        cnt=0;
}
 return 0;
 }

 double f(double S, double Q, double dQ, double parameters[2])
 {
 double F=parameters[0], o=parameters[1];
 return -F*pow(M_PI,2.)/o*sin(Q);
 }

 /*BLEPW VOLUME 38 FEYNMANN LELIDIS IDIOTITES YLHS*/
