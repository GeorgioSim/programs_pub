clear all; clc; format long; %2022-BPM based on Fresnel integral
Nx=1024; Lx=2*pi*20; x=(Lx/Nx)*(-Nx/2:Nx/2-1)'; dx=x(2)-x(1);
kx=(2*pi/Lx)*[0:Nx/2-1 -Nx/2:-1]'; 
tic 
u=exp(-(x./3).^8); uin=u; S=100; zmax=10; z=linspace(0.1,zmax,S); 

% FFT-BPM
u0=u;
for m=1:S
 u1=ifft(fft(u0).*exp(-1i*z(m)*kx.^2));
 field(m,:)=u1; 
end

% Fresnel integral
for m=1:S
    z1=z(m);
    for tr=1:Nx
      field_2(tr,m)=exp(1i*pi/4)/(2*1i*sqrt(pi*z1))*...
      sum(u.*exp(1i*(x(tr)-x).^2/(4*z1)))*dx;
    end
end

[X,Z]=meshgrid(x,z);
figure(1); surf(X',Z',abs(field_2).^2); shading interp; view([0 90]); 
axis tight; axis square;
figure(2); surf(X',Z',angle(field_2)); shading interp; view([0 90]); 
axis tight; axis square;

I_onaxis=abs(field_2(Nx/2+1,:)); % on-axis Intensity of the field
figure(32); plot(z,I_onaxis,'-b*'); hold on;

% FFT-BPM
figure(3); surf(X,Z,abs(field).^2); shading interp; view([0 90]); 
axis tight; axis square;
figure(4); surf(X,Z,angle(field)); shading interp; view([0 90]); 
axis tight; axis square;

I_onaxis=abs(field(:,Nx/2+1)); % on-axis Intensity of the field
figure(35); plot(z,I_onaxis,'-b*'); hold on;

toc