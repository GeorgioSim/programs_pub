clc; clear all; format long;
N=1024*2; L=200; x=(L/N)*(-N/2:N/2-1); dx=x(2)-x(1);
k=(2*pi/L)*[0:N/2-1 -N/2:-1];  w=3; uin=exp(-(x/w).^2); 

S=1000; zmax=25; z=0; zz=linspace(0,zmax,S); h=zz(2)-zz(1);
count=0; dim=0; savestep=10; u0=uin; 
% Definition of the transmittance function of a thin lens
pot=zeros(S,N); F=h*200
zfin=200; 
pot(2*zfin,:)=-(1/h)*x.^2/(4*F);

[X,ZZ]=meshgrid(x,zz);
figure(1); surf(X,ZZ,abs(pot)); shading interp; view([0 90]); 
axis square; axis tight;

for m=1:S
    po=pot(m,:);
u1=ifft(fft(u0).*exp(-1i*0.5*h*k.^2));   % First step of SSF
u2=exp(1i*h*po).*u1;                     % Second step of SSF
u3=ifft(fft(u2).*exp(-1i*0.5*h*k.^2));   % Second step of SSF
u0=u3; z=z+h; count=count+1; 
if (count==savestep) dim=dim+1; field(dim,:)=u0; z1(dim)=z; count=0; end
end
[X,Z]=meshgrid(x,z1);
figure(2); surf(X,Z,abs(field)); shading interp; view([0 90]); 
axis square; axis tight;
figure(3); plot(x,abs(uin),'-*b',x,abs(field(80,:)),'-or');
legend('u_{in}','u_{out}')
% figure(3); plot(x,abs(uin),'-*b',x,abs(field(dim,:)),'-or');