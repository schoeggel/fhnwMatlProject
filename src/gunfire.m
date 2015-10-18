function [impactpos, hit] = gunfire (playernr, startY, mousepos, power)
% Stub

t = 0:1/290:pi;
x = 15:1:290;
y = startY +220*sin((rand+2+(1-power))*t);
%comet(x,y)


impactpos = 100;
hit = 0;
end