%kymatopaketo se armoniki pagida (me e3artisi apo ton z)

clc; clear all; format long;
N=2048; L=225; x=(L/N)*(-N/2:N/2-1); dx=x(2)-x(1);
k=(2*pi/L)*[0:N/2-1 -N/2:-1]; 
po=zeros(1,N); 

% Initial condition
uin = zeros(size(x));
Np=2;
d=10;
a=0.1;
mid_point = d / 2;
for i = 1:Np
    pulse = rectangularPulse(-a, a, x - (i-1)*d + mid_point);
    uin = uin + pulse;
end
figure(1); plot(x,abs(uin),'r');


% BPM
S=1000; zmax=20; h=zmax/S; z=0; count=0; dim=0; savestep=10; u0=uin; 
for m=1:S
u1=ifft(fft(u0).*exp(-1i*0.5*h*k.^2));   % First step of SSF
u2=exp(1i*h*po).*u1;                     % Second step of SSF
u3=ifft(fft(u2).*exp(-1i*0.5*h*k.^2));   % Second step of SSF
u0=u3; z=z+h; count=count+1; 
   if (count==savestep)
    dim=dim+1; field(dim,:)=u0; pot(dim,:)=po; z1(dim)=z; count=0;
   end
end; [X,Z]=meshgrid(x,z1);
figure(2); surf(X,Z,abs(field)); shading interp; view([0 90]); 
axis square; axis tight;
figure(3); surf(X,Z,pot); shading interp; view([0 90]); 
axis square; axis tight;

figure(4);
plot(x,abs(field(dim,:)))
figure(5);
plot(x,abs(field(dim,:)).^2)