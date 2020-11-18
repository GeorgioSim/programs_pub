#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>
#include <unistd.h>
double myseq(double x,double y);
int main()
{
	int i,k,Nsquare,Ncircle;
	double a,b,r,c,m,n,s,s2,pi;
	pi=0.;
	printf("\n I will calculate pi as close as possible\n");
	Ncircle=0;
	Nsquare=1000000;
		printf("\n\nGive space [a,b] to let me find random numbers. The bigger the space the better the approximation.\n");
	printf("\n\na=");
	scanf("%lf", &a);
	printf("\nb=");
	scanf("%lf", &b);
		c=b-a;
		r=c/2.;
	for(i=0;i<=Nsquare;i++)
	{
		s=s2=0.;
	s=myseq(a,b);
	s2=myseq(a,b);
	//printf("\n%lf",s);
	//printf("\n%lf",s2);
	if ((pow(s-a,2.)+pow(s2-b,2.)<=pow(b-a,2.)))Ncircle++;
	}
	pi=4.*Ncircle/Nsquare;
	printf("\npi=%lf", pi);

	sleep(1000);  //easy solution
	return 0;
}

double myseq(double x,double y)
{
	double r, max, randmax, dif;
	max=r=dif=0.;
	randmax = 32767.;
	dif = y - x;
	r = (dif * rand() / randmax) + x;
	return (r);
}

