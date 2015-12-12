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
    end
end

