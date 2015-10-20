function [x y] = genPlayer(nr)
%GENPLAYER Summary of this function goes here
%   Detailed explanation goes here
% Liefert [x y] des panzers. 
% wenn nr >1 dann ist der panzer invers (Player L und Player R)

%simpler "panzer":
 x=[0 10 10 4  4  3  8  7  2  0  0];
    y=[0  0  6 6  10 10 16 17 10 10 0];
    x=x-4;  % in mitte positionieren
    y=y-0;  % soll unten aufliegen

if nr >1    %player 2 spiegeln
  x=-x
else

end


