% This is a 1D FDTD simulation with pulse
% It displays a "movie" of the signal
% Size of the FDTD space
clear;
clear all;

ke=150;
% Position of the source
ks=70;
% Number of time steps
nsteps=300;
%N number of circles
N=2;
% Gaussian pulse
t0=35;
spread=15;
Ts = 1;
T=nsteps;
fs = 1/Ts;   % Sampling frequency
t = 1:Ts:T;  % Time vector 
freq_in=2*pi*N/T;
freq_in
% Cell size and time stepping
%after fftshift: paratirw oti to >1.5 einai kalo
fmax=hifftmethod(t0,spread,N,nsteps);
% fmax=freq_in*fdiff;
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
kstart=70;
epsilon=1.5;
epsz=1;
sigma=0.04;
eaf=dt*sigma/(2*epsz*epsilon);
eaf

% Initialize vectors
ex=zeros(1,ke);
hy=zeros(1,ke);
% Absorbing conditions initialisation
lex_low_m1=0.;
lex_low_m2=0.;
lex_high_m1=0.;
lex_high_m2=0.;
lhy_low_m1=0.;
lhy_low_m2=0.;
lhy_high_m1=0.;
lhy_high_m2=0.;
% Create and open the video object
vidObj = VideoWriter('SIN_pulse_lossy_medium.avi');
open(vidObj);
% cb(k) according to dielectric
for k=1:ke
    ca(k)=1;
    cb(k)=cc;
end
for k=kstart:ke
   ca(k)=(1-eaf)/(1+eaf);
   cb(k)=cc/(epsilon*(1+eaf)) ;
end


% Main part of the program
for n=1:nsteps
% Source
%pulser=sin(2*pi*freq_in*dt*n);
pulser=exp(-.5*((n-t0)/spread).^2)*sin(2*pi*freq_in*n);
ex(ks)=ex(ks)+pulser;
% E field loop
for k=2:ke-1
ex(k)=ca(k)*ex(k)+cb(k)*(hy(k-1)-hy(k));
end
% H field loop
for k=1:ke-1
hy(k)=hy(k)+cc*(ex(k)-ex(k+1));
end


% Absorbing Boundary Conditions
ex(1)= lex_low_m2;
lex_low_m2=lex_low_m1;
lex_low_m1=ex(2);

hy(1)= lhy_low_m2;
lhy_low_m2=lhy_low_m1;
lhy_low_m1=hy(2);

ex(ke)=lex_high_m2;
lex_high_m2=lex_high_m1;
lex_high_m1=ex(ke-1);

hy(ke)=lhy_high_m2;
lhy_high_m2=lhy_high_m1;
lhy_high_m1=hy(ke-1);

plot(ex);
annotation('textbox',...
    [0.7 0.6 0.2 0.3],...
    'String',{['epsilon = ' num2str(epsilon)],['sigma = ' num2str(sigma)]},...
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