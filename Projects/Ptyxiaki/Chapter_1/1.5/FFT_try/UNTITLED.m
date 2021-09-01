% This is a 1D FDTD simulation with pulse
% It displays a "movie" of the signal
% Size of the FDTD space
clear;
clear all;
ke=100;
% Position of the source
ks=10;
% Number of time steps
nsteps=300;
% freq pulse. Max: 1e5
freq_in=40;
%freq_in=400*1e6;
% Gaussian pulse
t0=20;
spread=8;
% Cell size and time stepping
%after fftshift: paratirw oti to >1.5 einai kalo
fdiff=hifftmethod_try(t0,spread,freq_in);
fmax=freq_in*fdiff;
fmax
% Cell size and time stepping
c0=3.e8;
lambdamin=c0/fmax;
dx=lambdamin/10;
dx
dt=dx/(2.*c0);
dt

% Constants
cc=c0*dt/dx;
% Initialize cb[k] and kstart for dielectric
cb=zeros(1,ke);
kstart=50;
epsilon=4;
% Initialize vectors
ex=zeros(1,ke);
hy=zeros(1,ke);
% Absorbing conditions initialisation
lex_low_m1=0.;
lex_low_m2=0.;
lex_high_m1=0.;
lex_high_m2=0.;
% Create and open the video object
vidObj = VideoWriter('SIN_pulse.avi');
open(vidObj);
% cb(k) according to dielectric
for k=1:ke
    cb(k)=cc;
end
for k=kstart:ke
   cb(k)=cc/epsilon ;
end

%Calculating R(reflection) and T(trasmission) coefficients
R=(1-sqrt(epsilon))/(1+sqrt(epsilon));
T=2/(1+sqrt(epsilon));
R;
T;
% Main part of the program
for n=1:nsteps
% E field loop
for k=2:ke-1
ex(k)=ex(k)+cb(k)*(hy(k-1)-hy(k));
end
% Source
%pulser=sin(2*pi*freq_in*dt*n);
pulser=pulse(n,t0,dt,freq_in,spread);
ex(ks)=ex(ks)+pulser;

% Absorbing Boundary Conditions
ex(1)= lex_low_m2;
lex_low_m2=lex_low_m1;
lex_low_m1=ex(2);

ex(ke)=lex_high_m2;
lex_high_m2=lex_high_m1;
lex_high_m1=ex(ke-1);

% H field loop
for k=1:ke-1
hy(k)=hy(k)+cb(k)*(ex(k)-ex(k+1));
end
plot(ex);
annotation('textbox',...
    [0.7 0.6 0.2 0.3],...
    'String',{['spread = ' num2str(spread)],['dx = ' num2str(dx)]},...
    'FontSize',10,...
    'FontName','Arial',...
    'LineStyle','--',...
    'FitBoxToText','on');
axis([1 ke -2 2]);
M(:,n) = getframe ;
% input('')
end
writeVideo(vidObj,M);
close(vidObj);