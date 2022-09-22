

% This is a 1D FDTD simulation with pulse
% It displays a "movie" of the signal
%TRYING TMz
figure(5);
% % Size of the FDTD space
% clear;
%i ends at ie
ie=100;
% Position of the source axis i
is=50;
%j ends at je
je=100;
% Position of the source axis j
js=50;
%i,j-space

% Number of time steps
nsteps=300;
%N number of circles
N=5;
% Gaussian pulse
t0=35;
spread=15;
%COMMENT FOR TESTING
Ts = 1;
T=nsteps;
fs = 1/Ts;   % Sampling frequency
t = 1:Ts:T;  % Time vector 
freq_in=2*pi*N/T;
freq_in
% Cell size and time stepping
%after fftshift: paratirw oti to >1.5 einai kalo
fmax=hifftmethod(t0,spread,N,nsteps);
% fmax=freq_in*fdiff;
fmax
% END OF COMMENT FOR TESTING

% Cell size and time stepping
% % %COMMENT FOR TESTING
% freq_in=0.1257;
% fmax=0.1267;
% % %END OF COMMENT FOR TESTING

%DEFINE PARAMETERS
eps_0 = 8.854*1e-12;
mu_0  = 4*pi*1e-7;
c0   = 1/sqrt(eps_0*mu_0); %the speed of the light in the medium
lambdamin=c0/fmax;
ddx=lambdamin/10;
ddx
dt=ddx/(2*c0);
dt

% % Cell size and time stepping
% c0=3.e8;
% lambdamin=0.1;
% %lambdamin=c0/fmax;
% ddx=lambdamin/10;
% ddx
% dt=ddx/(2.*c0);
% dt



% Constants
cc=c0.*dt./ddx./epsilon;
sigma=0;
% Initialize vectors
ez=zeros(ie,je);
hx=zeros(ie,je);
hy=zeros(ie,je);
% % Absorbing conditions initialisation
% c1=(cc-1)/(cc+1);
% c2= 2/(cc+1);
% c3= cc^2/(2*(cc+1));
% prev_xfor=zeros(1,je);
% prev_x_minus_1for=zeros(1,je);
% prev_yfor=zeros(ie,1);
% prev_y_minus_1for=zeros(ie,1);
% prev_xrev=zeros(1,je);
% prev_x_minus_1rev=zeros(1,je);
% prev_yrev=zeros(ie,1);
% prev_y_minus_1rev=zeros(ie,1);


% Create and open the video object
vidObj = VideoWriter('2D_boundary_mur.avi');
open(vidObj);
for n=1:nsteps
% Source
pulser=exp(-.5*((n-t0)/spread).^2)*sin(2*pi*freq_in*n);
ez(is,js)=ez(is,js)+pulser;
% E field loop
    for j=2:je-1
        for i=2:ie-1
        ez(i,j)=ez(i,j)+cc(i,j).*(hy(i,j)-hy(i-1,j)-hx(i,j)+hx(i,j-1));
        end
    end
% H field loops
    for j=1:je-1
        for i=1:ie-1
        hx(i,j)=hx(i,j)+cc(i,j).*(ez(i,j)-ez(i,j+1));
        end
    end
    for j=1:je-1
        for i=1:ie-1
        hy(i,j)=hy(i,j)+cc(i,j).*(ez(i+1,j)-ez(i,j));
        end
    end

