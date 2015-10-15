function [Windshape windspeed] = genWind()
%GENWIND Summary of this function goes here
%   Detailed explanation goes here
% Vektor für Windfahne
% Windgeschwindigkeit wird ermittelt (Zufall -1 bis +1)

Windshape=[0 4 0 0; 0 1 2 0];
windspeed = 2*rand-1;

end

