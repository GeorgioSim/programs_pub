clear all; format long; clc; % 1D-Helmholtz Equation
N=1024; L=80; x=(L/N)*(-N/2:N/2-1)';     % x-grid
kx=(2*pi/L)*[0:N/2-1 -N/2:-1]';
k=2.2*pi;  % kx-grid
% w=0.5;
w=2;
u0=exp(-(x/w).^2)'; % initial condition at z=0
[~,u0_max_index] = findClosestValue(max(u0), u0);
u0 = u0';

S=100; zmax=20; z=linspace(0,zmax,S);  dz = z(2)-z(1);
for m=1:S  % Solution of Helmholtz equation
    u1=ifft(fft(u0).*exp(1i*z(m)*sqrt(k^2-kx.^2)));
    field(m,:)=u1;
    if m == S-1
        u2=u1;
    end
end
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

% Find gamma by expression gamma=-U'/U at z=zmax

U1 = abs(u1(u0_max_index));
U2 = abs(u2(u0_max_index));

U_dot = (U1-U2)./dz;
gamma = -U_dot./U1

gamma_analytical = -1i.*sqrt(k.^2-kx(u0_max_index)^2)


function [minValue,closestIndex] = findClosestValue(referenceValues, vector)
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