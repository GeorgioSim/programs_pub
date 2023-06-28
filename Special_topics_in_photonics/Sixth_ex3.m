clear all; clc; format long; % 1D Waveguide FDM solver
N=1024*4; L=10*2*pi; x=(L/N)*(-N/2:N/2-1); dx=x(2)-x(1);   
w=8; po=exp(-(x/w).^8); % custom waveguide

% po=cos(x)+exp(-x.^2); % custom waveguide 2
figure(1); plot(x,po,'-*r'); 
  
A=-2/(dx^2); B=1/(dx^2);  e = ones(N,1);    
M = spdiags([B*e A*e+po' B*e], -1:1, N, N);  % Gia na dei3w oti o pinakas aytos exei midenika
M(1,N)=0;  M(N,1)=0;  
opts.maxit=300; opts.disp=0; [idod,id]=eigs(M,N,5,opts); % eigs anti eig gia faster otan exw spdiags pinaka 
% opts: options not default, 5: einai  mia arxiki ektimisi (tis ta3is tou
% dynamikou)
mode1=idod(:,1); mode2=idod(:,2); mode3=idod(:,3);

figure(2); plot(diag(id),'r*');
xlim([0 20])

figure(3); plot(x,real(mode1),'-*b',x,po,'-*r'); axis square;
title(['eigenvalue= ',num2str(id(1,1))]); 
figure(4); plot(x,real(mode2),'-*b',x,po,'-*r'); axis square;
title(['eigenvalue= ',num2str(id(2,2))]); 
figure(5); plot(x,real(mode3),'-*b',x,po,'-*r'); axis square;
title(['eigenvalue= ',num2str(id(3,3))]); 
 
figure(6);  for td=1:16 % Plot first 4 modes
subplot(4,4,td); 
plot(x,abs(idod(:,td))/max(abs(idod(:,td))),'-r',x,po,'-b');
axis([-30 30 0 1]); title(['eigenvalue= ',num2str(id(td,td))]);
end

figure(7); plot(x,real(idod(:,4)),'-*b',x,po,'-*r'); axis square;
title(['eigenvalue= ',num2str(id(4,4))]);
id(3,3)-id(4,4)