% 
% % Absorbing Boundary Conditions MUR
%     %Mur's abc conditions obtained from Mur's difference equation for
%     %forward boundary
%     if n>=ie-2-is
%         ez(ie-2,3:1:je-3)=c1*(ez(ie-3,3:1:je-3)+prev_prev_xfor(1,3:1:je-3))-prev_prev_x_minus_1for(1,3:1:je-3)+c2*(prev_xfor(1,3:1:je-3)+prev_x_minus_1for(1,3:1:je-3))+c3*(prev_x_minus_1for(1,2:1:je-4)-2*prev_x_minus_1for(1,3:1:je-3)+prev_x_minus_1for(1,4:1:je-2)+prev_xfor(1,2:1:je-4)-2*prev_xfor(1,3:1:je-3)+prev_xfor(1,4:1:je-2));
%     end
%     
%     %Storage vectors for boundary and boundary-1 values of previous and its
%     %previous time steps updated at forward boundary
%     prev_prev_xfor=prev_xfor;
%     prev_prev_x_minus_1for=prev_x_minus_1for;
%     prev_xfor(1,1:1:je)=ez(ie-2,1:1:je);
%     prev_x_minus_1for(1,1:1:je)=ez(ie-3,1:1:je);
% 
% 
%     %Mur's abc conditions obtained from Mur's difference equation for
%     %backward boundary 
% 
% % prosthesa: -2*prev_x_minus_1rev(1,3:1:je-3)-2*prev_xrev(1,3:1:je-3)
%     if n>=is-3
%         ez(2,3:1:je-3)= -prev_prev_xrev(1,3:1:je-3)+c1*(ez(3,3:1:je-3)+prev_prev_x_minus_1rev(1,3:1:je-3))+c2*(prev_xrev(1,3:1:je-3)+prev_x_minus_1rev(1,3:1:je-3))+c3*(prev_x_minus_1rev(1,2:1:je-4)-2*prev_x_minus_1rev(1,3:1:je-3)+prev_x_minus_1rev(1,4:1:je-2)+prev_xrev(1,2:1:je-4)-2*prev_xrev(1,3:1:je-3)+prev_xrev(1,4:1:je-2));
%     end
%     %Storage vectors for boundary and boundary-1 values of previous and its
%     %previous time steps updated at backward boundary
%     prev_prev_xrev=prev_xrev;
%     prev_prev_x_minus_1rev=prev_x_minus_1rev;
%     prev_xrev(1,1:1:je)=ez(3,1:1:je);
%     prev_x_minus_1rev(1,1:1:je)=ez(2,1:1:je);
%     
%     %Mur's abc conditions obtained from Mur's difference equation for
%     %upward boundary
%     if n>=je-2-js
%         ez(3:1:ie-3,ie-2)=c1*(ez(3:1:ie-3,je-3)+prev_prev_yfor(3:1:ie-3,1))-prev_prev_y_minus_1for(3:1:ie-3,1)+c2*(prev_yfor(3:1:ie-3,1)+prev_y_minus_1for(3:1:ie-3,1))+c3*(prev_y_minus_1for(2:1:ie-4,1)-2*prev_y_minus_1for(3:1:ie-3,1)+prev_y_minus_1for(4:1:ie-2,1)+prev_yfor(2:1:ie-4,1)-2*prev_yfor(3:1:ie-3,1)+prev_yfor(4:1:ie-2,1));
%     end
%         
%     %Storage vectors for boundary and boundary-1 values of previous and its
%     %previous time steps updated at upward boundary
%     prev_prev_yfor=prev_yfor;
%     prev_prev_y_minus_1for=prev_y_minus_1for;
%     prev_yfor(1:1:ie,1)=ez(1:1:ie,je-2);
%     prev_y_minus_1for(1:1:ie,1)=ez(1:1:ie,je-3);
%     
%     %Mur's abc conditions obtained from Mur's difference equation for
%     %downward boundary
%     if n>=js-3
%         ez(3:1:ie-3,2)=-prev_prev_yrev(3:1:ie-3,1)+c1*(ez(3:1:ie-3,3)+prev_prev_y_minus_1rev(3:1:ie-3,1))+c2*(prev_yrev(3:1:ie-3,1)+prev_y_minus_1rev(3:1:ie-3,1))+c3*(prev_y_minus_1rev(2:1:ie-4,1)-2*prev_y_minus_1rev(3:1:ie-3,1)+prev_y_minus_1rev(4:1:ie-2,1)+prev_yrev(2:1:ie-4,1)-2*prev_yrev(3:1:ie-3,1)+prev_yrev(4:1:ie-2,1));
%     end
%        
%     %Storage vectors for boundary and boundary-1 values of previous and its
%     %previous time steps updated at downward boundary
%     prev_prev_yrev=prev_yrev;
%     prev_prev_y_minus_1rev=prev_y_minus_1rev;
%     prev_yrev(1:1:ie,1)=ez(1:1:ie,3);
%     prev_y_minus_1rev(1:1:ie,1)=ez(1:1:ie,2);   
%     
%    %Mirroring of corner values taking the fact that corners are reached by the fields from the previous corners
%  %in two time steps as S=1/sqrt(2) viz. sqrt(2)*delta(distance between two corners) is reached in 2 time steps
%     ez(2,2)=prev_prev_xrev(3);
%     ez(2,je-2)=prev_prev_xrev(je-3);
%     ez(ie-2,2)=prev_prev_x_minus_1for(3);
%     ez(ie-2,je-2)=prev_prev_x_minus_1for(je-3);    
%     
%     



[X,Y] = meshgrid(1:ie,1:je);
surf(X,Y,ez)
xlim([1 ie]);
ylim([1 je]);
zlim([-1.5 1.5]);
xlabel('x')
ylabel('y')
zlabel('z')
%view(0,90)
M(:,n) = getframe ;
% input('')
end
writeVideo(vidObj,M);
close(vidObj);