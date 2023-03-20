% Simopoulos Giorgos AM:735


% Problem 1

clc; clear all; format long; % 1D-FFT Spectra calculation
N=256; L=60; x=(L/N)*(-N/2:N/2-1); dx=x(2)-x(1); % x-grid 
k=(2*pi/L)*[0:N/2-1 0 -N/2+1:-1]; dk=k(3)-k(2); % k-grid 

a=2; f=exp(-a*abs(x));   % function
fou_num=fft(f)*dx;     % FFt of the given function
fou_ana=2*a./(a.^2+k.^2);  % Analytical Result

figure(1); plot(x,f,'-r'); grid on; xlabel('x'); ylabel('f(x)=e^{-a|x|}'); legend('f(x)');
figure(2); plot(k,abs(fou_num),'-b*'); grid on; xlabel('k'); ylabel('F(k)'); legend('F_{num}');
figure(3); plot(k,abs(fou_num),'-b*',k,abs(fou_ana),'-ro'); grid on; xlabel('k'); ylabel('F(k)'); legend('F_{num}','F_{ana}')

figure(5); plot(k,abs(fou_num)-abs(fou_ana),'b*'); grid on; xlabel('k'); ylabel('|F_{num}|-|F_{ana}|');



% Problem 2

%1D
clc; clear all; format long; % 1D-FFT Spectra calculation
N=256; L=60; x=(L/N)*(-N/2:N/2-1); dx=x(2)-x(1); % x-grid 
k=(2*pi/L)*[0:N/2-1 0 -N/2+1:-1]; dk=k(3)-k(2); % k-grid 

a=1; f=exp(-a*x.^2);   % given gaussian function
fou_num=fft(f)*dx;     % FFt of the given gaussian function
fou_ana=sqrt(pi/a)*exp(-k.^2/(4*a));  % Analytical Result

figure(1); plot(x,f,'-r'); grid on; xlabel('x'); ylabel('f(x)=exp(-a*x.^2)'); legend('f(x)');
figure(2); plot(k,abs(fou_num),'-b*'); grid on; xlabel('k'); ylabel('F(k)'); legend('F_{num}');
figure(3); plot(k,abs(fou_num),'-b*',k,abs(fou_ana),'-ro'); grid on; xlabel('k'); ylabel('F(k)'); legend('F_{num}','F_{ana}')

figure(5); plot(k,abs(fou_num)-abs(fou_ana),'b*'); grid on; xlabel('k'); ylabel('|F_{num}|-|F_{ana}|');

%2D
clear all; format long; clc; % 2D-FFT Spectra calculation
Nx=256; Lx=50; x=(Lx/Nx)*(-Nx/2:Nx/2-1)'; dx=x(2)-x(1);
Ny=256; Ly=50; y=(Ly/Ny)*(-Ny/2:Ny/2-1)'; dy=y(2)-y(1);
kx=(2*pi/Lx)*[0:Nx/2-1 -Nx/2:-1]'; ky=(2*pi/Ly)*[0:Ny/2-1 -Ny/2:-1]'; 
[X,Y]=meshgrid(x,y); [KX,KY]=meshgrid(kx,ky);

% w=3; aa=0;  % 2D Gaussian 
% u=exp(-((X+0)/w).^2-((Y+0)/w).^2).*exp(1i*1*(Y+aa)+1i*0*(X-aa));

a=1; u=exp(-a.*(X.^2+Y.^2)); %2D given gaussian function
figure(6); surf(X,Y,abs(u)); shading interp; view([-90 90]); xlabel('x'); ylabel('y'); zlabel('f(x)=e^{-a(x^{2}+y^{2})}'); legend('f(x)');
axis tight; axis square;

fou_num=fft2(u)*dx*dy;  % 2D-FFT of the Gaussian function
fou_ana=pi/a*exp(-(KX.^2+KY.^2)/(4*a));  % Analytical Result
figure(7); surf(KX,KY,abs(fou_num)); xlabel('k_{x}'); ylabel('k_{y}'); zlabel('F(k_{x},k_{y})'); legend('F_{num}');%surf(fftshift(abs(fou_num)));
shading interp; view([-90 90]); 

