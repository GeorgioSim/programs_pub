clear all; format long; clc; % 1D-Helmholtz Equation
N=1024; L=80; x=(L/N)*(-N/2:N/2-1)';     % x-grid
kx=(2*pi/L)*[0:N/2-1 -N/2:-1]'; k=2*pi;  % kx-grid
% w=0.5;
w=2;
u0=exp(-(x/w).^2); % initial condition at z=0
% [~,u0_max_index] = findClosestValue(max(u0), u0);
% u0 = u0';

S=1000; zmax=5; z=linspace(0,zmax,S);  dz = z(2)-z(1);
for m=1:S  % Solution of Helmholtz equation
    m
    u1=ifft(fft(u0).*exp(1i*z(m)*sqrt(-kx.^2+k.^2)));
%     u2(m)=u1(513);
    u2=ifft(fft(u0).*exp(1i*z(m)*sqrt(-(2.2*pi).^2+k.^2)));
    field(m,:)=u1;
    field2(m,:)=u2;
end
[X,Z]=meshgrid(x,z);
figure(1); surf(X,Z,abs(field).^2); shading interp; view([0 90]);
axis square; axis tight;

figure(2); plot(x,abs(u0),'-*b',x,abs(u1),'-or'); 
% Beam's intensity at input and output

figure(3); plot(k,abs(fft(u0)),'-*b',k,abs(fft(u1)),'-or');
% Fourier spectra at input and output

% Note: Outside the +/- (kx = 2*pi) in the fourier spectrum, we have 
% evansecent waves. If the beam's width becomes compare to the wavelength
% (1 micron here) then you do have evanescent waves

% Numerical
        [max_unum, max_unum_index] = max(abs(field2(:)));
        [max_unum_row, max_unum_col] = ind2sub(size(field2), max_unum_index);
        unum = field2(:,max_unum_col); 
      
U1 = abs(unum(length(unum)));
U2 = abs(unum(length(unum)-1));

U_dot = (U1-U2)./dz;
gamma_analytical = -U_dot./U1

% ANALYTICAL

gamma = sqrt((2.2.*pi).^2-k.^2)

Uanalytical=exp(1i*2.2.*X).*exp(-gamma.*Z);
        [max_u, max_u_index] = max(abs(Uanalytical(:)));
        [max_u_row, max_u_col] = ind2sub(size(Uanalytical), max_u_index);
        u = Uanalytical(:,max_u_col);  

figure(5); plot(z,abs(u),'-*b',z,abs(unum),'-or');
xlabel('z')
ylabel('U_{evanescent}')
