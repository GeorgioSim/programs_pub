% This is a 1D FDTD simulation with pulse
% It displays a "movie" of the signal
% Size of the FDTD space
clear;
ke=50;
% Position of the source
ks=ke/2;
ks1=ks-20;
ks2=ks+20;
% Number of time steps
nsteps=100;
% Cell size and time stepping
c0=3.e8;
dx=0.01;
dt=dx/(2.*c0);
% Constants
cc=c0*dt/dx;
% Initialize vectors
ex=zeros(1,ke);
hy=zeros(1,ke);
% Gaussian pulse
t0=20;
spread=8;
% Create and open the video object
vidObj = VideoWriter('2_Sources.avi');
open(vidObj);
for t=1:nsteps
% E field loop
for k=2:ke-1
ex(k)=ex(k)+cc*(hy(k-1)-hy(k));
end
% Source
pulse=exp(-.5*((t-t0)/spread)^2);
ex(ks1)=pulse;
pulse2=exp(-.5*((t-t0)/spread)^2);
ex(ks2)=pulse2;
% H field loop
for k=1:ke-1
hy(k)=hy(k)+cc*(ex(k)-ex(k+1));
end
plot(ex) 
annotation('textbox',...
    [0.7 0.6 0.2 0.3],...
    'String',{['spread = ' num2str(spread)]},...
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