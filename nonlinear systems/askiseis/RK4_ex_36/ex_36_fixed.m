clear all
global e A 

e=0.2; % xanei gia t>1/e=100
% e=0.05; %% xanei gia t>1/e=50
%e=0.5;
dt=0.01;
% Ta=30;
Ta=200;
%Ta=1000;
Nt=ceil(Ta/dt);
tt=zeros(Nt,1);
x=tt;y=tt;

x0=[0;4];
xt=x0;

x(1)=xt(1);y(1)=xt(2);


for it=2:Nt
    tp=(it-1)*dt;
    k1=fdot2d_theory(xt,tp);
    k2=fdot2d_theory(xt+0.5*k1*dt,tp+0.5*dt);
    k3=fdot2d_theory(xt+0.5*k2*dt,tp+0.5*dt);
    k4=fdot2d_theory(xt+k3*dt,tp*dt);
    xt=xt+dt/6*(k1+2*k2+2*k3+k4);
    tt(it)=tp;
    x(it)=xt(1);y(it)=xt(2);
end

et=exp(-e*tt);a=x0(2)/2;
% A=a*et./sqrt(1-a^2/4+ et2 *a^2/4);
A=2*a./sqrt(a^2*(1-et) + et);
xan=A.*sin(tt);

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

xlim([0,15])
    