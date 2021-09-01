function wavepacket=pulse(n,t0,dt,freq_in,spread)
% Source
%exp(-.5*((n-t0)/spread).^2)
wavepacket=exp(-.5*((n-t0)/spread).^2)*sin(2*pi*freq_in*dt*n);
end