clear all
global sigma b r e on

e=0; on=0.2;
b=8/3; sigma=10;
r=28;
%rh=24.74
if r>1
    xep=sqrt(b*(r-1)); yep=xep;
    xeq=-xep;yeq=-yep;pi
    ze=r-1;

Jp=[-sigma, sigma, 0; r-ze,-1,-xep;yep,xep,-b];
Jq=[-sigma, sigma, 0; r-ze,-1,-xeq;yeq,xeq,-b];
[up,sp]=eig(Jp);
spd=diag(sp);
[sd,ind]=sort(-real(spd));
spd=spd(ind);up=up(:,ind);
[uq,sq]=eig(Jq);
sqd=diag(sq);
[sp,ind]=sort(-real(sqd));
sqd=sqd(ind);uq=uq(:,ind);

end

dt=0.01;
Tq=150;
Nt=ceil(Tq/dt);
tt=zeros(Nt,1);
x=tt;y=tt;

x0=[-3;0;2];
x0=xep+1*randn(3,1); %arxikes synthikes kont sta simeia isoropias
xt=x0;

x(1)=xt(1);y(1)=xt(2);
tt(1)=0;

for it=2:Nt
    
    tp=(it-1)*dt;
    k1=fdot3d(xt,tp);
    k2=fdot3d(xt+0.5*k1*dt,tp+0.5*dt);
    k3=fdot3d(xt+0.5*k2*dt,tp+0.5*dt);
    k4=fdot3d(xt+k3*dt,tp+dt);
    xt=xt+dt/6*(k1+2*k2+2*k3+k4);
tt(it)=tp;

x(it)=xt(1);y(it)=xt(2);z(it)=xt(3);
if rem(it,100)==0
    figure(45);
    plot(x(1:it),z(1:it),'r','Linewidth',2)
    xlabel('$x$','Interpreter','latex','Fontsize',24)
    ylabel('$y$','Interpreter','latex','Fontsize',24)
    set(gca,'Fontsize',18)
    drawnow;   
end
end
figure(46);
plot(y(1:it),z(1:it),'k','Linewidth',2)
hold on
plot(yep,ze,'+r','Markersize',12,'Linewidth',4)
plot(yeq,ze,'+r','Markersize',12,'Linewidth',4)
xlabel('$y$','Interpreter','latex','Fontsize',24)
ylabel('$z$','Interpreter','latex','Fontsize',24) 
set(gca,'Fontsize',18)
drawnow; 
hold on

figure(47);
plot3(x(1:it),y(1:it),z(1:it),'k','Linewidth',2)
hold on
plot3(xep,yep,ze,'+r','Markersize',12,'Linewidth',4)
plot3(xeq,yeq,ze,'+r','Markersize',12,'Linewidth',4)

xlabel('$x$','Interpreter','latex','Fontsize',24)
ylabel('$y$','Interpreter','latex','Fontsize',24) 
ylabel('$z$','Interpreter','latex','Fontsize',24) 
set(gca,'Fontsize',18)
drawnow;

figure(48);
plot(tt(1:it),y(1:it),'b',tt,0*tt,'k','Linewidth',2)
xlabel('$x$','Interpreter','latex','Fontsize',24)
ylabel('$y$','Interpreter','latex','Fontsize',24) 
ylabel('$z$','Interpreter','latex','Fontsize',24) 
set(gca,'Fontsize',18)
drawnow;
