clear all; format long; clc; % 2D Free space diffraction

% Physical constants
mu0 = 4.0e-7 * pi  ;  % free space magnetic permeability [Vs/Am]
c0  = 2.99792458e+8 ;    % free space light speed [m/s]
epsilon0 = 1.0 / (mu0 * c0.^2) ;        % free space permittivity [As/Vm]
eta0     = sqrt(mu0 / epsilon0) ;   % free space impedance [ohm]
n0_ = 1     ;   % refractive index of background    <---%%% EDIT HERE %%%
lambda0_ = 532e-9  ;    % free space wavelength [m]        <---%%% EDIT HERE %%%
% lambda0_ = 635e-9  ;    % free space wavelength [m]        <---%%% EDIT HERE %%%


% Derived parameters
k0_     = 2 * pi / lambda0_ ;      			% free space wavenumber [m-1]
k_      = n0_ * k0_        ;             % medium wavenumber [m-1]
lambda_ = lambda0_ / n0_    ;            % medium wavelength [m]

% Beam parameters
w0 = 5e-6; %in meters
k0 = k0_;
zR = pi*w0^2/lambda0_ % in meters

delta_   = 1;	   % normalization parameter (see documentation on SSF)

%  Computation domain discretization
% Changing Nz improves w_analytical, while changing Nx,Ny improves
% w_numerical
% Nz = 1e4 ;        % Number of steps in the z direction <---%%% EDIT HERE %%%
Nz = 500 ;        % Number of steps in the z direction <---%%% EDIT HERE %%%
Nx = 512 ;        % x-direction size of computational grid
Ny = Nx  ;        % x-direction size of computational grid. The computation domain is square

% Physical dimension of the computation space. Physical values are denoted with an underscore. The corresponding normalized value are written without underscore.
% We use SI units
Lx_ = 80e-6 ;    % width of the computation window [m]  <---%%% EDIT HERE %%%
Ly_ = Lx_	;	     % height of the computation window [m] <---%%% EDIT HERE %%%
% Lz_ = 100e-6 ;    % propagation distance [m]             <---%%% EDIT HERE %%%
Lz_ = zR ;    % propagation distance [m]             <---%%% EDIT HERE %%%
% Lz_ = zR*1e7;     % propagation distance [m]             <---%%% EDIT HERE %%%
% Lz_ = zR*1e1 ;    % propagation distance [m]             <---%%% EDIT HERE %%%

V = zeros([Ny, Nx]) ;   % Index potential. This correspond to the refractive index difference with respect to background
                          % for a homogeneous medium, V = 0. <---%%% EDIT HERE %%%

% Normalization coefficients
% The equation can be normalized to a dimensionless form
% spatial normalization factor in the x-y plane
spatial_transverse_scale = 1/(k0_ * sqrt(2 * n0_ *  delta_))
% spatial normalization factor in the z direction
spatial_longitudinal_scale = 1/(delta_ * k0_);

scale_ratio = spatial_longitudinal_scale/spatial_transverse_scale;  % = sqrt(2*n0_/delta_)

% .^.^.^.^.^.^* Normalized parameters .^.^.^.^.^.^*
Lx = Lx_ / spatial_transverse_scale  ;              % normalized model width
Ly = Ly_ / spatial_transverse_scale  ;              % normalized model height
Lz = Lz_ / spatial_longitudinal_scale ;             % normalized propagation distance
k  = 2*pi * spatial_transverse_scale / lambda_ ; % normalized light k-vector

% .^.^.^.^.^.^ Numeric model parameters .^.^.^.^.^*
dx_ = Lx_/Nx    ;                                                            % normalized discretization step in x
dx  = Lx/Nx    ;                                                             % discretization step in x
x_ = dx_ * (-Nx/2:Nx/2-1);      % x dimension vector
x   = dx  * (-Nx/2:Nx/2-1) ;          % normalized x dimension vector
dkx = 2*pi/Lx  ;                                                          % discretization in the spatial spectral domain along the y direction
kx = dkx * [0:(Nx/2-1), -Nx/2:-1]; % spatial frequencies vector in the x direction (swapped)

