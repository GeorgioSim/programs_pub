%kymatopaketo se armoniki pagida (me e3artisi apo ton z)

clc; clear all; format long;
N=1024; L=120; x=(L/N)*(-N/2:N/2-1); dx=x(2)-x(1);
k=(2*pi/L)*[0:N/2-1 -N/2:-1];
g=0.2;
po = (25-(g.*x).^2).*exp(-(x./20).^8);
w=5; uin=exp(-(x/w).^2); % initial condition
figure(1); plot(x,abs(uin),'r',x,abs(po),'g');
legend('u_{in}','V(x)')

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

% Same amplitude after zs
figure(4);
plot(x,abs(field(40,:)),'b*') ;
hold on
plot(x,abs(field(1,:)),'g*');
legend('z=z_{s}','z=0')