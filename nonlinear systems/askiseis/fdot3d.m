function dx=fdot3d(x,t)
global sigma b r e on

rt=r+e*sin(on*t);

x1=x(1);x2=x(2);x3=x(3);
dx=zeros(3,1);
dx(1)=sigma*(x2-x1);
dx(2)=rt*x1-x2-x1.*x3;
dx(3)=-b*x3+x1.*x2;