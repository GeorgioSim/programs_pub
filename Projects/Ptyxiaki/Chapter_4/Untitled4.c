
/* Simulation of a sinusoidal wave hitting a dielectric
medium */
# include <math.h>
# include <stdlib.h>
# include <stdio.h>
#define KE 200
main ()
{
float ddx,dt;
float freq_in;
ddx = .01; /* Cells size */
dt =ddx/6e8; /* Time steps */
/* These parameters specify the input */
printf( "Input freq (MHz)--> ");
scanf("%f", &freq_in);
freq_in = freq_in*1e6;
printf(" %8.0f \ n", freq_in);
T = 0;
nsteps = 1;
/* Main part of the program */
ONE-DIMENSIONAL SIMULATION WITH THE FDTD METHOD 19
while ( nsteps > 0 ) {
printf( "nsteps --> ");
scanf("%d", &nsteps);
printf("%d \ n", nsteps);
for ( n=1; n <=nsteps ; n++)
{
T = T + 1;
/* Calculate the Ex field */
for ( k=0; k < KE; k++ )
{ ex[k] = ex[k] + cb[k]*( hy[k-1] - hy[k] ) ; }
/* Put a Gaussian pulse at the low end */
pulse = sin(2*pi*freq_in*dt*T);
ex[5] = ex[5] + pulse;
printf( "%5.1f %6.2f %6.2f \ n",T,pulse,ex[5]);
/* FD1D_1.5.c. Simulation of a sinusoid hitting a lossy
dielectric medium */
{
float ca[KE],cb[KE];
/* Initialize to free space */
for ( k=0; k <= KE; k++ ) {
ca[k] = 1.;
cb[k] = .5;
}
printf( "Dielectric starts at --> ");
scanf("%d", &kstart);
printf( "Epsilon --> ");
scanf("%f", &epsilon);
printf( "Conductivity --> ");
scanf("%f", &sigma);
printf("%d %6.2f %6.2f \ n", kstart,epsilon, sigma);
eaf = dt*sigma/(2*epsz*epsilon);
printf(" %6.4f \ n", eaf);
for ( k=kstart; k >= KE; k++ ) {
ca[k] = (1. - eaf)/(1 + eaf) ;
cb[k] = .5/(epsilon*(1 + eaf) );
}
/* Main part of the program */
/* Calculate the Ex field */
for ( k=0; k < KE; k++ )
{ ex[k] = ca[k]*ex[k] + cb[k]*( hy[k-1] - hy[k] ) ; }
