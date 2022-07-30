clear all
global e
e=-0.5;

Tp=20*pi;
Nt=100000;
tt=linspace(0,Tp,Nt);
dt=tt(2)-tt(1);
dt=-dt;
xa=0.5;
xb=5;   
XX=[xa,xb];
F_xyz = @(x,y,z) y;                                  % change the function as you desire
G_xyz = @(x,y,z) -x+e*z;
    
for ix=1:length(XX)

x(1)=XX(ix);
x2(1)=0;

for it=2:Nt
    
    dxdt=F_xyz(x(it-1),x2(it-1),tt(it-1));
    dxdt2=G_xyz(x(it-1),x2(it-1),tt(it-1));
%    x(it)=x(it-1)+dt*dxdt;
%     
    k1=dxdt;
    l1=dxdt2;
    k2=F_xyz(x(it-1)+dt*k1/2,x2(it-1)+dt*k1/2,tt(it-1)+dt/2);
    l2=G_xyz(x(it-1)+dt*l1/2,x2(it-1)+dt*l1/2,tt(it-1)+dt/2);
    k3=F_xyz(x(it-1)+dt*k2/2,x2(it-1)+dt*k2/2,tt(it-1)+dt/2);  
    l3=G_xyz(x(it-1)+dt*k2/2,x2(it-1)+dt*l2/2,tt(it-1)+dt/2);
    k4=F_xyz(x(it-1)+dt*k3,x2(it-1)+dt*k3,tt(it-1)+dt);
    l4=G_xyz(x(it-1)+dt*k3,x2(it-1)+dt*l3,tt(it-1)+dt);
    x(it)=x(it-1)+dt/6*(k1+2*k2+2*k3+k4);
    x2(it)=x2(it-1)+dt/6*(l1+2*l2+2*l3+l4);
    
end

hold on
figure(50);
plot(x,x2,'b')
xlabel('$x$','Interpreter','latex')
ylabel('$y=\dot{x}$','Interpreter','latex')
set(gca,'Fontsize',20)
drawnow

end








    




