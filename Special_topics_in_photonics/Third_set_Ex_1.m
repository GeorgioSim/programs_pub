clear all; format long; clc; % 1D-Helmholtz Equation
N=1024; L=80; x=(L/N)*(-N/2:N/2-1)';     % x-grid
kx=(2*pi/L)*[0:N/2-1 -N/2:-1]';
k=2.2*pi;  % kx-grid
% w=0.5;
w=2;
u0=exp(-(x/w).^2); % initial condition at z=0

S=100; zmax=20; z=linspace(0,zmax,S);  
for m=1:S  % Solution of Helmholtz equation
    u1=ifft(fft(u0).*exp(1i*z(m)*sqrt(k^2-kx.^2)));
    field(m,:)=u1;
end; 
[X,Z]=meshgrid(x,z);
figure(1); surf(X,Z,abs(field).^2); shading interp; view([0 90]);
axis square; axis tight;

figure(2); plot(x,abs(u0),'-*b',x,abs(u1),'-or'); 
% Beam's intensity at input and output

figure(3); plot(kx,abs(fft(u0)),'-*b',kx,abs(fft(u1)),'-or');
% Fourier spectra at input and output

% Note: Outside the +/- (kx = 2*pi) in the fourier spectrum, we have 
% evansecent waves. If the beam's width becomes compare to the wavelength
% (1 micron here) then you do have evanescent waves