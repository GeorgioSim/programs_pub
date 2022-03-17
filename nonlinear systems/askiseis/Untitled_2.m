x0=2;
delta=0.01;
Nsteps=50;
L=Nsteps*delta;
x(1)=2;

for(i=1:Nsteps)
    t(i)= delta*(i-1);
    v(i)=-x(i)*log(x(i));
    x(i+1)=x(i)+delta*v(i);
end 
v(Nsteps+1)=0;
t(Nsteps+1)=L
xanalytical=x(1)*exp(-linspace(0,L,Nsteps+1));

hold on
plot(t,xanalytical)
plot(t,x)
xlabel('time');
ylabel('x');

legend('x_{analytical}', 'x_{Euler}', 'Euler');
hold off