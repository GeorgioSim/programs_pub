%Gompertz

clear all

%x0=0.1;
x0=input('X0 = ? ')

% t=linspace(0,10,101);
% 
% xan=exp(log(x0)*exp(-t));
% 
% figure(10)
% plot(t,xan,'r','Linewidth',2)
% xlabel('$t$','Interpreter','latex')
% ylabel('$x(t)$','Interpreter','latex')
% set(gca,'Fontsize',18)
% hold on

x0=1;
dt=2.5;
x(1)=x0;
Tf=10000;
Nt=ceil(Tf/dt)+1;
tt(1)=0;
xan(1)=x0;

for it=2:Nt
    
    tt(it)=(it-1)*dt;
    v=-x(it-1)*log(x(it-1));
    x(it)=x(it-1)+v*dt;
    xan(it)=exp(log(x0)*exp(-tt(it)));
%     figure(10)
%     plot(tt(1:it),xan(1:it),'or',tt(1:it),x(1:it),'b','Linewidth',2)
%     xlabel('$t$','Interpreter','latex')
%      ylabel('$x(t)$','Interpreter','latex')
%      set(gca,'Fontsize',18)
%     drawnow
    
end;

figure(11);
plot(tt,xan,'r',tt,x,'b','Linewidth',2)
xlabel('$t$','Interpreter','latex')
ylabel('$x(t)$','Interpreter','latex')
set(gca,'Fontsize',18)





    


