%Giorgos Simopoulos AM:735 ex3
clear all, close all, clc;
 
mo=9.11*10^(-31);           %(kg)
me=0.067*mo;
mhh=0.45*mo;
mlh=0.082*mo;
L=12*10^(-9) ;              %(m)
hbar=1.05457*10^(-34)  ;    %(m^2*kg/sec)
 
 
digits(5)
Ee1=(((hbar^2)*(pi^2)/(2*me*L^2))*(6.2415*10^18)) ;    %(eV)
Ehh1=(((hbar^2)*(pi^2)/(2*mhh*L^2))*(6.2415*10^18));   %(eV)
Elh1=(((hbar^2)*(pi^2)/(2*mlh*L^2))*(6.2415*10^18));   %(eV)
Ee2=(((hbar^2)*(pi^2)*4/(2*me*L^2))*(6.2415*10^18)) ;  %(eV)
Ehh2=(((hbar^2)*(pi^2)*4/(2*mhh*L^2))*(6.2415*10^18)); %(eV)
Elh2=(((hbar^2)*(pi^2)*4/(2*mlh*L^2))*(6.2415*10^18)); %(eV)
 
display('Ee1')
vpa(Ee1)
display('Ehh1')
vpa(Ehh1)
display('Elh1')
vpa(Elh1)
display('Ee2')
vpa(Ee2)
display('Ehh2')
vpa(Ehh2)
display('Elh2')
vpa(Elh2)




clear all, close all, clc;
%data
mo=9.11*10^(-31);           %(kg)
me=0.067*mo;
mhh=0.45*mo;
mlh=0.082*mo;
L=12*10^(-9) ;              %(m)
hbar=1.05457*10^(-34)  ;    %(m^2*kg/sec)
Eg=1.42;                    %eV
kT=0.02585;                 %eV
e0=8.8541878*10^(-12);      %F/m
n=3.6;                      
q=1.60217662*10^-19;        %Cb
c=3*10^(8);                 %m/sec
Ep=28.8;                    %eV
Ev=0;                       %eV
Ec=Eg;                      %eV
 
%QW-Energy n=1,n=2 
Ee1=(((hbar^2)*(pi^2)/(2*me*L^2))*(6.2415*10^18)) ;  %(eV)
Ehh1=(((hbar^2)*(pi^2)/(2*mhh*L^2))*(6.2415*10^18)); %(eV)
Elh1=(((hbar^2)*(pi^2)/(2*mlh*L^2))*(6.2415*10^18)); %(eV)
Ee2=(((hbar^2)*(pi^2)*4/(2*me*L^2))*(6.2415*10^18)) ;  %(eV)
Ehh2=(((hbar^2)*(pi^2)*4/(2*mhh*L^2))*(6.2415*10^18)); %(eV)
Elh2=(((hbar^2)*(pi^2)*4/(2*mlh*L^2))*(6.2415*10^18)); %(eV)
 
 
%quasi Fermi level in CB
Ne=(me*kT*1.60218*10^(-19))/(pi*hbar^2);
i=1;
for n=2*10^12:2*10^12:10^13
syms Fc     
eqn=Ne*log(1+exp((Fc-Ee1-Eg)/kT))+Ne*log(1+exp((Fc-Ee2-Eg)/kT))-n==0;
a=vpasolve(eqn,Fc,'Random',true);
Efn(i,1)=a
end
 
%quasi Fermi-level in VB
Nhh=(mhh*kT*1.60218*10^(-19))/(pi*hbar^2);
Nlh=(mlh*kT*1.60218*10^(-19))/(pi*hbar^2);
k=1;
for p=2*10^12:2*10^12:10^13
syms Fv     
eqn=Nhh*log(1+exp((Fv-Ehh1)/kT))+Nlh*log(1+exp((Fv-Elh1)/kT))+Nhh*log(1+exp((Fv-Ehh2)/kT))+Nlh*log(1+exp((Fv-Elh2)/kT))-p==0;
b=vpasolve(eqn,Fv,'Random',true);
Efv(k,1)=b
end





clear all, close all, clc;


% MAIN SCRIPT Part 3

% n=[10^12,0.8*10^12,0.6*10^12,0.4*10^12,0.2*10^12];
% p=[2*10^12,4*10^12,6*10^12,8*10^12,10^13];
n=1e12:2e12:1e13;
p=wrev(1e12:2e12:1e13);
gain_TE_total=[];
gain_TM_total=[];
gain_TE_max_total=[];
gain_TM_max_total=[];
energy_total=[];

for i=1:length(n)
[gain_TM,gain_TE,gain_TE_max,gain_TM_max,energy]=calcgain(n(i),p(i));
gain_TE_total=[gain_TE_total,gain_TE];
gain_TM_total=[gain_TM_total,gain_TM];
gain_TE_max_total=[gain_TE_max_total,gain_TE_max];
gain_TM_max_total=[gain_TM_max_total,gain_TM_max];
energy_total=[energy_total,energy];
end

