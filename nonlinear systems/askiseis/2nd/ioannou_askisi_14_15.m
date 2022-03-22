clear all


%ASKISI 14

N=300;
x=linspace(-pi,pi,N)';
R=linspace(0.5,1.5,N);
% R=linspace(0.5,2,501);
f= R.*cos(x);

x0=linspace(-pi,pi,5)';
% x0=1;

for ir=1:length(R)
Nt=10000;   %kapou mesa sto loop twn Nt bimatwn oi diaforoi attractors
% emfanizontai apo monoi tous ane3artita apo to x0
    xt=x0;
    r=R(ir);
    ft=[];
    for it=1:Nt
        
        xt=r*cos(xt);
        
        if it>Nt-400
            ft=[ft;xt];
        end
    end
    F(:,ir)=ft;
end

figure(1)
plot(R,F,'.k')
xlabel('$r$','Interpreter','latex')
 ylabel('$x_\infty$','Interpreter','latex')
set(gca,'Fontsize',24)

figure(2)
hold on
plot(x,f,'r',x,x,'--k','linewidth',2)
plot(x,-x,'--k','linewidth',2)
yline(0)
xlabel('$x_n$','Interpreter','latex')
ylabel('$x_{n+1}$','Interpreter','latex')
set(gca,'Fontsize',24)
hold off






 % ASKISI 15
 
% %a
% x0=0.25;
% Dt=linspace(0.2,3,1);   %works for 1 only
% % Dt=1;
% x(1)=x0;
% Tf=100;
% tt(1)=0;
% xan(1)=x0;
% 
% for idt=1:length(Dt)
%     ft=[];
%     ft_an=[];
%     ft_tt=[];
%     dt=Dt(idt);
%     Nt=ceil(Tf/dt)+1;
%     for it=2:Nt
%         tt(it)=(it-1)*dt;
%         v=-x(it-1).^3;
%         x(it)=x(it-1)+v*dt;
%         xan(it)=xan(1)./sqrt(1+2.*tt(it).*xan(1).^2); 
%         ft=[ft;x(it)];
%         ft_an=[ft_an;xan(it)];
%         ft_tt=[ft_tt;tt(it)];
%     end
%     F_x(:,idt)=ft;
%     F_an(:,idt)=ft_an;
%     F_tt(:,idt)=ft_tt;
% end
% 
% figure(11);
% plot(F_tt,F_x,'r',F_tt,F_an,'b','Linewidth',2)
% xlabel('$t$','Interpreter','latex')
% ylabel('$x(t)$','Interpreter','latex')
% title(['x_{0}=',num2str(x0),'       dt=',num2str(dt)]);
% 
% %label, works for multiple lines 
% %https://www.mathworks.com/matlabcentral/answers/285396-make-legend-for-lines
% % linehandles = [p1, p2, p3, ...];
% % cols = cell2mat(get(linehandles, 'color'));
% % [~, uidx] = unique(cols, 'rows', 'stable');
% % legend(linehandles(uidx), {'first class', 'second class'})
% 
% %label, works for 2 lines (length(Dt)=1)
% % legend('analytical', 'Euler');     % label them -- colors show automagically
% 
% set(gca,'Fontsize',18)


% 
% %b
% %elkistis
% dt=0.2;
% % dt=0.4;
% % dt=0.6;
% % dt=0.69;
% X0=linspace(-sqrt(2./dt),sqrt(2./dt),301)';
% Tf=1000;
% 
% for ix0=1:length(X0)
%     
%     x0=X0(ix0);    
%     Nt=ceil(Tf/dt)+1;
%     xt=x0;
%     ft=[];
%     for it=1:Nt
%         v=-xt.^3;
%         xt=xt+v.*dt;
%         
%         if it>Nt-400
%             ft=[ft;xt];
%         end
%     end
%     
%     F(:,ix0)=ft;
%        
% end
% % t=linspace(0,Tf,length(F));
% 
% figure(420)
% plot(X0,F,'.k')
% xlabel('$x_{0}$','Interpreter','latex')
%  ylabel('$x_\infty$','Interpreter','latex')
% set(gca,'Fontsize',24)



% 
% %elkistis
% x0=0.3;
% % x0=-0.3;
% % x0=1.2;
% Dt=linspace(1e-4,3,351);
% Tf=2000;
% 
% for idt=1:length(Dt)
%      
%     dt=Dt(idt);
%     Nt=ceil(Tf/dt)+1
%     xt=x0;
%     ft=[];
%     for it=1:Nt
%         v=-xt.^3;
%         xt=xt+v.*dt;
%         
%         if it>Nt-400
%             ft=[ft;xt];
%         end
%     end
%     
%     F(:,idt)=ft;
%        
% end
% % t=linspace(0,Tf,length(F));
% 
% figure(520)
% plot(Dt,F,'.k')
% xlabel('$dt$','Interpreter','latex')
% ylabel('$x_\infty$','Interpreter','latex')
% title(['x_{0}=',num2str(x0)]);
% set(gca,'Fontsize',24)
% 
% 
% 
