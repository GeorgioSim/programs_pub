% 2 D FDTD TM program with Mur absorbing boundary condition

clear ;

IE =200;
JE =100;

ddx =4.3e-5;
dt = ddx/6e8 ;
c0 =3e8;
ddy = ddx ;
dt1 = dt ;

freq =0.7e12 ;
ga = ones( IE , JE ) ;
dz = zeros( IE , JE ) ;
ez = zeros( IE , JE ) ;
hx = zeros( IE , JE ) ;
hy = zeros( IE , JE ) ;
ez2 = zeros( IE , JE ) ;
ez1 = zeros( IE , JE ) ;

ic = IE/2;
jc = JE/2;
t0 =20.0;
spread =6.0;
T =0;
nsteps =250;

% % Create and open the video object
% 
% vidObj = VideoWriter('2D_boundary_mur.avi');
% vidObj.FrameRate=30;
% open(vidObj);


% for n =1: nsteps ;
% ez2 = ez1 ; ez1 = ez ;
% for j =2: JE-1;
% for i =2: IE-1;
% dz(i , j ) = dz(i , j ) +0.5*( hy(i , j ) - hy(i -1 , j ) - hx(i , j ) + hx(i ,j -1) ) ;
% end
% end
% % pulse = exp( -0.5*( power (( t0 - n ) / spread ,2) ) ) ;
% pulse = sin(2* pi * freq * dt *( n - t0 ) ) ;
% % pulse = exp( -0.5*( power (( t0 - n ) / spread ,2) ) ) .* sin (2* pi * freq * dt *( n -t0 ) ) ;
% dz( ic , jc ) = pulse ;
% for i =2: IE -1;
% for j =2: JE -1;
% ez(i , j ) = ga(i , j ) .* dz(i , j ) ;
% end
% end
% % Mur ’ s absorbing boundary conditions
% M1 = c0 * dt - ddx ;
% M2 = c0 * dt + ddx ;
% M = M1 / M2 ;
% N1 =(2* ddx ) / M2 ;
% O1 =((( c0 * dt ) ^2.* ddx ) ) /(2*( ddy ^2) * M2 ) ;
% MM1 = c0 * dt - ddy ;
% MM2 = c0 * dt + ddy ;
% MM = MM1 / MM2 ;
% N2 =(2* ddy ) / MM2 ;
% O2 =((( c0 * dt ) ^2) .* ddy ) /(2*( ddx ^2) * MM2 ) ;
% x =0:


% Create and open the video object

vidObj = VideoWriter('2D_boundary_mur_left_gauss.avi');
vidObj.FrameRate=30;
open(vidObj);

%EDIT GIA TO MUR SAN WAVE SOLUTION
for n =1: nsteps ;
ez2 = ez1 ; ez1 = ez ;
% pulse = exp( -0.5*( power (( t0 - n ) / spread ,2) ) ) ;
% pulse = sin(2* pi * freq * dt *( n - t0 ) ) ;
pulse = exp( -0.5*( power (( t0 - n ) / spread ,2) ) ) .* sin (2* pi * freq * dt *( n -t0 ) ) ;
ez( ic , jc ) =  pulse ;
% Mur ’ s absorbing boundary conditions
M1 = c0 * dt - ddx ;
M2 = c0 * dt + ddx ;
M = M1 / M2 ;
N1 =(2* ddx ) / M2 ;
O1 =((( c0 * dt ) ^2.* ddx ) ) /(2*( ddy ^2) * M2 ) ;
MM1 = c0 * dt - ddy ;
MM2 = c0 * dt + ddy ;
MM = MM1 / MM2 ;
N2 =(2* ddy ) / MM2 ;
O2 =((( c0 * dt ) ^2) .* ddy ) /(2*( ddx ^2) * MM2 ) ;
%x=0:
for i=2:IE-1;
% ez(i , 2:1: JE-1 ) = - ez2(i+1 , 2:1: JE-1 ) + M *( ez(i+1 , 2:1: JE-1 ) + ez2(i , 2:1: JE-1 ) ) + N1 *( ez1(i , 2:1: JE-1 ) + ez1(i+1 , 2:1: JE-1 )) + O1 *( ez1(i , 3:1: JE) -2* ez1(i , 2:1: JE-1 ) + ez1(i ,1:1: JE-2) + ez1(i+1 , 3:1: JE) -2* ez1(i+1 , 2:1: JE-1 ) + ez1(i+1 ,1:1: JE-2) ) ;
ez (i , 2:1:JE-1 ) = - ez2 (i , 2:1:JE-1 ) + M *( ez (i+1 , 2:1:JE-1 ) + ez2 (i , 2:1:JE-1 ) ) + N1 *( ez1 (i , 2:1:JE-1 ) + ez1 (i+1 , 2:1:JE-1 ) );
end



