function [fdiff,fshift,yshift,yf]=hifftmethod(t0,spread,nsteps,freq)
Ts=1;
n = 1:Ts:nsteps;  % Time vector

%t gia na to ferw sthn ta3h megethous tou t0 me synoriakes:
% % t(nmax/2)=t0 kai t(1)=0
% t=2*t0/(nsteps-2)*(n-1);
t=linspace(0,2*t0,nsteps);
% t0->kati*t0, allazontas thn prwti synoriaki ousiastika
% times=8;
% t=t*times;
% fs_time einai to sampling frequency
fs_time=1/t(2);
%pulse plot time domain
pulse=exp(-.5*((t-t0)/spread).^2).*sin(2*pi*freq*t);
x=pulse;
figure;
plot(t,x)
xlabel('Time(s)')
ylabel('Magnitude');
annotation('textbox',...
    [0.6 0.5 0.2 0.3],...
    'String',{['spread = ' num2str(spread, '%e' )],...
    ['t0 = ' num2str(t0, '%e' )],['nsteps = ' num2str(nsteps, '%e' )]},...
    'FontSize',10,...
    'FontName','Arial',...
    'LineStyle','--',...
    'FitBoxToText','on');
figure;

% fft transform
y = fft(x)/sqrt(nsteps)./max(fft(x)/sqrt(nsteps));  
f = (0:length(y)-1)*fs_time/length(y);
length(y)
% plot(f,abs(y));
% figure;
% zero-centered, circular shift on the transform
n = length(x);
fshift = (-n/2:n/2-1)*(fs_time/n);
yshift = fftshift(y); 
plot(fshift,abs(yshift))
xlabel('Frequency (Hz)')
ylabel('Magnitude');
% axis([0 ceil(abs(max(fshift))) -ceil(abs(max(yshift))) ceil(abs(max(yshift)))]);

% algorithm for gaussian/sinusoidal pulses. Completed, only bugs could ruin my enthusiasm.
yshift_diff(length(yshift))=0;
fshift_diff(length(fshift))=0;
yshift_diff_perc(length(yshift))=0;
%for the diff
for i=(length(yshift)/2+ mod(length(yshift)./2,2)+1):length(yshift)-1
    yshift_diff(i)=abs(abs(yshift(i+1))-abs(yshift(i)));
    fshift_diff(i)=fshift(i+1)-fshift(i);    
end
% for the diff of the diff
yshift_diff_perc(length(yshift))=0;
for j=(length(yshift)/2+ mod(length(yshift)./2,2)+1):length(yshift)-1
    yshift_diff_perc(j)=abs(abs(yshift_diff(j+1))-abs(yshift_diff(j)));
end
yshift_diff_perc(isinf(yshift_diff_perc)|isnan(yshift_diff_perc)) = 0;
%yf:index of highest chance in curve
maxer=max(yshift_diff_perc);
finder=find(sort(yshift_diff_perc)==maxer)-1;
yf=max(find(yshift_diff_perc==maxer));
lowerfinder=sort(yshift_diff_perc);
    %to 0.1*max(abs((yshift))) einai ena orio apla gia na brw kampylotita
    %me elaxisto kai oxi me megisto
    %to finder briskei to index tou enos mikroterou stoixeiou toy sorted
    %yshift_diff_perc
    %to lowerfinder briskei thn timh toy yshift_diff_perc
    % aristera thelw na einai mikrotero tou 50% enw de3ia thelw na eimai se
    % syxnotites megalyteres apo thn deyteri kampana
while (abs(yshift(find(yshift_diff_perc==maxer)))>= 0.01*max(abs((yshift)))) || ((yf>(floor(length(fshift)*0.96))) || (yf<ceil(length(fshift)*0.04)))
    finder=find(sort(yshift_diff_perc)==maxer)-1;
    maxer=lowerfinder(finder);
    yf=max(find(yshift_diff_perc==maxer));
    yf
end
fmax=abs(fshift(yf));
if fmax<freq
    fmax=abs(freq-fmax)+freq;
end
yf=max(find(abs(fshift)<fmax));
yf
if yf>=length(yshift)
    fmax2=fmax;
else
   fmax2= abs(fshift(max(find(abs(yshift)>0.1*abs(yshift(yf))))));
end
fdiff=(abs(fmax2-freq)/freq+1);
fdiff
fmax=freq*fdiff; 
fmax
axis([0 2*fmax -ceil(abs(max(yshift))) ceil(abs(max(yshift)))]);
    annotation('textbox',...
    [0.5 0.6 0.2 0.3],...
    'String',{['freq = ' num2str(freq,'%e')],['fmax = ' num2str(fmax*2*pi,'%e')],['fdiff = ' num2str(fdiff)]},...
    'FontSize',10,...
    'FontName','Arial',...
    'LineStyle','--',...
    'FitBoxToText','on');
end