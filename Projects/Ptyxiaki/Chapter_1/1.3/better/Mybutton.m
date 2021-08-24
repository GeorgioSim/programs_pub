function [ex,spread]=Mybutton(ks,t,t0,ex,spread)
[ex,spread]=pulse(ks,t,t0,ex,spread);
[ex,spread]=slider(ks,t,t0,ex,spread);
end

function [ex,spread]=slider(ks,t,t0,ex,spread)
x=1:length(ex);
y = ex;
% Initialize the plot window
fig1=uifigure;
ax1 = uiaxes('Parent',fig1,...
            'Units','pixels',...
            'Position', [104, 123, 300, 201]);
hplot = plot(ax1,x,y);
% Initialize the control window
fig = uifigure;
cg = uigauge(fig,'circular','Position',[100 100 120 120]);
sld = uislider(fig,...
               'Position',[100 75 120 3],...
               'ValueChangingFcn',@(sld,event) sliderMoving(sld,event,x,y,hplot,cg,ks,t,t0,ex,spread));
sld.Limits = [0 100];
sld.Value = spread;

btn = uibutton(fig,'push',...
               'Position',[420, 218, 100, 22],...
               'ButtonPushedFcn', @(btn,event) plotButtonPushed(btn,sld,fig,ks,t,t0,ex,spread));

uiwait(fig)
ex=get(hplot,'ydata');
spread = get(sld,'Value');
close(fig)
close(fig1)
end

% Create the function for the ButtonPushedFcn callback
function plotButtonPushed(btn,sld,fig,ks,t,t0,ex,spread)
% Read spread value from slider
n = get(sld,'Value');
spread=n;
% Calculate ex
[ex,spread]=pulse(ks,t,t0,ex,spread);
% Return ex,spread 
uiresume(fig)
end

% Create ValueChangingFcn callback
function sliderMoving(sld,event,x,y,hplot,cg,ks,t,t0,ex,spread)
cg.Value = event.Value;
n = get(sld,'Value');
spread=n;
[ex,spread]=pulse(ks,t,t0,ex,spread);
set(hplot,'ydata',ex);
end


