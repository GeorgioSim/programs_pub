clear all


% %ASKISI 14
% 
% N=1;
% x=linspace(-pi,pi,N)';
% R=linspace(0.5,1.5,N);
% % R=linspace(0.5,2,501);
% f= R.*cos(x);
% 
% x0=linspace(-pi,pi,5)';
% % x0=1;
% 
% for ir=1:length(R)
% Nt=10000;   %kapou mesa sto loop twn Nt bimatwn oi diaforoi attractors
% % emfanizontai apo monoi tous ane3artita apo to x0
%     xt=x0;
%     r=R(ir);
%     ft=[];
%     for it=1:Nt
%         
%         xt=r*cos(xt);
%         
%         if it>Nt-400
%             ft=[ft;xt];
%         end
%     end
%     F(:,ir)=ft;
% end
% 
% figure(1)
% plot(R,F,'.k')
% xlabel('$r$','Interpreter','latex')
%  ylabel('$x_\infty$','Interpreter','latex')
% set(gca,'Fontsize',24)
% 
% figure(2)
% hold on
% plot(x,f,'r',x,x,'--k','linewidth',2)
% plot(x,-x,'--k','linewidth',2)
% yline(0)
% xlabel('$x_n$','Interpreter','latex')
% ylabel('$x_{n+1}$','Interpreter','latex')
% set(gca,'Fontsize',24)
% hold off






% ASKISI 15

x0=0.5;
dt=0.5;
dt
x(1)=x0;
Tf=100;
Nt=ceil(Tf/dt)+1;
tt(1)=0;
xan(1)=x0;

for it=2:Nt
    
    tt(it)=(it-1)*dt;
    v=-x(it-1).^3;
    x(it)=x(it-1)+v*dt;
    xan(it)=xan(1)./sqrt(1+2.*tt(it).*xan(1).^2);
    
end

figure(11);
plot(tt,xan,'r',tt,x,'b','Linewidth',2)
xlabel('$t$','Interpreter','latex')
ylabel('$x(t)$','Interpreter','latex')
title(['x_{0}=',num2str(x0)]);
legend('analytical', 'Euler');     % label them -- colors show automagically

set(gca,'Fontsize',18)

% %elkistis
% 
% x0=linspace(-1e-2,1e-2,101)';
% 
% 
% for id=1:length(D);
%     
%     delta=D(id);
%     
%     Nt=10000;
%     xt=x0;
%     ft=[];
%     for it=1:Nt;
%         
%         xt=xt-delta*xt.*log(xt);
%         
%         if it>Nt-400;
%             ft=[ft;xt];
%         end;
%     end;
%     
%        F(:,id)=ft;
%        
% end;
% 
% 
% figure(520)
% plot(D,F,'.k')
% xlabel('$\delta$','Interpreter','latex')
%  ylabel('$x_\infty$','Interpreter','latex')
% set(gca,'Fontsize',24)
% 
% 
% 