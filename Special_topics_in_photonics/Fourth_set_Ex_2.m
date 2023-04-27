clear all; format long; clc; % 1D Free space diffraction
Nx=256; Lx=2*pi; x=(Lx/Nx)*(-Nx/2:Nx/2-1)'; dx=x(2)-x(1);
kx=(2*pi/Lx)*[0:Nx/2-1 -Nx/2:-1]'; 
L = 2*pi;
lambda = 4*pi;
A=1;
k = 2*pi./L;

u=1./2+A./2*cos(k*x); % Talbot effect

% S=100; zmax=L.^2./lambda; z=linspace(0,zmax,S); u0=u;
S=100; zmax=2*L.^2./lambda; z=linspace(0,zmax,S); u0=u;
for m=1:S
 u1=ifft(fft(u0).*exp(-1i*z(m)*kx.^2)); field(m,:)=u1; 
end
[X,Z]=meshgrid(x,z); 
figure(1); plot(x,abs(u),'-b',x,abs(u1),'-r'); axis square;
figure(2); surf(X,Z,abs(field)); shading interp; colormap(jet); 
axis tight; axis square; view([0 90]); 