legd1=[];
leg1={};
legd2=[];
leg2={};
figure(1);
for i=1:length(gain_TE_total(1,:))
legd1(i)=plot(energy_total(:,i),gain_TE_total(:,i));
leg1{i}=['$\frac{n_{',num2str(i),'}}{p_{',num2str(i),'}}=$',num2str(n(i)./p(i))];
hold on;
end
ax = gca;
ax.ColorOrderIndex=i+2;
plot(energy_total(:,1),gain_TE_max_total(:,1),'--')
ax = gca;
ax.ColorOrderIndex=i+2;
plot(energy_total(:,1),-gain_TE_max_total(:,1),'--')
xlabel('$E_{21} (eV)$','interpreter','latex')
ylabel('$g_{21} (cm^{-1})$','interpreter','latex')
xlim([1.48 2])
title('TE gain spectra')
legend(legd1,leg1,'interpreter','latex')
hold off;

figure(2);

for i=1:length(gain_TM_total(1,:))
legd2(i)=plot(energy_total(:,i),gain_TM_total(:,i));
leg2{i}=['$\frac{n_{',num2str(i),'}}{p_{',num2str(i),'}}=$',num2str(n(i)./p(i))];
hold on;
end
ax = gca;
ax.ColorOrderIndex=i+2;
plot(energy_total(:,1),gain_TM_max_total(:,1),'--')
ax = gca;
ax.ColorOrderIndex=i+2;
plot(energy_total(:,1),-gain_TM_max_total(:,1),'--')
xlabel('$E_{21} (eV)$','interpreter','latex')
ylabel('$g_{21} (cm^{-1})$','interpreter','latex')
xlim([1.48 2])
title('TM gain spectra')
legend(legd2,leg2,'interpreter','latex')
hold off

%Function definition

function [gain_TM,gain_TE,gain_TE_max,gain_TM_max,energy]=calcgain(n,p) 
%data
mo=9.11*10^(-31);           %(kg)
me=0.067*mo;
mhh=0.45*mo;
mlh=0.082*mo;
L=12*10^(-9) ;              %(m)
hbar=1.05457*10^(-34)  ;    %(m^2*kg/sec)
Eg=1.43;                    %eV
kT=0.02585;                 %eV
e0=8.8541878*10^(-12);      %F/m
ni=3.6;                      
q=1.60217662*10^-19;        %Cb
c=3*10^(8);                 %m/sec
% Ep=28.8;                    %eV
Ev=0;                       %eV
Ec=Eg;                      %eV
 
%QW-Energy n=1,n=2 
Ee1=(((hbar^2)*(pi^2)/(2*me*L^2))*(6.2415*10^18)) ;  %(eV)
Ehh1=(((hbar^2)*(pi^2)/(2*mhh*L^2))*(6.2415*10^18)); %(eV)
Elh1=(((hbar^2)*(pi^2)/(2*mlh*L^2))*(6.2415*10^18)); %(eV)
Ee2=(((hbar^2)*(pi^2)*4/(2*me*L^2))*(6.2415*10^18)) ;  %(eV)
Ehh2=(((hbar^2)*(pi^2)*4/(2*mhh*L^2))*(6.2415*10^18)); %(eV)
Elh2=(((hbar^2)*(pi^2)*4/(2*mlh*L^2))*(6.2415*10^18)); %(eV)



%quasi Fermi level in CB
Ne=(me*kT*1.60218*10^(-19))/(pi*hbar^2);
syms Fc     
eqn=Ne*log(1+exp((Fc-Ee1-Eg)/kT))+Ne*log(1+exp((Fc-Ee2-Eg)/kT))-n==0;
Efc=vpasolve(eqn,Fc,'Random',true);
 
%quasi Fermi-level in VB
Nhh=(mhh*kT*1.60218*10^(-19))/(pi*hbar^2);
Nlh=(mlh*kT*1.60218*10^(-19))/(pi*hbar^2);
syms Fv     
eqn=Nhh*log(1+exp((Fv-Ehh1)/kT))+Nlh*log(1+exp((Fv-Elh1)/kT))+Nhh*log(1+exp((Fv-Ehh2)/kT))+Nlh*log(1+exp((Fv-Elh2)/kT))-p==0;
Efv=vpasolve(eqn,Fv,'Random',true);

 
%TE-TM polarization
C=14.4*q*10^7/(15*n*e0*c*hbar);
mrlh=me*mlh/(me+mlh);
mrhh=me*mhh/(me+mhh);
E1=Eg+Ee1+Ehh1;
E2=Eg+Ee1+Elh1;
E3=Eg+Ee2+Ehh2;
E4=Eg+Ee2+Elh2;
 
