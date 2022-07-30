function dx=fdot2d(x,t);

global e A

x1=x(1);x2=x(2);
dx=zeros(2,1);

dx(1)=x2;
dx(2)=-x1-e*x2*(x1^2-1);
