

clear all

Tp=2*pi;

Nt=1000;
tt=linspace(0,Tp,Nt);
dt=tt(2)-tt(1);
ZZ=[0];
chi=2;
R=1;

% gia teliki katastasi!!!!

for iz=1:length(ZZ)

z(1)=ZZ(iz);

for it=2:Nt
    
    dzdt=chi-z(it-1)./R-exp(-z(it-1));
   z(it)=z(it-1)+dt*dzdt;
   x(it)=exp(-z(it));
y(it)=2-z(it)-x(it);
%     
%     k1=dxdt;
%     k2=xdot(x(it-1)+dt*k1/2,tt(it-1)+dt/2);
%     k3=xdot(x(it-1)+dt*k2/2,tt(it-1)+dt/2);
%     k4=xdot(x(it-1)+dt*k3,tt(it-1)+dt);
%     x(it)=x(it-1)+dt/6*(k1+2*k2+2*k3+k4);
    
end

% figure(65);hold on
% plot(tt,x,'b','Linewidth',2)
% xlabel('$t$','Interpreter','latex')
% ylabel('$x$','Interpreter','latex')
% set(gca,'Fontsize',20)
% drawnow

end
% P=z(it)*ones(length(tt),1);
P=z;
% figure(49);
% plot(tt,x,'b',tt,0*tt,'k','Linewidth',2)
% xlabel('$t$','Interpreter','latex')
% ylabel('$$','Interpreter','latex')
% set(gca,'Fontsize',20)
% drawnow


figure(50);
plot(tt,P,'b',tt,x,'g',tt,y,'r','Linewidth',2)
xlabel('$t$','Interpreter','latex')
ylabel('$z(t)$','Interpreter','latex')
set(gca,'Fontsize',20)
drawnow




    
    

    




