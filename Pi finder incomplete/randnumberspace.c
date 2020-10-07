#include <stdio.h>
#include <math.h>
#include <stdlib.h>
int main()
{
	int i;
	double r, max, randmax, y, x, dif;
	printf("\n\nGive space [x,y] to let me find random numbers\n");
	do
	{
	max=r=x=y=dif=0;	
	printf("\n\nx=");
	scanf("%lf", &x);
	printf("\ny=");
	scanf("%lf", &y);
	randmax = 32767;
	dif = y - x;
	for (i = 0; i <= 100; i++)
	{
		r = dif * rand() / randmax + x;
		printf("\n%lf", r);
	}
	}while ((x!=0)&&(y!=0));
	
	return 0;
}