Mlh_TE=29*1.6*10^-19*mo/(2*6); % in eV->joule 1.6*10^-19 , 1/6 for TE and light hole
Mhh_TE=29*1.6*10^-19*mo/(2*2);
Mlh_TM=(2/3)*29*1.6*10^-19*mo/2; % in eV->joule 1.6*10^-19 , 2/3 for TM and light hole
Mhh_TM=0;
 
rhoe=me/(pi*hbar^2);  % density of states 2D
rhohh=mhh/(pi*hbar^2);
rholh=mlh/(pi*hbar^2);
rhorelh=(mrlh/(pi*hbar^2))/L 
rhorehh=(mrhh/(pi*hbar^2))/L
 
initial_E21=1 ; 
final_E21=2  ;
step_E21=0.01 ;
 
gain_e_lh_TE=zeros((final_E21-initial_E21)/step_E21+1,1);
gain_e_lh_TE_max=zeros((final_E21-initial_E21)/step_E21+1,1);
gain_e_hh_TE=zeros((final_E21-initial_E21)/step_E21+1,1);
gain_e_hh_TE_max=zeros((final_E21-initial_E21)/step_E21+1,1);
gain_TE=zeros((final_E21-initial_E21)/step_E21+1,1);
gain_TE_max=zeros((final_E21-initial_E21)/step_E21+1,1);

gain_e_lh_TM=zeros((final_E21-initial_E21)/step_E21+1,1);
gain_e_lh_TM_max=zeros((final_E21-initial_E21)/step_E21+1,1);
gain_e_hh_TM=zeros((final_E21-initial_E21)/step_E21+1,1);
gain_e_hh_TM_max=zeros((final_E21-initial_E21)/step_E21+1,1);
gain_TM=zeros((final_E21-initial_E21)/step_E21+1,1);
gain_TM_max=zeros((final_E21-initial_E21)/step_E21+1,1);
 
energy=zeros((final_E21-initial_E21)/step_E21+1,1);
 
j=0;
for E21=initial_E21:step_E21:final_E21
    j=j+1;

%Light holes
E1_lh=Ev-(E21-Eg)*mrlh/mlh;
f1_elh=1/(exp(-(E1_lh-Efv)/kT)+1);
 
E2_lh=Ec+(E21-Eg)*mrlh/me;
f2_elh=1/(exp((E2_lh-Efc)/kT)+1);
if E21 < E2
    rhorelh_E21=0;
elseif ( (E21 >= E2) && (E21 < E4) ) 
    rhorelh_E21=rhorelh;
else
     rhorelh_E21=2*rhorelh; 
end
gain_e_lh_TE_max(j)=(pi^2*q^2*hbar*Mlh_TE*rhorelh_E21/(ni*e0*c*mo^2*(E21*1.6*10^-19)))/100;
gain_e_lh_TE(j)=gain_e_lh_TE_max(j)*(f2_elh-f1_elh);
gain_e_lh_TM_max(j)=(pi^2*q^2*hbar*Mlh_TM*rhorelh_E21/(ni*e0*c*mo^2*(E21*1.6*10^-19)))/100;
gain_e_lh_TM(j)=gain_e_lh_TM_max(j)*(f2_elh-f1_elh);

%Heavy holes
E1hh=Ev-(E21-Eg)*mrhh/mhh;
f1_ehh=1/(exp((E1hh-Efv)/kT)+1);
 
E2hh=Ec+(E21-Eg)*mrhh/me;
f2_ehh=1/(exp((E2hh-Efc)/kT)+1);
if E21 < E1
    rhorehh_E21=0;
elseif ( (E21 >= E1) && (E21 < E3) ) 
    rhorehh_E21=rhorehh;
else
     rhorehh_E21=2*rhorehh; 
end
gain_e_hh_TE_max(j)=(pi^2*q^2*hbar*Mhh_TE*rhorehh_E21/(ni*e0*c*mo^2*(E21*1.6*10^-19)))/100;
gain_e_hh_TE(j)=gain_e_hh_TE_max(j)*(f2_ehh-f1_ehh) ;
gain_e_hh_TM_max(j)= (pi^2*q^2*hbar*Mhh_TM*rhorehh_E21/(ni*e0*c*mo^2*(E21*1.6*10^-19)))/100;
gain_e_hh_TM(j)=gain_e_hh_TM_max(j)*(f2_ehh-f1_ehh);
 
gain_TE(j)=gain_e_lh_TE(j)+gain_e_hh_TE(j);
gain_TE_max(j)=gain_e_lh_TE_max(j)+gain_e_hh_TE_max(j);
gain_TM(j)=gain_e_lh_TM(j)+gain_e_hh_TM(j);
gain_TM_max(j)=gain_e_lh_TM_max(j)+gain_e_hh_TM_max(j);
 
energy(j)=E21;

end
end
