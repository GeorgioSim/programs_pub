% This is a 1D FDTD simulation with pulse
% It displays a "movie" of the signal
% Size of the FDTD space
clear;
ke=50;
% Position of the source
ks=5;
% Number of time steps
nsteps=1000;
% Cell size and time stepping
c0=3.e8;
dx=0.01;
dt=dx/(2.*c0);
% Constants
cc=c0*dt/dx;
% Initialize cb[k] and kstart for dielectric
cb=zeros(1,ke);
kstart=20;
epsilon=10;
% Initialize vectors
ex=zeros(1,ke);
hy=zeros(1,ke);
% Gaussian pulse
t0=20;
spread=8;
% Absorbing conditions initialisation
lex_low_m1=0.;
lex_low_m2=0.;
lex_high_m1=0.;
lex_high_m2=0.;
% Create and open the video object
vidObj = VideoWriter('Absorbing_both_ends_dielectric.avi');
open(vidObj);
% cb(k) according to dielectric
for k=1:ke
    cb(k)=cc;
end
for k=kstart:ke
   cb(k)=cc/epsilon 
end
% Main part of the program
for t=1:nsteps
% E field loop
for k=2:ke-1
ex(k)=ex(k)+cb(k)*(hy(k-1)-hy(k));
end
% Source
if t==1
[ex,spread]=Mybutton(ks,t,t0,ex,spread);
else
[ex,spread]=pulse(ks,t,t0,ex,spread);
end

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
    'String',{['spread = ' num2str(spread)],['\epsilon = ' num2str(epsilon)]},...
    'FontSize',10,...
    'FontName','Arial',...
    'LineStyle','--',...
    'FitBoxToText','on');
axis([1 ke -2 2]);
M(:,t) = getframe ;
% input('')
end
writeVideo(vidObj,M);
close(vidObj);