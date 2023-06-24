clear all; format long; clc; % Two-Dimensioanl SSF-BPM
Nx=512; Lx=180; x=(Lx/Nx)*(-Nx/2:Nx/2-1)'; dx=x(2)-x(1);
Ny=512; Ly=180; y=(Ly/Ny)*(-Ny/2:Ny/2-1)'; dy=y(2)-y(1);
kx=(2*pi/Lx)*[0:Nx/2-1 -Nx/2:-1]'; ky=(2*pi/Ly)*[0:Ny/2-1 -Ny/2:-1]'; 
[X,Y]=meshgrid(x,y); [KX,KY]=meshgrid(kx,ky); po=zeros(Nx,Nx);
field=zeros(100,Nx,Ny);
S=1000; zmax=50; z=0; zz=linspace(0,zmax,S); h=zz(2)-zz(1);
count=0; dim=0; savestep=10;
% Definition of the transmittance function of a thin lens
pot=zeros(S,Nx,Ny); F=h*200; zfin=200; 
pot(2*zfin,:,:)=-(1/h)*(X.^2+Y.^2)/(4*F);
[X1,ZZ]=meshgrid(x,zz);
figure(1); surf(X1,ZZ,abs(pot(:,:,Nx/2+1))); shading interp; view([0 90]); 
axis square; axis tight;

% w=5; aa=0; u=exp(-((X+5*aa)/w).^2-((Y+aa)/w).^2);  u0=u;

F = imread('Newton.jpg');
F2 = rgb2gray(F); % get rid of the extra dimension
F3 = imresize(F2,[Nx Ny]); % resise the image to our grid
F4 = double(F3);                % double precision
F4=abs(F4)/max(max(abs(F4)));  % normalization
u=F4;
u0=u;

figure(2); surf(X,Y,abs(u).^2); shading interp; 
view([90 90]); axis tight; axis square;

for m=1:800
 po=squeeze(pot(m,:,:));
 u1=ifft2(fft2(u0).*exp(-1i*0.5*h*(KX.^2+KY.^2))); % First step of SSF 
 u2=exp(1i*h*po).*u1; % Second step of SSF
 u3=ifft2(fft2(u2).*exp(-1i*0.5*h*(KX.^2+KY.^2))); % Third step of SSF
 u0=u3; z=z+h; count=count+1;  if (count==savestep) dim=dim+1
 field(dim,:,:)=u0; fieldx(dim,:)=u0(:,Nx/2+1); z1(dim)=z; count=0; end 
end; [X1,Z1]=meshgrid(x,z1);
figure(3); surf(X,Y,abs(u0).^2); shading interp; 
view([90 90]); axis tight; axis square;
figure(4); surf(X,Y,angle(u0)); shading interp; view([90 90]); 
axis tight; axis square;
figure(5); surf(X1,Z1,abs(fieldx)); shading interp; 
view([90 90]); axis tight; axis square;
figure(6); fie(:,:)=field(80,:,:); % field comparison input and at focus
plot(x,abs(fie(:,Nx/2+1)),'-r*',x,abs(u(:,Nx/2+1)),'-bo');