axis tight; axis square;

figure(8); surf(KX,KY,abs(fou_ana)); xlabel('k_{x}'); ylabel('k_{y}'); zlabel('F(k_{x},k_{y})'); legend('F_{ana}'); %surf(fftshift(abs(fou_num)));

shading interp; view([-90 90]); 

axis tight; axis square;

figure(10); surf(KX,KY,abs(fou_num)-abs(fou_ana)); xlabel('k_{x}'); ylabel('k_{y}'); zlabel('F(k_{x},k_{y})'); legend('|F_{num}|-|F_{ana}|'); grid on;

% Problem 3

%1D
clc; clear all; format long; % 1D-FFT Spectra calculation
N=256; L=60; x=(L/N)*(-N/2:N/2-1); dx=x(2)-x(1); % x-grid 
k=(2*pi/L)*[0:N/2-1 0 -N/2+1:-1]; dk=k(3)-k(2); % k-grid 

a=1; f=rectangularPulse(-a,a,x);   % given function
fou_num=fft(f)*dx;     % FFt of the given function
fou_ana=2.*a.* sinc(k.*a./pi);  % Analytical Result

figure(1); plot(x,f,'-r'); grid on; xlabel('x'); ylabel('f(x)=rectangularPulse'); legend('f(x)'); xlim([-10 10])
figure(2); plot(k,abs(fou_num),'-b*'); grid on; xlabel('k'); ylabel('F(k)'); legend('F_{num}');
figure(3); plot(k,abs(fou_num),'-b*',k,abs(fou_ana),'-ro'); grid on; xlabel('k'); ylabel('F(k)'); legend('F_{num}','F_{ana}')

figure(5); plot(k,abs(fou_num)-abs(fou_ana),'b*'); grid on; xlabel('k'); ylabel('|F_{num}|-|F_{ana}|');


%2D
clear all; format long; clc; % 2D-FFT Spectra calculation
Nx=256; Lx=50; x=(Lx/Nx)*(-Nx/2:Nx/2-1)'; dx=x(2)-x(1);
Ny=256; Ly=50; y=(Ly/Ny)*(-Ny/2:Ny/2-1)'; dy=y(2)-y(1);
kx=(2*pi/Lx)*[0:Nx/2-1 -Nx/2:-1]'; ky=(2*pi/Ly)*[0:Ny/2-1 -Ny/2:-1]'; 
[X,Y]=meshgrid(x,y); [KX,KY]=meshgrid(kx,ky);


a=1; u=rectangularPulse(-a, a, X).*rectangularPulse(-a, a, Y);
figure(6); surf(X,Y,abs(u)); shading interp; view([-90 90]); 
axis tight; axis square;

fou_num=fft2(u)*dx*dy;  % 2D-FFT of the rectanglular function
fou_ana=4.*a.^2.* sinc(KX.*a./pi).* sinc(KY.*a./pi);  % Analytical Result
figure(7); surf(KX,KY,abs(fou_num)); xlabel('k_{x}'); ylabel('k_{y}'); zlabel('F(k_{x},k_{y})'); legend('F_{num}');%surf(fftshift(abs(fou_num)));
shading interp; view([-90 90]);
axis tight; axis square;

figure(8); surf(KX,KY,abs(fou_ana)); xlabel('k_{x}'); ylabel('k_{y}'); zlabel('F(k_{x},k_{y})'); legend('F_{ana}'); %surf(fftshift(abs(fou_num)));

shading interp; view([-90 90]); 

axis tight; axis square;

figure(10); surf(KX,KY,abs(fou_num)-abs(fou_ana)); xlabel('k_{x}'); ylabel('k_{y}'); zlabel('F(k_{x},k_{y})'); legend('|F_{num}|-|F_{ana}|'); grid on;

