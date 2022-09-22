% omega=[1e9, 1.2.*pi.*1e10, 5e11, 1e12];
omega=1e9;
figure(2);
hold on
title('n(k_{x})')
grid on;

[kx, n_plus, kx_max, n_max,n_min] = nfinder(omega);
p=plot(kx, real(n_plus));
q=plot(kx, imag(n_plus));  
n=n_plus;


xlabel('k_{x}');
ylabel('n_{k_{x}}');
line(xlim(), [0,0], 'LineWidth', 0.1, 'Color', 'k');

% axis([0 kx_max n_min n_max]);

legend([p,q],{'\Re(n)','\Im(n)'});
hold off

% https://i.stack.imgur.com/nJPuk.png


n_x_y=ifft(n);
figure(3);

hold on
title('n(x)')
grid on;

r=plot(kx, real(n_x_y));
s=plot(kx, imag(n_x_y));  
% p=plot(kx, real(n_minus));
% q=plot (kx, imag(n_minus)); 
% n=n_minus;


xlabel('x');
ylabel('n_{x}');
line(xlim(), [0,0], 'LineWidth', 0.1, 'Color', 'k');

legend([s,r],{'\Re(n)','\Im(n)'});
hold off





function [kx, n_plus, kx_max, n_max,n_min] = nfinder(o)

%eps0 einai to epsilon sto keno
eps0=8.8e-12;
mu0=4*pi*1e-7;
c=1/sqrt(eps0.*mu0);
%plotting n
kx_max= o./c;
k0=kx_max;
kx=linspace(0, kx_max ,200);
n_plus = -kx./k0-1i.*(kx.^2-k0);
n_max= 1.1.*max(abs(n_plus));
n_min= 1.1.*min(abs(n_plus));
end