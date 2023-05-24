clear all; clc; format long; %2022-BPM based on Fresnel integral
Nx=256; L=60; x=(L/Nx)*(-Nx/2:Nx/2-1); dx=x(2)-x(1); 
tic 

a=2; u=rectangularPulse(-a,a,x);   % given function
uin=u; S=100; zmax=10; z=linspace(0.1,zmax,S);
lambda = 4;
k = 2*pi./lambda;
d=2*a;

for m=1:S
      z1=z(m);  
% kx = (k.*[0:Nx/2-1 -Nx/2:-1].*x)./z1;  % kx-grid

%     Fresnel
    for tr=1:Nx
      field(tr,m)=exp(1i*k*z1)/sqrt(1i*lambda*z1)*...
      sum(u.*exp(1i*k*(x(tr)-x).^2/(2*z1)))*dx;
    end
%    Fraunhofer
    field2(:,m) = sqrt(lambda*z1)*exp(1i*pi./4).*(exp(1i*k./(2.*z1)*x.^2))./(1i*pi*x).*sin(pi*x./lambda./z1.*d);
%       field2(:,m)= exp(1i*k.*x.^2./(2.*z1))./(1i*lambda*z1).*...
%           fft(u);
end

[X,Z]=meshgrid(x,z);
figure(1); surf(X',Z',abs(field).^2); shading interp; view([0 90]); 
axis tight; axis square;
figure(2); surf(X',Z',unwrap(angle(field))); shading interp; view([0 90]); 
axis tight; axis square;
figure(3); surf(X',Z',abs(field2).^2); shading interp; view([0 90]); 
axis tight; axis square;
figure(4); surf(X',Z',unwrap(angle(field2))); shading interp; view([0 90]); 
axis tight; axis square;

toc