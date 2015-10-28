classdef Player
    %PLAYER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties(Access = private)
        NUMBER;
        hitpoints;
        ammunition;
        money;
        fuel;
        posXY;
        length;
    end
    
    methods
        function objPlayer = Player(number,posVektor)
            assert(number > 0, 'Imaginary Player');
            assert(posVektor)
            
             NUMBER = number;
             posXY = posVektor;
        end
        
        %% gettter
        %
        function [x] = getPosX()
                x = posXY(1,:);
        end
        function [y] = getPosy()
                y = posXY(:,1);
        end
        function [r] = posVektor()
                r = posXY;
        end
        
    end
    
end

