clear all; clc; format long; %2022-BPM based on Fresnel integral
Nx=256; L=60; x=(L/Nx)*(-Nx/2:Nx/2-1); dx=x(2)-x(1); 
tic 

a=2; u=rectangularPulse(-a,a,x);   % given function
uin=u; S=100; zmax=10; z=linspace(0.1,zmax,S); 

for m=1:S
    z1=z(m);
    for tr=1:Nx
      field(tr,m)=exp(1i*pi/4)/(2*1i*sqrt(pi*z1))*...
      sum(u.*exp(1i*(x(tr)-x).^2/(4*z1)))*dx;
    end
end

[X,Z]=meshgrid(x,z);
figure(1); surf(X',Z',abs(field).^2); shading interp; view([0 90]); 
axis tight; axis square;
figure(2); surf(X',Z',angle(field)); shading interp; view([0 90]); 
axis tight; axis square;
figure(30); plot(x,abs(field(:,S)),'-b*'); hold on;
figure(31); plot(x,angle(field(:,S)),'-b*'); hold on;

I_onaxis=abs(field(Nx/2+1,:)); % on-axis Intensity of the field
figure(32); plot(z,I_onaxis,'-b*'); hold on;

toc