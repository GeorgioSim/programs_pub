function  [A,epss,epsinf,eps0,mu0,delta,omega_0, nsteps, dt,dx,c0, cc, freq, t0,spread]=Material_and_pulse

%%Material

%Nonlinear coefficient
% A=0.01;
A=1e-8;
% A=0;
%eps0 einai to epsilon sto keno
eps0=8.8e-12;
mu0=4*pi*1e-7;

% epsz=1;
epsinf=1.5;

%2nd material

%omega_0 for dispersion
% omega_0=1e12;
omega_0=2.*pi.*20.*1e9;
epss=3;

%delta syxnotita krousis gia to dispersion 

% delta=2e11;
% delta=0.25;
delta=0.1.*omega_0;

%plotting epsilon_r
omega_max=5.*pi.*20.*1e9;
omega=linspace(0,omega_max,26000);
epsilon_r = epsinf + (epss-epsinf)*omega_0.^2./(omega_0.^2 - 2*1i*omega*delta - omega.^2);


%%Pulse

% Number of time steps
nsteps=1500;
%N number of circles (doesn't have to work, just let N=1)
N=1;

% Gaussian pulse

%Frequency is connected with t0: 2*pi*freq*t0=2*pi*N
% omega_f=1.5e12;
% omega_f=1e8;
omega_f=2.*pi.*20.*1e9;
freq=omega_f/(2*pi);
freq=2e10;

% t0=1e-7;
% t0=2*10/omega_f;
%I define spread 5 times less than t0
% spread=t0/5;
% spread=t0/5/7;
% spread=1e-7/5;

spread=3.183099e-11;
t0=1.591549e-10;

% FFT
[fdiff,fshift,yshift,yf]=hifftmethod(t0,spread,nsteps,freq);
fmax=fdiff*freq;
% fmax=2*freq;

%Cell size and time stepping
c0=3.e8;
lambdamin=c0/fmax;
dx=lambdamin/10;
dt=dx/(2.*c0);
%Constants
cc=c0*dt/dx;
dx
dt

% Kanonika prepei dt na meiwthei wste dt/tau<0.1 ara prepei na ay3isw to fmax, dhladh prepei na valw
% freq megalytero, kata toulaxiston fmax/fdiff=
% 1/(2*10*dt*fdiff)=0.05/(dt*fdiff)~1e-3/dt > 1e-3*10/tau = 1e-2 / tau.

% if (dt > tau*0.1) && (freq < 1e-2/tau=0.01*delta)
%     freq_minimum = 2*1e-2/tau;  
%     freq=freq_minimum;
% end

if (dt > 0.1/delta) && (freq < 1e-2*delta)
    disp('Mistakes were made: Change frequency so as to carry out accurately the simulation');
end  

figure;
title('Combine Plots')
plot (omega, real(epsilon_r));
hold on
plot (omega, (imag(epsilon_r)));
xlabel('\omega');
ylabel('\epsilon(\omega)');
plot(fshift*2*pi,abs(yshift));

% Plot X axis along y=0.
line(xlim(), [0,0], 'LineWidth', 0.1, 'Color', 'k');
grid on;

legend('\epsilon_{real}', '\epsilon_{imag}', 'FFT pulse');     % label them -- colors show automagically
% title(['N= ',num2str(N)]);
axis([0 omega_max -5 5]);
% axis([0 omega_max -ceil(abs(max(yshift))) ceil(abs(max(yshift)))]);
% %axis([0 abs(fshift(yf+1)) -ceil(abs(max(yshift))) ceil(abs(max(yshift)))]);   %used for testing of hifftmethod    
hold off

%Packet all output
% [tau_air, chi1_air, epss_air, epsz, epsinf, tau, chi1, epss, nsteps, dt, cc, freq, N, t0,spread]=Material_and_pulse

end