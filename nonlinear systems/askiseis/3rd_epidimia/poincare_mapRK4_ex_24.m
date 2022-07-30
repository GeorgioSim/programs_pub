

clear all
global a

a=0;

Tp=2*pi;

Nt=100;
tt=linspace(0,Tp,Nt);
dt=tt(2)-tt(1);
dt=-dt;
xa=0;
xb=5; 
% XX=linspace(xa,xb,201);
XX=[0 0.5 5];
% XX=[0 0.5];


for ix=1:length(XX)

x(1)=XX(ix);
x2(1)=XX(ix);

for it=2:Nt
    
    dxdt=xdot(x(it-1),tt(it-1));
%    x(it)=x(it-1)+dt*dxdt;
%     
    k1=dxdt;
    k2=xdot(x(it-1)+dt*k1/2,tt(it-1)+dt/2);
    k3=xdot(x(it-1)+dt*k2/2,tt(it-1)+dt/2);
    k4=xdot(x(it-1)+dt*k3,tt(it-1)+dt);
    x(it)=x(it-1)+dt/6*(k1+2*k2+2*k3+k4);
    
end

for it=2:Nt
    
    dxdt=xdot2(x(it-1),x2(it-1),tt(it-1));
%    x(it)=x(it-1)+dt*dxdt;
%     
    k1=dxdt;
    k2=xdot2(x(it-1)+dt*k1/2,x2(it-1)+dt*k1/2,tt(it-1)+dt/2);
    k3=xdot2(x(it-1)+dt*k2/2,x2(it-1)+dt*k2/2,tt(it-1)+dt/2);
    k4=xdot2(x(it-1)+dt*k3,x2(it-1)+dt*k3,tt(it-1)+dt);
    x2(it)=x2(it-1)+dt/6*(k1+2*k2+2*k3+k4);
    
end

P(ix)=x2(Nt);

% figure(65);hold on
% plot(tt,x,'b','Linewidth',2)
% xlabel('$t$','Interpreter','latex')
% ylabel('$x$','Interpreter','latex')
% set(gca,'Fontsize',20)
% drawnow

end

% figure(49);
% plot(tt,x,'b',tt,0*tt,'k','Linewidth',2)
% xlabel('$t$','Interpreter','latex')
% ylabel('$$','Interpreter','latex')
% set(gca,'Fontsize',20)
% drawnow


figure(50);
plot(XX,P,'b',XX,XX,'k','Linewidth',2)
xlabel('$X$','Interpreter','latex')
ylabel('$P(X)$','Interpreter','latex')
set(gca,'Fontsize',20)
drawnow




    
    

    




