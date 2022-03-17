%erwthma 2

delta=[1,2.2,2.5];
Nsteps=101;
x=linspace(0,4,Nsteps);

xanalytical_1_1=x-delta(1).*x.*log(x);
xanalytical_1_2=x-delta(2).*x.*log(x);
xanalytical_1_3=x-delta(3).*x.*log(x);

xanalytical_2=x;


hold on
plot(x,xanalytical_1_1)
plot(x,xanalytical_1_2)
plot(x,xanalytical_1_3)
plot(x,xanalytical_2)
xlabel('f_{i}(x)');
ylabel('y');

legend('y=f_{1_{1}}(x)', 'y=f_{1_{2}}(x)', 'y=f_{1_{3}}(x)', 'y=f_{2}(x)=x');
hold off

%erwthma 3
figure;
xanalytical_b_1_1=xanalytical_1_1-delta(1).*xanalytical_1_1.*log(xanalytical_1_1);
xanalytical_b_1_2=xanalytical_1_2-delta(2).*xanalytical_1_2.*log(xanalytical_1_2);
xanalytical_b_1_3=xanalytical_1_3-delta(3).*xanalytical_1_3.*log(xanalytical_1_3);
xanalytical_b_2=xanalytical_2;

hold on
plot(x,xanalytical_b_1_1)
plot(x,xanalytical_b_1_2)
plot(x,xanalytical_b_1_3)
plot(x,xanalytical_b_2)
xlabel('f_{i}(x)');
ylabel('y');

legend('y=f_{1_{1}}(x)', 'y=f_{1_{2}}(x)', 'y=f_{1_{3}}(x)', 'y=f_{2}(x)=x');
hold off