classdef Wether < handle
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        gameParameter
        wind;
    end
    
    methods
        function [this] = Wether(GameParameter)            
            %% v von wind wird in m/s berechnetMittelwert 0 Normalverteilt
            this.gameParameter = GameParameter;
            this.wind = randn() * 10 * this.gameParameter.numberWind;
        end
        
        function [] = updateWether(this)
            this.wind = this.wind + (this.wind / 100 * randn() * 10 * this.gameParameter.numberWind);
        end
        
        function [windVektor] = getWindShape(this)
            x = [0, 60, 60, 210, 210, 60, 60 ,0];
            y = [0 , -45, -15, -15 ,15, 15, 45, 0];
            x = x * this.wind / 50;
            x = x + this.gameParameter.PLOT_W - (max(x)+10);
            y = y + this.gameParameter.PLOT_H - (max(y)+10);
            windVektor = [x;y];
        end
        
        function [windShapeColor] = getWindShapeColor(this)
            if this.wind > 90;
                windTemp = 1;
            else
                windTemp = abs(this.wind/90);
            end
            r = windTemp;
            g = 1-windTemp;
            b = 0;
            windShapeColor = [r,g,b];
        end

    end
    
end

