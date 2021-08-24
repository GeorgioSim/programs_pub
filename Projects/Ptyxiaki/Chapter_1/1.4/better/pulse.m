function [ex,spread]=pulse(ks,t,t0,ex,spread)
% Source
pulsar=exp(-.5*((t-t0)/spread)^2);
ex(ks)=ex(ks)+pulsar;
end