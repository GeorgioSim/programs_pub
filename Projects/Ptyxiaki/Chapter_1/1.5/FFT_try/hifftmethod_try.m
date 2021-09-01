function fdiff=hifftmethod_try(t0,spread,freq_in)

% Gaussian pulse
%t0=20;
%spread=8;
%e3etazw kai prosarmozw thn syxnotita analoga kai me to Ts
%freq_in_max=4e4
%freq_in=400;
%machine time Ts = 0.00001 minimum
    Ts = 0.00001;
    T=50;
    check=Ts*freq_in;
    fs = 1/Ts;   % Sampling frequency
    t = 1:Ts:T;  % Time vector 
    L = length(t);      % Signal length
N=freq_in*max(t);
while (N>ceil(N)+1 | N<ceil(N)-1) | N==ceil(N)
while check<0.05
    T=T*1.02;
    Ts=Ts*1.02;
    clear check;
    check=Ts*freq_in;
    clear fs;
    clear t;
    clear L;
    clear N;
    fs = 1/Ts;   % Sampling frequency
    t = 1:Ts:T;  % Time vector 
    L = length(t);      % Signal length


    % Kykloys syxnothtas
    N=freq_in*max(t);
end
end
N
%pulse=sin(2*pi*freq_in*t);
%pulse=exp(-.5*((t-t0)/spread).^2);
pulse=exp(-.5*((t-t0)/spread).^2).*sin(2*pi*freq_in*t);
x=pulse;
figure;
plot(t,x);
figure;
% fft transform
y = fft(x);  
f = (0:length(y)-1)*fs/length(y);
%plot(f,abs(y));
% zero-centered, circular shift on the transform
n = length(x);                         
fshift = (-n/2:n/2-1)*(fs/n);
yshift = fftshift(y); 
plot(fshift,abs(yshift))
xlabel('Frequency (Hz)')
ylabel('Magnitude');

% algorithm for gaussian/sinusoidal pulses. Almost Completed.
yshift_diff(length(yshift))=0;
fshift_diff(length(fshift))=0;
%for the diff
for i=1:length(yshift)-1
    yshift_diff(i)=abs(abs(yshift(i+1))-abs(yshift(i)));
    fshift_diff(i)=fshift(i+1)-fshift(i);
end
% for the diff of the diff
yshift_diff_perc(length(yshift))=0;
for j=1:length(yshift)-1
    yshift_diff_perc(j)=abs(abs(yshift_diff(j+1))-abs(yshift_diff(j)))/abs(yshift_diff(j));
end
    %yf:index of highest chance in curve
    yf=find(yshift_diff_perc==max(yshift_diff_perc));
fmax=abs(fshift(yf));
if fmax<freq_in
    fmax=abs(freq_in-fmax)+freq_in;
end

fmax
yf=max(find(abs(fshift)<fmax));
fdiff=(abs(fmax-freq_in)/freq_in+1);
fdiff
    
%extender: indexes with yshift lower than 0.5% of yfshift(yf). Needs fixing
%extender=find(abs(yshift)>0.5*abs(yshift(yf)));
%yf2=max(extender);
%fmax2=abs(fshift(yf2));
%      fmax2

if yf>=length(yshift)
    fmax2=fmax;
    fmax2
    axis([-abs(fshift(yf)) abs(fshift(yf)) -ceil(abs(max(yshift))) ceil(abs(max(yshift)))]);
else
   fmax2= abs(fshift(max(find(abs(yshift)>0.1*abs(yshift(yf))))));
   fmax2
   axis([-abs(fshift(yf+1)) abs(fshift(yf+1)) -ceil(abs(max(yshift))) ceil(abs(max(yshift)))]);
end
    fdiff=(abs(fmax2-freq_in)/freq_in+1);
    fdiff
    fmax=freq_in*fdiff; 

% Cell size and time stepping
%c0=3.e8;
%lambdamin=c0/fmax;
%dx=lambdamin/10;
%dt=dx/(2.*c0);
% Constants
%cc=c0*dt/dx;
%dt

end