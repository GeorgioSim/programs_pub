omega=1:0.01:100
H=-0.75.*(1./(2+1i.*omega))+1.75.*(1./(6+1i.*omega));
hold on
plot(omega, real(H))
plot(omega, imag(H))
plot(omega, abs(H))

legend('H_{real}', 'H_{imag}', '|H(\omega)|');
annotation('textbox',...
    [0.6 0 0.2 0.3],...
    'String',{['\omega_{max} = ' num2str(omega(find(abs(H)==max(abs(H)))), '%e' )]},...
    'FontSize',10,...
    'FontName','Arial',...
    'LineStyle','--',...
    'FitBoxToText','on');
hold off