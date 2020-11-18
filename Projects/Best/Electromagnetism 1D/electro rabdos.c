#include <stdio.h>
#include <stdlib.h>
#include <math.h>

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


int i,j,k;
double L[]={2,1,1.1};      //eyros timwn (poso tha ekteinontai) x,y,b
int N[]={11,11,11};      //plithos timwn x,y,b
double start[]={0.2,0.2,1} ;     //enar3i timwn x,y,b
double d[3],t[3][N[2]];     //thelei allagi sto N[2]. Prepei na parw to max(N)

 for(i=0;i<3;i++)
 {
    d[i]=L[i]/N[i];
                            //diameriseis twn x,y,b (d[]={dx,dy,db}  )
 }
 for(i=0;i<3;i++)
 {
    for(j=0;j<N[i];j++)
    {
        t[i][j]= j* d[i] + start[i];
    }
 }
   int n=1,z=0;
   double nmax[]={1,7,19}, psi[N[0]][N[1]][N[2]][sizeof(nmax)/sizeof(nmax[0])];
for(i=0;i<N[0];i++)
{
    for(j=0;j<N[1];j++)
    {
        for(k=0;k<N[2];k++)
        {
            for(z=0;z<(sizeof(nmax)/sizeof(nmax[0]));z++)
            {
                psi[i][j][k][z]=0.;
            }
        }
    }
}
fprintf(fptr, "x \t y \t b \t n \t func");
for(i=0;i<N[0];i++)
{
    for(j=0;j<N[1];j++)
    {
        for(k=0;k<N[2];k++)
        {
            for(z=0;z<(sizeof(nmax)/sizeof(nmax[0]));z++)
            {
                for (n=1; n<=nmax[z]; n=n+2)       //gia to loop tou synolou.
                {
                    psi[i][j][k][z]+=exp(-n*M_PI*t[0][i]/t[2][k])*sin(n*M_PI*t[1][j]/t[2][k]);
                }
            psi[i][j][k][z]*=(4/M_PI);
            fprintf(fptr, "\n %lf \t %lf \t %lf \t %lf \t %lf", t[0][i],t[1][j],t[2][k],nmax[z], psi[i][j][k][z]);        //+ nmax[z] , -n
            }
        }
    }
}

   fclose(fptr);
 return 0;
 }
