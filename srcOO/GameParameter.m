classdef GameParameter
    %UNTITLED3 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        
    end
    
    properties (GetAccess=public)
        standardLivepoints = 100;
        playerQuantety = 2;
        planet = 'earth';
        gForce = 9.81;
    end
    

    methods
        function this = GameParameter()
        end
        
        function setPlanet(strPlanet)
            switch strPlanet
                case 'earth'
                case 'moon'
                case 'mars'
                case 'europa'   
                otherwise
            end                    
        end
        
        function [] = setPlayerQuantety(this, playerQuantety)
            this.playerQuantety = playerQuantety;
        end
        
        function [standardLivePoints] = getStandardLivePoints(this)
        standardLivePoints = this.standardLivepoints;
        end
    end
    
end

