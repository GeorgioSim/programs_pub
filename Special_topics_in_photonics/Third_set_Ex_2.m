clear all; format long; clc;             % 2D-Helmholtz Equation
k=2*pi;
lambda = 2.*pi./k;
% Nx=256*1; Lx=30; x=(Lx/Nx)*(-Nx/2:Nx/2-1)'; dx=x(2)-x(1); % x-grid
% Ny=256*1; Ly=30; y=(Ly/Ny)*(-Ny/2:Ny/2-1)'; dy=y(2)-y(1); % y-grid
Nx=256*1; Lx=30.*pi.*lambda; x=(Lx/Nx)*(-Nx/2:Nx/2-1)'; dx=x(2)-x(1); % x-grid
Ny=Nx; Ly=Lx; y=(Ly/Ny)*(-Ny/2:Ny/2-1)'; dy=y(2)-y(1); % y-grid
kx=(2*pi/Lx)*[0:Nx/2-1 -Nx/2:-1]'; % kx-grid
ky=(2*pi/Ly)*[0:Ny/2-1 -Ny/2:-1]'; % ky-grid
[X,Y]=meshgrid(x,y); [KX,KY]=meshgrid(kx,ky);

w=40;  u00=exp(-(X/w).^8-(Y/w).^8); % Beam at z=0
kz = 6.2;
kr = sqrt(k.^2-kz.^2);
r = sqrt(X.^2 + Y.^2);
zz = kr.*r;
Bes = besselj(0,zz);
u0 = u00 .* Bes;

figure(1); surf(X,Y,abs(u0).^2); shading interp; view([0 90]);
axis square; axis tight;  % initial intensity at z=0
figure(2); surf(KX,KY,abs(fft2(u0))); shading interp; view([0 90]);
axis square; axis tight;  % Initial spectrum at z=0

S=100; zmax=lambda*50 ; z=linspace(0,zmax,S);
% S=100; zmax=10; z=linspace(0,zmax,S);

% Widths
[fwhm_u0, fwhmy_u0, w_numerical_u0] = calculate_beam_fwhm(u0,y);

w=fwhmy_u0;  gaussian=exp(-(X/w).^2-(Y/w).^2); % G.Beam at z=0

for m=1:S   % Solution of Helmholtz equation
    m
    u1=ifft2(fft2(u0).*exp(1i*z(m)*sqrt(k^2-KX.^2-KY.^2)));
    field(m,:,:)=u1;
    gaussian_1=ifft2(fft2(gaussian).*exp(1i*z(m)*sqrt(k^2-KX.^2-KY.^2)));
    field(m,:,:)=gaussian_1;
end
figure(3); surf(X,Y,abs(u1).^2); shading interp;  view([0 90]);
axis square; axis tight; % Final intensity at z=zmax
% figure(4); surf(KX,KY,abs(fft2(u1))); shading interp; view([0 90]);
% axis square; axis tight;  % Final spectrum at z=zmax

figure(7); surf(X,Y,abs(gaussian_1).^2); shading interp; view([0 90]);
axis square; axis tight; % Final intensity at z=zmax
% figure(8); surf(KX,KY,abs(fft2(gaussian_1))); shading interp; view([0 90]);
% axis square; axis tight;  % Final spectrum at z=zmax


figure(10); surf(X,Y,abs(gaussian).^2); shading interp; view([0 90]);
axis square; axis tight; % intensity at z=0
figure(11); surf(X,Y,abs(u0).^2); shading interp; view([0 90]);
axis square; axis tight; % intensity at z=0

% Note: Outside the +/- (2*pi) in the fourier spectrum, we have 
% evansecent waves. If the beam's width becomes compare to thewavelength
% (1 micron here) then you do have evanescent waves

function [fwhm, fwhmy, w_numerical] = calculate_beam_fwhm(u1,y)
            % Find the index of the maximum absolute value in u1
            [max_u1, max_u1_index] = max(abs(u1(:)));
            % Convert the index to row and column subscripts
            [max_u1_row, max_u1_col] = ind2sub(size(u1), max_u1_index);
            % Find the y-value corresponding to the maximum absolute value in u1
            u1_zR = u1(max_u1_col,:);  
%             % Find the x-value corresponding to the maximum absolute value in u1
%             u1_zR = u1(:,max_u1_col);  
            data = abs(u1_zR).^2;
             % Find the half max value.
            halfMax = (min(data) + max(data)) / 2;
            % Find where the data first drops below half the max.
            index1 = find(data >= halfMax, 1, 'first');
            % Find where the data last rises above half the max.
            index2 = find(data >= halfMax, 1, 'last');
            fwhm = index2-index1 + 1; % FWHM in indexes.
            % if you have an y vector
            fwhmy = y(index2) - y(index1);  
            w_numerical= fwhmy./sqrt(2*log(2)) ;
            figure; plot(y,data.^2); axis square;
end