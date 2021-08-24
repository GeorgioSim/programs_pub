function [ex,spread]=pulses(ks1,ks2,t,t0,ex,spread)
pulse=exp(-.5*((t-t0)/spread)^2);
ex(ks1)=pulse;
pulse2=exp(-.5*((t-t0)/spread)^2);
ex(ks2)=pulse2;
end