omega=[1e9, 1.2.*pi.*1e10, 5e11, 1e12];
figure(1);
hold on
title('Combine Plots')
legd=[];
leg={};
grid on;
for i=1:length(omega)
    [kx, ky, kx_max, ky_max] = kyfinder(omega(i));
    legd(i) = plot(kx, real(ky));
    ax = gca;
    ax.ColorOrderIndex=i;
    plot (kx, -real(ky));   %lathos logiki, swsto apotelesma
    
    xlabel('k_{x}');
    ylabel('k_{y}');
    line(xlim(), [0,0], 'LineWidth', 0.1, 'Color', 'k');

    leg{i}=['\omega_{',num2str(i),'}=',num2str(omega(i),'%.2e')];
    axis([-kx_max kx_max -ky_max ky_max]);
    
end

legend(legd,leg);
hold off



function [kx, ky, kx_max, ky_max] = kyfinder(o)

%eps0 einai to epsilon sto keno
eps0=8.8e-12;
mu0=4*pi*1e-7;
c=1/sqrt(eps0.*mu0);
%plotting ky
kx_max=1.1 .*pi.*1e5;
kx=linspace(- pi.*1e5, pi.*1e5 ,3000);
ky = sqrt(2*o./c).* sqrt(o./c - kx);
ky_max= 1.1.*max(ky);
end
