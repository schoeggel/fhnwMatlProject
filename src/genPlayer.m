function [x y] = genPlayer(nr)
%GENPLAYER Summary of this function goes here
% Detailed explanation goes here
% Liefert [x y] des panzers. 
% wenn nr >1 dann ist der panzer invers (Player L und Player R)

%simpler "panzer":
 x=[0 10 10 4 4 3 8 7 2 0 0];
 y=[0 0 6 6 10 10 16 17 10 10 0];
 x=x-4; % in mitte positionieren
 y=y-0; % soll unten aufliegen

 PanzerScale=0.5;
 %besserer Panzer:
 x=[30 80 91 91 83 86 86 76 62 61 60 60 58 52 46 10 11 5  0  6  7  43 43 29 21 21 30];
 y=[0  0  6  14 14 17 19 28 28 30 30 34 34 30 26 48 49 53 47 43 44 22 15 14 11 8  0 ];
 x=PanzerScale*x;
 y=PanzerScale*y;
 x=x-max(x)/1.4;          % Panzerbody auf die Playerpos zentrieren (horizontale)
 
if nr <1 %player spiegeln
 x=-x
else

end


