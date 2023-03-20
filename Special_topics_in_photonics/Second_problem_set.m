clear all; format long; clc; % 1D Free space diffraction
Nx=256; Lx=2*pi*20; x=(Lx/Nx)*(-Nx/2:Nx/2-1)'; dx=x(2)-x(1);
kx=(2*pi/Lx)*[0:Nx/2-1 -Nx/2:-1]'; 

a=0.05;
z=0;
u=airy(x./sqrt(2)-z.^2./4+1i.*a.*z).*exp(a.*x./sqrt(2)-a.*z.^2./2-1i.*z.^3./12+a.^2.*z./2+1i.*z.*x./sqrt(2).^3);
% u=exp(-(x./3).^8);

S=100; zmax=20; z=linspace(0,zmax,S); u0=u;
for m=1:S
 u1=ifft(fft(u0).*exp(-1i*z(m)*kx.^2)); field(m,:)=u1; 
end

%u2 is the analytical solution
u2=airy(x./sqrt(2)-z.^2./4+1i.*a.*z).*exp(a.*x./sqrt(2)-a.*z.^2./2-1i.*z.^3./12+a.^2.*z./2+1i.*z.*x./sqrt(2).^3);
u2_last=u2(:,S);
u2=u2';


[X,Z]=meshgrid(x,z); 
figure(1); plot(x,abs(u),'-b',x,abs(u1),'-r'); axis square;
figure(2); surf(X,Z,abs(field)); shading interp; colormap(jet);

%checking if u2 is equal to u1
figure(3); plot(x,abs(u2_last),'-b',x,abs(u1),'-r'); axis square;
figure(4); surf(X,Z,abs(u2)); shading interp; colormap(jet); 

axis tight; axis square; view([0 90]); 