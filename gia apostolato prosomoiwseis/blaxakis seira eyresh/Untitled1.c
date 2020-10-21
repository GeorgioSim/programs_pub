#include <stdio.h>
#include <stdlib.h>
#include <math.h>
int main()
{
int i,N;
double x,y,sum;
N=20.;
sum=0.;
for (i=1; i<=N; i++)
{
    sum+=pow(2,(1-i)/12);
}
printf("\n%lf",sum);

}
