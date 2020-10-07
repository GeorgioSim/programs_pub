#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>
double myseq(double x,double y);
int main()
{
	int i,k,Nsquare;
	double a,b,r,c,m,n,s,s2;
	printf("\n I will calculate pi as close as possible\n");
	Nsquare=0;
		printf("\n\nGive space [a,b] to let me find random numbers\n");
	printf("\n\na=");
	scanf("%lf", &a);
	printf("\nb=");
	scanf("%lf", &b);
		c=b-a;
		r=c/2.;
	for(i=0;i<=Nsquare;i++)
	{
	s=myseq(a,b);
	sleep(1);
	s2=myseq(a,b);
	printf("\n%lf",s);
	printf("\n%lf",s2);
	}
	return 0;
}

double myseq(double x,double y)
{
	double r, max, randmax, dif;
	srand(time(NULL));
	max=r=dif=0.;
	randmax = 32767.;
	dif = y - x;
	r = (dif * rand() / randmax) + x;
	return (r);
}
