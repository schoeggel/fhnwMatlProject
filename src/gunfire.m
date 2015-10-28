function [impactposX, impactposY, hit] = gunfire (playernr, startY, fireAngle, power)
% in ArtilleryMain integriert, weil beim Schuss auch noch das Terrain
% verändert wird.

playernr
startY
fireAngle
power

% alter comet zu testzwecken
%t = 0:1/290:pi;
%x = 15:1:290;
%y = startY +220*sin((rand+2+(1-power))*t);
%comet(x,y)

gunposX=player1.posX-7;
gunposY=player1.posY +3;
t=[gunposX:1:1000-gunposX];

% Wurparabel : TODO geht noch nicht...

%für debug einschlag krater testen: gerade von oben nach unten
x=ones(1,size(t,2))*((90.1-fireAngle)/90)*1000;
y=1000-t;
plot(x,y);



% collision detection 
% 'in' und 'on' sind wie eine maske für die x und y punkte.
% um den Einschlag zu detektieren, muss einfach die erste davon verwendet
% werden, die 1 und nicht 0 ist.
[in,on]= inpolygon(x,y,terrainshapeX,terrainshapeY); % on line points: unwichtig
on=[];
plot(x(in),y(in),'r+') % points inside
impactindex=find(in,1,'first')   % erster index innerhalb des terrain-polygons
impactposX=x(impactindex)
impactposY=y(impactindex)
hit = 0;
end
