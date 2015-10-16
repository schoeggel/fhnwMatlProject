function [x y] = genPlayer(nr)
%GENPLAYER Summary of this function goes here
%   Detailed explanation goes here
% Liefert [x y] des panzers. 
% wenn nr >1 dann ist der panzer invers (Player L und Player R)

%simpler "panzer":
if nr <1
    x=[0 4 4 2 2 0 0];
    y=[0 0 3 3 5 5 0];
else
    x=[0 -4 -4 -2 -2 0 0]
    y=[0 0 3 3 5 5 0]
end

end