% We do the same in the y and z direction
dy_ = Ly_/Ny;                                                       % normalized discretization step in y
dy  = Ly/Ny;                                                        % discretization step in y
y_  = dy_ * (-Ny/2:Ny/2-1);                                          % y dimension vector
y   = dy  * (-Ny/2:Ny/2-1);                                          % normalized y dimension vector
dky = 2*pi/Ly;                                                       % discretization in the spatial spectral domain along the y direction
ky  = dky * [0:(Ny/2-1), -Ny/2:-1];                                    % spatial frequencies vector in the y direction

dz  = Lz/Nz;                                                         % discretization step in z
dz_ = Lz_/Nz;                                                        % normalized discretization step in z
z   = dz * (0:Nz-1);                                                 % z dimension vector
z_  = dz_ * (0:Nz-1);   % normalized z dimension vector
dkz = 2*pi/Lz;                                                       % discretization in the spatial spectral domain along the y direction
kz  = dkz * [0:(Nz/2-1), -Nz/2:-1];

% Here we create the spatial computation grid (physical and normalized)
[X_, Y_]    = meshgrid(x_, y_);
[Xz_, Z_]   = meshgrid(x_, z_);
[X, Y]      = meshgrid(x, y);
[Xz, Z]     = meshgrid(x, z);
% The same for the spatial frequencies domain
[KX, KY]    = meshgrid(kx, ky);

K2 = KX .* KX + KY .* KY;  % Here we define some variable so that we don't need to compute them again and again

% Variable that allows to switch between the paraxial (nonparaxial = 0) and nonparaxial (nonparaxial = 1) algorithm.
nonparaxial  = 0 ;  % <---%%% EDIT HERE %%%

% IF YOU WANT TO HAVE absorbing boundaries, set absorbing_boundary=1 below, 
% otherwise set it to 0.
absorbing_boundary = 0;
super_gaussian=exp(-((X_ / (0.9*Lx_/(2*sqrt(log(2)))) ).^20 + (Y_ / (0.9*Ly_/(2*sqrt(log(2)))) ).^20));

A = 1;       		 % field amplitude of the input beam

% Generate input field. Below, an example with Gaussian beam as the input
beam_fwhm_ = 14e-6    ;       % <---%%% EDIT HERE %%%
beam_scale_ = beam_fwhm_ / (2*sqrt(log(2)));
gaussian_beam = exp(-(X_/beam_scale_).^2 - (Y_/beam_scale_).^2);

% Generate angle of the input beam. We do it by multiplying the input field with a blazed grating
theta_x = 0 ;      % [degree] angle in x direction <---%%% EDIT HERE %%%
theta_y = 0  ;     % [degree] angle in y direction <---%%% EDIT HERE %%%
theta_x = theta_x*pi/180;
theta_y = theta_y*pi/180;
blazed_grating = exp(1i*2*pi/lambda_*(sin(theta_x)*X_+sin(theta_y)*Y_));

% circular aperture
circular_aperture = zeros(Nx, Ny);
aperture_diameter = 100e-6;             % [m] <---### EDIT HERE ###
circular_aperture((X_.^2 + Y_.^2) <= (aperture_diameter/2)^2) = 1;

% rectangular aperture
rectangular_aperture = zeros(Nx, Ny);
width_x = 200e-6;                       % [m] <---### EDIT HERE ###
width_y = 200e-6;                       % [m] <---### EDIT HERE ###
x_shift = 0e-6;                         % [m]<---### EDIT HERE ###
y_shift = 0e-6;                         % [m]<---### EDIT HERE ###
rectangular_aperture(abs(X_ - x_shift) <= width_x/2 & abs(Y_ - y_shift) <= width_y/2) = 1;

% u=gaussian_beam;
u=exp(-(X_/w0).^2-(Y_/w0).^2);

figure(1); surf(X,Y,abs(u)); shading interp; colormap(jet); view([-90 90]); 
axis tight; axis square;

zmax=ceil(max(z)); z=linspace(0,zmax,Nz); u0=u; %This is for the simulation

% Find z=zR closest value by indexing in our vector. Quite interesting,
% because z and z_ have the same number of elements. Thus, indexing is
% trully the way we need to capture the image, so here comes the function calculate_beam_widths

