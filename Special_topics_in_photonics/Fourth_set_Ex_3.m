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
    for tr=1:Nx
      field(tr,m)=exp(1i*k*z1)/sqrt(1i*lambda*z1)*...
      sum(u.*exp(1i*k*(x(tr)-x).^2/(2*z1)))*dx;
    end

      Pa=(d./2-x).*sqrt(2./(lambda.*z1));
      Pb=-(d./2+x).*sqrt(2./(lambda.*z1));
      U_analytical(:,m) = exp(1i.*k.*z1)./sqrt(2*1i).*(fresnelc(Pa)-fresnelc(Pb)+1i*fresnels(Pa)-1i*fresnels(Pb));
end

[X,Z]=meshgrid(x,z);
figure(1); surf(X',Z',abs(field).^2); shading interp; view([0 90]); 
axis tight; axis square;
figure(2); surf(X',Z',unwrap(angle(field))); shading interp; view([0 90]); 
axis tight; axis square;
figure(30); plot(x,abs(field(:,S)),'-b*'); hold on;
figure(31); plot(x,unwrap(angle(field(:,S))),'-b*'); hold on;

I_onaxis=abs(field(Nx/2+1,:)); % on-axis Intensity of the field
figure(32); plot(z,I_onaxis,'-b*'); hold on;


% % Analytical result
% Pa=(d./2-Z).*sqrt(2./(lambda.*Z));
% Pb=-(d./2+X).*sqrt(2./(lambda.*Z));
% U_analytical = exp(1i.*k.*Z)/sqrt(2i).*(fresnelc(Pa)-fresnelc(Pb)+1i*fresnels(Pa)-1i*fresnels(Pb));

figure(33); surf(X,Z,abs(U_analytical').^2); shading interp; view([0 90]); 

toc