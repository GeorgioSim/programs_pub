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
dt=0.5.*dx/c0;
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
if t==1
[ex,spread]=Mybutton(ks1,ks2,t,t0,ex,spread);
else
[ex,spread]=pulses(ks1,ks2,t,t0,ex,spread);
end
% H field loop
for k=1:ke-1
hy(k)=hy(k)+cc*(ex(k)-ex(k+1));
end

plot(ex);axis([1 ke -2 2]);
M(:,t) = getframe ;
% input('')


end
writeVideo(vidObj,M);
close(vidObj);

