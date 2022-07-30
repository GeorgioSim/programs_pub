clear all
global e A 

e=0.1;
%e=0.5;
dt=0.01;
% Ta=30;
Ta=200;
%Ta=1000;
Nt=ceil(Ta/dt);
tt=zeros(Nt,1);
x=tt;y=tt;

x0=[0.5;0];
xt=x0;

x(1)=xt(1);y(1)=xt(2);


for it=2:Nt
    tp=(it-1)*dt;
    k1=fdot2d(xt,tp);
    k2=fdot2d(xt+0.5*k1*dt,tp+0.5*dt);
    k3=fdot2d(xt+0.5*k2*dt,tp+0.5*dt);
    k4=fdot2d(xt+k3*dt,tp*dt);
    xt=xt+dt/6*(k1+2*k2+2*k3+k4);
    
    tt(it)=tp;
    
    x(it)=xt(1);y(it)=xt(2);
    
end

et=exp(-e*tt/2);et2=et.^2;a=x0(1);
% A=a*et./sqrt(1-a^2/4+ et2 *a^2/4);
A=a./sqrt((1-a^2/4)*et2 +a^2/4);
xan=A.*cos(tt);

figure(35);
plot(x,y,'k','linewidth',2)
xlabel('$x$','Interpreter','latex','Fontsize',24)
ylabel('$y$','Interpreter','latex','Fontsize',24)
axis('square')
hold on

figure(36);
plot(tt,x,'k',tt,xan,'--r','linewidth',2)
xlabel('$t$','Interpreter','latex','Fontsize',24)
ylabel('$x(t)$','Interpreter','latex','Fontsize',24)
hold on

%xlim([950,1000])
    