% %x=h:
% for i=IE-1:-1:2;
% ez( i , 2:1: JE -1 ) = - ez2( i -1 , 2:1: JE -1 ) + M *( ez( i -1 , 2:1: JE -1) + ez2( i ,2:1: JE -1 ) ) + N1 *( ez1(i -1 , 2:1: JE -1 ) + ez1( i , 2:1: JE -1 ) ) + O1 *( ez1( i , 3:1: JE) -2* ez1 ( i , 2:1: JE -1 ) + ez1 ( i ,1:1: JE -2) + ez1 (i -1 , 3:1: JE) -2* ez1 ( i -1 , 2:1: JE -1 ) + ez1 ( i -1 ,1:1: JE -2) ) ;
% end

%END OF EDIT GIA TO MUR SAN WAVE SOLUTION






%x=0:
for j =2: JE -1;
ez(2 , j ) = - ez2(3 , j ) + M *( ez(3 , j ) + ez2(2 , j ) ) + N1 *( ez1(2 , j ) + ez1(3 , j )) + O1 *( ez1(2 , j +1) -2* ez1(2 , j ) + ez1(2 ,j -1) + ez1(3 , j+1) -2* ez1(3 , j ) + ez1(3 ,j -1) ) ;
% % 1 st order Mur
% ez (2 , j ) = - ez2 (3 , j ) + M *( ez (3 , j ) + ez2 (2 , j ) ) + N1 *( ez1 (2 , j ) + ez1 (3 , j ) ) ;
end
% x = h :
for j =2: JE -1;
ez( IE , j ) = - ez2( IE -1 , j ) + M *( ez( IE -1 , j ) + ez2( IE , j ) ) + N1 *( ez1(IE -1 , j ) + ez1( IE , j ) ) + O1 *( ez1( IE , j +1) -2* ez1 ( IE , j ) + ez1 ( IE ,j -1) + ez1 (IE -1 , j +1) -2* ez1 ( IE -1 , j ) + ez1 ( IE -1 ,j -1) ) ;
% % 1 st order Mur
% ez ( IE , j ) = - ez2 ( IE -1 , j ) + M *( ez ( IE -1 , j ) + ez2 ( IE , j ) ) + N1 *( ez1 ( IE -1 , j ) + ez1 (
% IE , j ) ) ;
end
% y =0:
for i =2: IE -1;
ez (i ,2) = - ez2 (i ,3) + MM *( ez (i ,3) + ez2 (i ,2) ) + N2 *( ez1 (i ,3) + ez1 (i ,2) ) + O2 *( ez1 ( i +1 ,2) -2* ez1 (i ,2) + ez1 (i -1 ,2) + ez1 ( i +1 ,3) -2* ez1 (i,3) + ez1 (i -1 ,3) ) ;
% % 1 st order Mur
% ez (i ,2) = - ez2 (i ,3) + MM *( ez (i ,3) + ez2 (i ,2) ) + N2 *( ez1 (i ,3) + ez1 (i ,2) ) ;
end
% y = h :
for i =2: IE -1;
ez (i , JE ) = - ez2 (i , JE -1) + MM *( ez (i , JE -1) + ez2 (i , JE ) ) + N2 *( ez1(i , JE -1) + ez1 (i , JE ) ) + O2 *( ez1 ( i +1 , JE ) -2* ez1 (i , JE ) + ez1 (i -1 , JE ) + ez1( i +1 , JE -1) -2* ez1 (i , JE -1) + ez1 (i -1 , JE -1) ) ;
% % 1 st order Mur
% ez (i , JE ) = - ez2 (i , JE -1) + MM *( ez (i , JE -1) + ez2 (i , JE ) ) + N2 *( ez1 (i , JE -1) + ez1
% (i , JE ) ) ;
end

% if n ==220;
subplot (2 ,1 ,1)
mesh (1:1: IE ,1:1: JE , ez' )
shading interp
title ( ' Sinusoidal wave propagating in free space , 2nd order Mur ABC. ' )

axis ([0 200 0 100 -0.5 1]) ;
zlabel ( ' Ez ') ;
xlabel ( 'x ') ;
ylabel ( 'y ') ;
Title_ ={ 't = ' ,n };
text (37 ,7 ,1 , Title_ , 'Color' , 'k') ;
subplot (2 ,1 ,2)
imagesc ((1:1: IE ) ,(1:1: JE ) ,ez' ,[ -1 1])
shading interp
colorbar
axis ([0 200 0 100 ]) ;
zlabel ( ' Ez ') ;
xlabel ( 'x ') ;
ylabel ( 'y ') ;
Title_ ={ 't = ' ,n };
text (27 ,27 , Title_ , 'Color' , 'k') ;

% end
v = getframe ;
writeVideo(vidObj,v);
end

close(vidObj);
% Movie(M ,1);
