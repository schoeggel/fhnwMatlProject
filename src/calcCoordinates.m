function [] = calcCoordinates()
format long;

%% Parameter
%
%
% Der winkel in Grad und Rad
% 
% $$ang_{rad} = \pi  \frac{ang_{deg}}{180}$$
% 
angle = 45;
angRad = pi() * angle/180

%% Berechnung der Abbschussgeschwindigkeit
% 
% $$Energie Projektil: E_{prj} \ Geschwindigkeit Projektil: v_{prj} \ Msse Projektil: m_{Projektil}$$
% 
% $$Wirkungsgrad Kanon: n_{can} Energie Treibladung $$
%
% $$E_{prj} = \frac{m_{prj}}{2} v_{prj}^{2}$$
%
% $$E_{prj} = E_{trbl} * n_{can}$$
%
% $$v_{prj} = \sqrt{ \frac{2 E_{prj}}{m_{prj}}}$$
%
masseProjektil = 1;
energieTreibladung = 2000;
wirkungsGradKanone = 20;
masseKanone = 10000;

vStart = 100;
vxStart = cos(angRad) * vStart;
vyStart = sin(angRad) * vStart;
tmax = 8;

g = 9.81;

    
    For t = 0 : .1 : tmax
    
    vx = (vxStart) - integral(sqrt(vx.^2 + vy.^2)*koeff;
    vy=  (vyStart) - g * t;
    v = sqrt(vx.^2 + vy.^2);
    
    
    x = (vxStart) * (t);
    y = (vyStart * t) - g * (t).^2;
    end
    comet(x,y)
    comet(vx,vy)
    
end
    

end