% zstop = zR*1e7;
zstop = zR;

% [minValue, closestIndex_2] = findClosestValue(zR, z_);
% [minValue, closestIndex_2] = findClosestValue(zstop, z_);
[minValue, closestIndex_2] = findClosestValue(z_, zstop);
stop_loops = false;

for m=1:Nz
 m
 u1=ifft2(fft2(u0).*exp(-1i*z_(m)*(KX.^2+KY.^2)));
%  u1=ifft2(fft2(u0).*exp(-1i*z(m)*(KX.^2+KY.^2)));
 field(m,:,:)=u1; 
 
 if (stop_loops)
     break;
 end
 if m==closestIndex_2
    [w_analytical, w_numerical] = calculate_beam_widths(u1, z_, w0, zR, y_, m)
    w0*sqrt(2)
    stop_loops = true;
 end

figure(3); surf(X,Y,abs(u1).^2); 
axis([-Lx./2 Lx./2 -Ly./2 Ly./2 0 1]);
% set(gca,'XTickLabel',{num2str(-window_size),num2str(-window_size./2),0,num2str(window_size./2),num2str(window_size)})
% set(gca,'YTickLabel',{num2str(-window_size),0,num2str(window_size)})
shading interp;  colormap(jet); axis square;  
 view([31 37]);
  %view([0 90]); 
 drawnow;
end
figure(4); surf(X,Y,abs(u1)); shading interp; colormap(jet); view([-90 90]); axis square; 
axis([-Lx./2 Lx./2 -Ly./2 Ly./2 0 1]);
% set(gca,'XTickLabel',{num2str(-Lx_),num2str(-Lx_./2),0,num2str(Lx_./2),num2str(Lx_)})
% set(gca,'YTickLabel',{num2str(-Ly_),num2str(-Ly_./2),0,num2str(Ly_./2),num2str(Ly_)})


function [minValue, closestIndex] = findClosestValue(referenceValues, vector)
    % Create a matrix where each row is a copy of 'vector'
    repeatedVector = repmat(vector, [length(referenceValues), 1]);
    % Create a matrix where each column is a copy of 'referenceValues'
    repeatedReference = repmat(referenceValues', [1, length(vector)]);
    % Calculate the absolute difference between 'repeatedVector' and 'repeatedReference'
    absoluteDiff = abs(repeatedVector - repeatedReference);
    % Find the index of the minimum value along each row
    [~, closestIndex] = min(absoluteDiff, [], 2);
    % Extract the minimum value from 'absoluteDiff' for each index
    minValue = absoluteDiff(sub2ind(size(absoluteDiff), (1:length(closestIndex))', closestIndex));
end

function [w_norm_analytical, w_norm_numerical] = calculate_beam_widths(u1, z, w0_norm, zR_norm, y, m)
    %     Analytical solution 
        w_norm_analytical = w0_norm*sqrt(1+(z(m)./zR_norm).^2);
        
    %     Numerical solution
        % Find the index of the maximum absolute value in u1
        [max_u1, max_u1_index] = max(abs(u1(:)));
        % Convert the index to row and column subscripts
        [max_u1_row, max_u1_col] = ind2sub(size(u1), max_u1_index);
        % Find the x-value corresponding to the maximum absolute value in u1
        u1_zR = u1(:,max_u1_col);  
        data = abs(u1_zR);
%         data = abs(u1_zR).^2;
             % Find the half max value.
            halfMax = (min(data) + max(data)) / 2;
            % Find where the data first drops below half the max.
            index1 = find(data >= halfMax, 1, 'first');
            % Find where the data last rises above half the max.
            index2 = find(data >= halfMax, 1, 'last');
            fwhm = index2-index1 + 1; % FWHM in indexes.
            % if you have an y vector
            fwhmy = y(index2) - y(index1);            
        w_norm_numerical= fwhmy./sqrt(2*log(2)) ;
       % Snapshot in plot y,abs(u1_zR).^2
%         figure(5); plot(y,data); axis square;
        figure(5); plot(y,data.^2); axis square;
end
