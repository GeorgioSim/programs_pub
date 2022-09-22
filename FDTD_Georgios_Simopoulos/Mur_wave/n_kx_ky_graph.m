
% omega=[1e9, 1.2.*pi.*1e10, 5e11, 1e12];
omega=1e9;
figure(2);
hold on
title('$$\Re(k_{x}(n_{real},n_{imag},\omega))>0$$','interpreter','latex')
% legd=[];
% leg={};
grid on;
for i=1:length(omega)
    [k0,kx, ky, kx_max, ky_max] = kyfinder(omega(i));
    [KX,KY] = meshgrid(kx,ky);
%     n_plus = 1./(2.*k0).*(KX + sqrt(KX.^2 + 2.*KY.^2));
%     n_minus = 1./(2.*k0).*(KX - sqrt(KX.^2 + 2.*KY.^2));
    
    n_plus = 1./(k0).*(KX);
    n_minus = -1./(k0).*(KX);
    n = 1./(k0).*(sqrt(KX.^2 + KY.^2));
    
% %     legd(i) = meshc(KX, KY, abs(n_plus));
%     sc = meshc(KX, KY, n_plus);
%     sc = meshc(real(n_plus), imag(n_plus), real(KX)>0);
    sc = meshc(real(n_plus), imag(n_plus), real(KX));
    
    
    
%     TO ERWTIMA EINAI: PWS KANW EXTRACT TO n=nreal+i*nimag 
% APO TO GRAFIMA GIA REAL(KX)>0
    
    
    scContour = sc(2);
% %     sc = meshc(KX, KY, abs(n_plus));
% %     ax = gca;
% %     ax.ZLim(2) = max(abs(n_plus));
    scContour.ZLocation = 'zmax';
    
%     sc2 = meshc(real(n_minus), imag(n_minus), real(KX)>0);
    sc2 = meshc(real(n_minus), imag(n_minus), real(KX));
    sc2(2).ZLocation = 'zmin';
% %     meshc(KX, KY, abs(n_minus));


    view(3)
    
% %     ax = gca;
% %     ax.ColorOrderIndex=i;
% %     meshc(KX, KY, abs(n_minus));   %lathos logiki, swsto apotelesma

%     meshc(KX, KY, abs(n));
    
    xlabel('n_{real}');
    ylabel('n_{imag}');
    zlabel('\Re(k_{x})');
%     line(xlim(), [0,0], 'LineWidth', 0.1, 'Color', 'k');

%     leg{i}=['\omega_{',num2str(i),'}=',num2str(omega(i),'%.2e')];
%     axis([-kx_max kx_max -ky_max ky_max]);
    
    legend('$$n_{+}$$','$$n_{-}$$','interpreter','latex');
    
        
    scContour.ShowText='on';
    scContour.LabelSpacing=600; % Default (144)
    
    
    hold off
    
    figure(3);
%     title('$$\Re(n(x,y,t=0))$$','interpreter','latex')
    title('$$\Im(n(x,y,t=0))$$','interpreter','latex')
%     title('$$n(x,y,t=0)$$','interpreter','latex')
    grid on
    hold on
    
%     n_plus_ifourier = ifft2(n_plus);
    n_plus_ifourier = abs(ifftshift(ifft2(n_plus)));
%     imagesc(abs(ifftshift(n_plus_ifourier)));
%     n_minus_ifourier = ifft2(n_minus);
%     n_plus_ifourier_real = real(ifft2(n_plus));
    n_plus_ifourier_real = ifftshift(real(ifft2(n_plus)));
    n_plus_ifourier_imag = ifftshift(imag(ifft2(n_plus)));
    epsilon = n_plus_ifourier_real.^2;


%%There may be a problem with X_plus and Y_plus definition

%     X_plus = ((-size(n_plus_ifourier))/2:(size(n_plus_ifourier,1)-1)./2)/2./size(n_plus_ifourier,1);
%     Y_plus = ((-size(n_plus_ifourier))/2:(size(n_plus_ifourier,2)-1)./2)/2./size(n_plus_ifourier,2);
    X_plus = (0:size(n_plus_ifourier,2)-1)/size(n_plus_ifourier,2);
    Y_plus = (0:size(n_plus_ifourier,1)-1)/size(n_plus_ifourier,1);
%     X_minus = (0:size(n_minus_ifourier,1)-1)/size(n_minus_ifourier,1);
%     Y_minus = (0:size(n_minus_ifourier,2)-1)/size(n_minus_ifourier,2);
    
    [x_plus,y_plus] = meshgrid(X_plus,Y_plus);
%     [x_minus,y_minus] = meshgrid(X_minus,Y_minus);

%     ax = gca; % current axes
%     ax.FontSize = 12;
%     ax.TickDir = 'out';
%     ax.TickLength = [0.02 0.02];
% %     ax.ZLim = [-1e-19 1e-19];
%     ax.ZLim = [-1 1];
    
    isc = meshc(x_plus, y_plus, n_plus_ifourier_imag);
%     isc = meshc(x_plus, y_plus, abs(n_plus_ifourier));
    iscContour=isc(2);
    iscContour.ZLocation = 'zmax';
%     isc2 = meshc(x_minus, y_minus, abs(n_minus_ifourier));
%     isc2(2).ZLocation = 'zmin';
    
    iscContour.ShowText='on';
    iscContour.LabelSpacing=600; % Default (144)
    
%     view(3)
    
    xlabel('x(randomly chosen)');
    ylabel('y(randomly chosen)');
    zlabel('n');

    
%     figure(4);
%     
%     n_new_plus = abs(fft2(ifftshift(ifft2(n_plus))));
%     
%     iisc = meshc(KX, KY, n_new_plus);
%     iiscContour = sc(2);
% % %     sc = meshc(KX, KY, abs(n_plus));
% % %     ax = gca;
% % %     ax.ZLim(2) = max(abs(n_plus));
%     iiscContour.ZLocation = 'zmax';
%     iisc2 = meshc(KX, KY, n_new_plus);
%     iisc2(2).ZLocation = 'zmin';
% % %     meshc(KX, KY, abs(n_minus));
%     view(3)
    
    
    hold off
end

% legend(legd,leg);
% hold off



function [k0,kx, ky, kx_max, ky_max] = kyfinder(o)

%eps0 einai to epsilon sto keno
eps0=8.8e-12;
mu0=4*pi*1e-7;
c=1/sqrt(eps0.*mu0);
k0 = o./c ; 
%plotting ky
% kx_max = k0;
kx_real = linspace(0, k0 ,100);
kx_imag = linspace(-k0, k0 ,100);
kx = complex(kx_real,kx_imag);
kx_max = max(kx);
ky_real = linspace(-k0, k0 ,100);
ky_imag = linspace(-k0, k0 ,100);
ky = complex(ky_real,ky_imag);
%Same number of samples is needed for complex
ky = zeros(size(ky));


% kx = linspace(0, k0 ,100);
% ky = linspace(-k0, k0 ,100);
ky_max = max(ky);
end

