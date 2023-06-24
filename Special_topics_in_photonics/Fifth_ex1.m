%kymatopaketo se armoniki pagida (xwris e3artisi apo ton z)

clc; clear all; format long; % One-Dimensioanl SSF-BPM
N=1024; L=120; x=(L/N)*(-N/2:N/2-1); dx=x(2)-x(1);
k=(2*pi/L)*[0:N/2-1 -N/2:-1]; 

po=zeros(1,N); 
d=1;
w=10; u=exp(-(x/w).^2); % initial condition

% In media:

v=fft(u); S=1000; zmax=20; h=zmax/S; z=0;
count=0; dim=0; savestep=10; u0=u;
for m=1:S   
   if (z >= 5) && (z <= 6)
       po=d*ones(1,N);
   elseif (z<5) || (z>6)  
       po=zeros(1,N);  
   end
    u1=ifft(fft(u0).*exp(-1i*0.5*h*k.^2));   % First step of SSF
    u2=exp(1i*h*po).*u1;                     % Second step of SSF
    u3=ifft(fft(u2).*exp(-1i*0.5*h*k.^2));   % Third step of SSF
    u0=u3; z=z+h; count=count+1; 
    if (count==savestep)
        dim=dim+1; field(dim,:)=u0; z1(dim)=z; count=0;
    end
end


% In free space: 
po=zeros(1,N); 
d=1;
w=10; u=exp(-(x/w).^2); % initial condition

v=fft(u); S=1000; zmax=20; h=zmax/S; z=0;
count=0; dim=0; savestep=10; u0=u;
for m=1:S   

       po=zeros(1,N);  

    u1=ifft(fft(u0).*exp(-1i*0.5*h*k.^2));   % First step of SSF
    u2=exp(1i*h*po).*u1;                     % Second step of SSF
    u3=ifft(fft(u2).*exp(-1i*0.5*h*k.^2));   % Third step of SSF
    u0=u3; z=z+h; count=count+1; 
    if (count==savestep)
        dim=dim+1; field2(dim,:)=u0; z1(dim)=z; count=0;
    end
end

[X,Z]=meshgrid(x,z1);

figure(2); surf(X,Z,abs(field)); shading interp; view([0 90]); 
figure(3); surf(X,Z,angle(field)); shading interp; view([0 90]);
figure(4); surf(X,Z,angle(field2)); shading interp; view([0 90]);
% axis square; axis tight;