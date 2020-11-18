#include "stdio.h"
#include "math.h"
#include "physicsynartiseis.h"
#include <stdlib.h>

int main()
{
int a,i,j,k,y,N, Nm, NL, NE, NV, p=1;
double tempo, m=1.,L=1.,E=1.,T=1.,T2=1.,V=1.,mmax,mmin,Lmax,Lmin,Emax,Emin,Vmax,Vmin, stpNm, stpNL, stpNE, stpNV;
FILE *Y;
Y=fopen("T_dieleysis_Y_data.txt","w");
FILE *Ey;
Ey=fopen("T_dieleysis_E_data.txt","w");
FILE *Vy;
Vy=fopen("T_dieleysis_V_data.txt","w");
FILE *my;
my=fopen("T_dieleysis_m_data.txt","w");
FILE *Ly;
Ly=fopen("T_dieleysis_L_data.txt","w");
FILE *Y2;
Y2=fopen("T_dieleysis_Y2_data.txt","w");
printf("\n Welcome! Press 0 for manual parameters, (under construction: any other number)\t\t");
scanf("%d",&a);

if (a==0)
{
    printf("\n To exit input 0 to all parameters.");
    while (m!=0 && L!=0 && E!=0 && V!=0)
        {
            printf("\nGive parameters:\n");
            printf("\nm (in MeV/c^2)=");
            scanf("%lf",&m);        //to Mev/c^2
            m=m*pow(10,6);      //to ev/c^2
            fprintf(my,"%lf\n",m);      //to ev/c^2
            printf("\nL (in micrometers)=");
            scanf("%lf",&L);
            fprintf(Ly,"%lf\n",L);
            printf("\nE=");
            scanf("%lf",&E);
            fprintf(Ey,"%lf\n",E);
            printf("\nV=");
            scanf("%lf",&V);
            fprintf(Vy,"%lf\n",V);
            T=T_dieleysis(V,E,L,m);
            printf("\n%lf\n\n",T);
            fprintf(Y,"%lf\n",T);
            T2=T_dieleysis_proseggisi(V,E,L,m);
            printf("\n%lf\n\n",T2);
            fprintf(Y2,"%lf\n",T2);

        }

}
else
{
    while (p==1)
  {
    int Nprod=1;
    p=0;
    //for m
    printf("\nGive range and the ammount of masses m (in MeV/c^2) in that range:");
    printf("\nm_min=");
    scanf("%lf",&mmin);
    printf("\nm_max=");
    scanf("%lf",&mmax);
    if (mmax<mmin)
    {
        tempo=mmax;
        mmax=mmin;
        mmin=tempo;
    }
    mmin=mmin*pow(10,6);
    mmax=mmax*pow(10,6);
    printf("\nN=");
    scanf("%d",&N);
    stpNm=(mmax-mmin)/N;
    tempo=0.;
    Nm=N;
    Nprod*=N;
    N=1;


    //for L
    printf("\nGive range and the ammount of lengths L (in micrometers) in that range:");
    printf("\nL_min=");
    scanf("%lf",&Lmin);
    printf("\nL_max=");
    scanf("%lf",&Lmax);
    if (Lmax<Lmin)
    {
        tempo=Lmax;
        Lmax=Lmin;
        Lmin=tempo;
    }
    printf("\nN=");
    scanf("%d",&N);
    stpNL=(Lmax-Lmin)/N;
    tempo=1.;
    NL=N;
    Nprod*=N;
    N=1;


    //for E
    printf("\nGive range and the ammount of energies E (eV) in that range:");
    printf("\nE_min=");
    scanf("%lf",&Emin);
    printf("\nE_max=");
    scanf("%lf",&Emax);
    if (Emax<Emin)
    {
        tempo=Emax;
        Emax=Emin;
        Emin=tempo;
    }
    printf("\nN=");
    scanf("%d",&N);
    stpNE=(Emax-Emin)/N;
    tempo=1.;
    NE=N;
    Nprod*=N;
    N=1;

    //for V
    printf("\nGive range and the ammount of energies V (eV) in that range:");
    printf("\nV_min=");
    scanf("%lf",&Vmin);
    printf("\nV_max=");
    scanf("%lf",&Vmax);
    if (Vmax<Vmin)
    {
        tempo=Vmax;
        Vmax=Vmin;
        Vmin=tempo;
    }
    printf("\nN=");
    scanf("%d",&N);
    stpNV=(Vmax-Vmin)/N;
    tempo=1.;
    NV=N;
    Nprod*=N;
    N=1;

    if (Nprod<1000000)
    {//looped all data
    for (i=0;i<Nm;i++)
    {

        for (j=0;j<NL;j++)
        {
                for (k=0;k<NE;k++)
                {
                    for (y=0;y<NV;y++)
                    {
                        m = mmin + stpNm * i;
                        L = Lmin + stpNL * j;
                        E = Emin + stpNE * k;
                        V = Vmin + stpNV * y;
                        if (E!=V)
                            {
                                T = T_dieleysis(V,E,L,m);
                                T2=T_dieleysis_proseggisi(V,E,L,m);
                                fprintf(my,"%g\n",m);
                                fprintf(Ly,"%g\n",L);
                                fprintf(Ey,"%g\n",E);
                                fprintf(Vy,"%g\n",V);
                                fprintf(Y,"%g\n",T);
                                fprintf(Y2,"%g\n",T2);
                            }


                    }
                }
        }
    }
    }
    else
    {
        p=1;
    }
  }


}
fclose(Y);
fclose(Y2);
fclose(my);
fclose(Ly);
fclose(Ey);
fclose(Vy);

return 0;
}

