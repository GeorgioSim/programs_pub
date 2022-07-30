clear all
x =[0:1:100];
y =[0:1:100];
% Ορίζει το πλεγμα
[xx , yy]= meshgrid (x , y) ;
epsilon =0;
epsilon=0.5;
epsilon =1;
epsilon =10;
A=sin(2* pi*xx /100) .* cos(2* pi*yy /100)+epsilon *randn( size (xx ) ) ;
figure (450)
contourf(xx , yy ,A) ; colorbar ; colormap jet
xlabel( '$x$' , 'Interpreter' , 'latex' , 'Fontsize' ,24) ;
ylabel( '$y$' , 'Interpreter' , 'latex' , 'Fontsize' ,24) ;
set( gca , 'Fontsize' ,24)


[u,s,v]= svd(A) ;
sd=diag ( s ) ;
% και σχεδιάζονται οι πρώτες 10 ιδιάζουσες ιτιμές
figure(2)
plot ([1:10] , sd(1:10) , '*r' , 'Markersize' ,10)
xlabel ( '$mode~ number$' , 'Interpreter' , 'latex' , 'Fontsize' ,24) ;
ylabel ( '$\sigma$' , 'Interpreter' , 'latex' , 'Fontsize' ,24) ;
set (gca, 'Fontsize' ,24)

v1=v(:,1) ;
u1=u(:,1) ;
A1=sd(1)*u1*v1' ;
figure(452)
contourf (xx , yy ,A1) ; colorbar ; colormap jet
xlabel ( '$x$' , 'Interpreter' , 'latex' , 'Fontsize' ,24);
ylabel ( '$y$' , 'Interpreter' , 'latex' , 'Fontsize' ,24);
%title ([ '$S /N = $' , num2str( sd (1) ^2/sum( sd (2: end ) .^2) ) ] , 'Interpreter','latex' , 'Fontsize' ,24)
set ( gca , 'Fontsize' ,24)


