clear all; format long; clc;             % 2D-Helmholtz Equation
k=2*pi;
lambda = 2.*pi./k;
% Nx=256*1; Lx=30; x=(Lx/Nx)*(-Nx/2:Nx/2-1)'; dx=x(2)-x(1); % x-grid
% Ny=256*1; Ly=30; y=(Ly/Ny)*(-Ny/2:Ny/2-1)'; dy=y(2)-y(1); % y-grid
Nx=256*1; Lx=30.*pi.*lambda; x=(Lx/Nx)*(-Nx/2:Nx/2-1)'; dx=x(2)-x(1); % x-grid
Ny=Nx; Ly=Lx; y=(Ly/Ny)*(-Ny/2:Ny/2-1)'; dy=y(2)-y(1); % y-grid
kx=(2*pi/Lx)*[0:Nx/2-1 -Nx/2:-1]'; % kx-grid
ky=(2*pi/Ly)*[0:Ny/2-1 -Ny/2:-1]'; % ky-grid
[X,Y]=meshgrid(x,y); [KX,KY]=meshgrid(kx,ky);

w=40;  u00=exp(-(X/w).^8-(Y/w).^8); % Beam at z=0
kz = 5.5;
kr = sqrt(k.^2-kz.^2);
r = sqrt(x.^2 + y.^2);
% Magic speckle random number gen

phi = exp(1i*(kx.*x+ky.*y));
rand = randn(size(phi));
Rand0 = sum(rand.*phi);
u0 = u00 .* Rand0;

figure(1); surf(X,Y,abs(u0).^2); shading interp; view([0 90]);
axis square; axis tight;  % initial intensity at z=0
figure(2); surf(KX,KY,abs(fft2(u0))); shading interp; view([0 90]);
axis square; axis tight;  % Initial spectrum at z=0

S=100; zmax=lambda*5 ; z=linspace(0,zmax,S);
% S=100; zmax=10; z=linspace(0,zmax,S);

for m=1:S   % Solution of Helmholtz equation
    m
    u1=ifft2(fft2(u0).*exp(1i*z(m)*sqrt(k^2-KX.^2-KY.^2)));
    field(m,:,:)=u1;
end; 
figure(3); surf(X,Y,abs(u1).^2); shading interp; view([0 90]);
axis square; axis tight; % Final intensity at z=zmax
figure(4); surf(KX,KY,abs(fft2(u1))); shading interp; view([0 90]);
axis square; axis tight;  % Final spectrum at z=zmax

% Note: Outside the +/- (2*pi) in the fourier spectrum, we have 
% evansecent waves. If the beam's width becomes compare to thewavelength
% (1 micron here) then you do have evanescent waves