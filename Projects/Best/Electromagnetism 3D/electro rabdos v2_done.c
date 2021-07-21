#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "electrosynartiseis.h"



//lathos gia diorthosi: isws me to psi na ginetai lathos ypologismos (bgainei apotelesma 0 sxedon panta


//prosthetw: if statement gia to start kai to L wste na ginei antallagi twn synistwswn


//lynei hlektrostatiko problima me laplacian statherou dynamikou V ston 3D xwro
//oi lyseis e3artwntai apo tis SS kathe fora, ara epilegw thn swsth (argotera ftiaxnw program me pointers gia ayto)
//mporw gia tis statheres SS na ftia3w void synartisi poy na allazei me sliders mesw ths R
//me thn seira ths ayth dinei thn swsth lysh
//leipei: polles times
int main(void)
 {
    FILE* fptr;
    fptr = fopen("electrograph.txt","w");
    if(fptr == NULL)
   {
      printf("Error!");
      exit(1);
   }


int i,j,k,l,m,o;
double L[]={2,2,1,1.1,1.1,2};      //eyros timwn (poso tha ekteinontai) x,y,z,a,b,c
int  size_LNd=sizeof(L)/sizeof(L[0]);
int N[]={10,10,10,1,1,1},Nmax=largest(N, size_LNd) ;      //plithos timwn x,y,z,a,b,c
double start[]={0,0,0,1,1,1}
;     //enar3i timwn x,y,z,a,b,c


double d[size_LNd],t[size_LNd][Nmax];

 for(i=0;i<size_LNd;i++)
 {
    if(N[i]!=0)
    {
        d[i]=L[i]/N[i];
    }
    else
    {
        d[i]=0;
        start[i]=0.;        //gia na exei nohma to t[][]
    }
                            //diameriseis twn x,y,z,a,b (d[]={dx,dy,dz,da,db}  )
 }
 for(i=0;i<size_LNd;i++)
 {
    for(j=0;j<N[i];j++)
    {
        t[i][j]= j* d[i] + start[i];
    }
 }
   int nx=1,ny=1,p=0,q=0;
   double n=1,nx_max[]={1,7,19}, ny_max[]={1,7,19};
   int size_nx_max=sizeof(nx_max)/sizeof(nx_max[0]),size_ny_max=sizeof(ny_max)/sizeof(ny_max[0]) ;
   double  psi=0.;                           //kati prepei na kanw, einai yperbolika megalhs diastasis

fprintf(fptr, "x \t\t y \t\t z \t\t a \t\t b \t\t c \t\t nx \t\t ny \t\t func");
for(i=0;i<N[0];i++)
{
    for(j=0;j<N[1];j++)
    {
        for(k=0;k<N[2];k++)
        {
            for(l=0;l<N[3];l++)
            {
                for(m=0;m<N[4];m++)
                {
                    for(o=0;o<N[5];o++)
                    {
                        for(p=0;p<size_nx_max;p++)
                        {
                            for(q=0;q<size_ny_max;q++)
                            {
                                psi=0.;
                                for(nx=1; nx<=nx_max[p]; nx=nx+2 )
                                {
                                    for (ny=1; ny<=ny_max[q]; ny=ny+2)       //gia to loop tou synolou.
                                    {
                                        n=pow(pow(nx*M_PI/t[3][l],2)+pow(ny*M_PI/t[4][m],2),0.5);
                                        psi+=(1/nx)*(1/ny)*(1/sinh(n *t[5][o])) *sin(nx*M_PI*t[0][i]/t[3][l])*sin(ny*M_PI*t[1][j]/t[4][m])*sinh(n*t[2][k]);
                                    }
                                }
                            psi*=pow(4/M_PI,2);
                            fprintf(fptr, "\n %lf \t %lf \t %lf \t %lf \t %lf \t %lf \t %lf \t %lf \t %lf", t[0][i],t[1][j],t[2][k],t[3][l],t[4][m],t[5][o], nx_max[p],ny_max[q], psi);        //+ nmax[z] , -n
                            }

                        }

                    }
                }
            }
        }
    }
}
   fclose(fptr);
 return 0;
 }

