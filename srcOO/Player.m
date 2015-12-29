classdef Player < handle
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties(GetAccess = public)
        number;
        name;
        livePoints;
        score;
        tankType;
        positionXY;
        tankArray;
        
        
    end
    
    methods
        function this = Player(number, name, tankType, GameParameter)
            this.number = number;
            this.name = name;
            this.livePoints = GameParameter.getStandardLivePoints;
            this.score = 0;
            this.tankType = tankType;
            this.positionXY = [0,0];
            
        end
        
        function [] = genTank(this)
            %GENPLAYER Summary of this function goes here
            % Detailed explanation goes here
            % Liefert [x y] des panzers. 
            % wenn nr >1 dann ist der panzer invers (Player L und Player R)

             panzerScale = 0.5;
             %besserer Panzer:
             x=[30 80 91 91 83 86 86 76 62 61 60 60 58 52 46 10 11 5  0  6  7  43 43 29 21 21 30];
             y=[0  0  6  14 14 17 19 28 28 30 30 34 34 30 26 48 49 53 47 43 44 22 15 14 11 8  0 ];
             x = panzerScale*x;
             y = panzerScale*y;
             x= x-max(x)/1.4;           	% Panzerbody auf die Playerpos zentrieren (horizontale)

            if mod(this.number,2) ~= 0       %player spiegeln
                x=-x;
            end
            
            this.tankArray = [x;y];
        
        end
        
        
        function [] = posTank(this, Landscape, GameParameter)
            terrain = Landscape.getLandscape();
            if mod(this.number, 2) == 0
                value = length(terrain) - round(rand() * length(terrain)* GameParameter.maxTankPos);
            else
                value = round(rand() * length(terrain)* GameParameter.maxTankPos);
            end
            this.positionXY = terrain(:,value);
            
            this.tankArray(1,:) =  this.tankArray(1,:) + this.positionXY(1,1);
            this.tankArray(2,:) =  this.tankArray(2,:) + this.positionXY(2,1);
        end
        
        function  [tankArray]= getTank(this)
            tankArray = this.tankArray;
        end
        
    end
end

