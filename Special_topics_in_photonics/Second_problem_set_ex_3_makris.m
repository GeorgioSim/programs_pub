clear all; format long; clc; % 2D Free space diffraction
Nx=256; Lx=150; x=(Lx/Nx)*(-Nx/2:Nx/2-1)'; dx=x(2)-x(1);
Ny=256; Ly=150; y=(Ly/Ny)*(-Ny/2:Ny/2-1)'; dy=y(2)-y(1);
kx=(2*pi/Lx)*[0:Nx/2-1 -Nx/2:-1]'; ky=(2*pi/Ly)*[0:Ny/2-1 -Ny/2:-1]'; 
[X,Y]=meshgrid(x,y); [KX,KY]=meshgrid(kx,ky); 

F = imread('Newton.jpg');
F2 = rgb2gray(F); % get rid of the extra dimension
F3 = imresize(F2,[Nx Ny]); % resise the image to our grid
F4 = double(F3);                % double precision
F4=abs(F4)/max(max(abs(F4)));  % normalization

%paxos
w=3; 
gaussian=exp(-(X/w).^2-(Y/w).^2);

newton = F4;
% u = F4;
%  u = gaussian;
u = gaussian*exp(1i*newton);

figure(1); surf(X,Y,abs(u)); shading interp; colormap(jet); view([180 90]); 
axis tight; axis square;

S=100; zmax=10; z=linspace(0,zmax,S); u0=u;
for m=1:S
 m
 u1=ifft2(fft2(u0).*exp(-1i*z(m)*(KX.^2+KY.^2)));
 field(m,:,:)=u1; 
 figure(3); surf(X,Y,abs(u1).^2); axis([-70 70 -70 70]);
 shading interp;  colormap(jet); axis square;  
  view([180 90]); 
drawnow;
end
