
clear all

x0=10;
dt=0.0005;
x(1)=x0;
Tf=10;
Nt=ceil(Tf/dt)+1;
tt(1)=0;
x2(1)=x0;

for it=2:Nt
    
    tt(it)=(it-1)*dt;
    v=-x(it-1).^3;
    v2=-x2(it-1);
    x(it)=x(it-1)+v*dt;
    x2(it)=x2(it-1)+v2*dt;
%     figure(10)
%     plot(tt(1:it),xan(1:it),'or',tt(1:it),x(1:it),'b','Linewidth',2)
%     xlabel('$t$','Interpreter','latex')
%      ylabel('$x(t)$','Interpreter','latex')
%      set(gca,'Fontsize',18)
%     drawnow
    
end

figure(11);

% plot(tt,x2,'b','Linewidth',2)
plot(tt,x2,'r',tt,x,'b','Linewidth',2)
xlabel('$t$','Interpreter','latex')
ylabel('$x(t)$','Interpreter','latex')
set(gca,'Fontsize',18)

legend('-x', '-x^3');     % label them -- colors show automagically
