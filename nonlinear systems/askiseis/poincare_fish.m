

clear all
global r e

e=0.5;




Nt=100;
tt=linspace(0,1,Nt);
dt=tt(2)-tt(1);

RR=linspace(0,1/4+0.1,41);

%RR=0.2;

for ir=1:length(RR)
    r=RR(ir);
    
XX=linspace(0.01,1,1001);

for ix=1:length(XX);

x(1)=XX(ix);

for it=2:Nt
    
    dxdt=xdot(x(it-1),tt(it-1));
    x(it)=x(it-1)+dt*dxdt;
    if x(it)<0;x(it)=0;end;
end;

P(ix)=x(Nt);

% figure(65);hold on
% plot(tt,x,'b','Linewidth',2)
% xlabel('$t$','Interpreter','latex')
% ylabel('$x$','Interpreter','latex')
% set(gca,'Fontsize',20)
% drawnow

end

[sd,id]=min(abs(P(XX<=0.5)-XX(XX<=0.5)));
XX1=XX(XX<=0.5);

if sd<1.e-3;
    xe1(ir)=XX1(id);
else
    xe1(ir)=NaN;
end;
[sd,id]=min(abs(P(XX>0.5)-XX(XX>0.5)));
XX2=XX(XX>0.5);
if sd<1.e-3;
    xe2(ir)=XX2(id);
else
    xe2(ir)=NaN;
end;




figure(47);hold on
plot(XX,P,'m',XX,XX,'k','Linewidth',2)
xlabel('$X$','Interpreter','latex')
ylabel('$P(X)$','Interpreter','latex')
set(gca,'Fontsize',20)
drawnow

end

figure(107);hold on
plot(RR,xe1,'+b',RR,xe2,'.b','Linewidth',2)
xlabel('$r$','Interpreter','latex')
ylabel('$X_e$','Interpreter','latex')
set(gca,'Fontsize',20)
drawnow



    
    

    




