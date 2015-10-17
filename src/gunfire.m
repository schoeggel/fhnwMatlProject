function [impactpos hit] = gunfire (playernr, mousepos, power)
% Stub

t = 0:1/280:pi;
x = 11:1:290
y = terrainshapeY(5) + 10 +180*sin(4*t);
comet(x,y)


impactpos = 100;
hit = 0;
end