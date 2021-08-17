/* FD1D_1.2.C. 1D FDTD simulation in free space */
/* Absorbing Boundary Condition added */
# include <math.h>
# include <stdlib.h>
# include <stdio.h>
#define KE 200
int main ()
{
float ex[KE],hy[KE];
float ex_low_m1,ex_low_m2,ex_high_m1,ex_high_m2;
for ( n=1; n <=NSTEPS ; n++)
{
T = T + 1;
/* Main FDTD Loop */
/* Calculate the Ex field */
for ( k=1; k < KE; k++ )
{ ex[k] = ex[k] + .5*( hy[k-1] - hy[k] ) ; }
/* Put a Gaussian pulse in the middle */
pulse = exp(-.5*(pow( (t0-T)/spread,2.0) ));
ex[kc] = ex[kc] + pulse;
printf( "%5.1f %6.2f %6.2f \ n",t0-T,arg,ex[kc]);
/* Absorbing Boundary Conditions */
ex[0] = ex_low_m2;
ex_low_m2 = ex_low_m1;
ex_low_m1 = ex[1];
ex[KE-1] = ex_high_m2;
ex_high_m2 = ex_high_m1;
ex_high_m1 = ex[KE-2];
/* Calculate the Hy field */
for ( k=0; k < KE-1; k++ )
{ hy[k] = hy[k] + .5*( ex[k] - ex[k+1] ) ; }
}
/* End of the Main FDTD Loop */
/* FD1D_1.3.c.
/* Simulation of a pulse hitting a dielectric medium */
