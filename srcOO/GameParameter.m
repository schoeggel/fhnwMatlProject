classdef GameParameter < handle 
    %UNTITLED3 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        
    end
    
    properties (GetAccess=public)
        standardLivepoints = 100;
        playerQuantety = 2;
        maxPlayerQuantety = 6;
        planet = 'earth';
        numberPlanet = 1;
        gForce = 9.81;
        gameMode = 'tactics';
        numberMode = 1;
        wind = 'medium';
        numberWind = 3;
        windMultiplicator; % für Planeten vorgesehen
        atmosphere;        % für Planeten vorgesehen
        mountain = 'medium';
        numberMountain = 2;
    end
    

    methods
        function [this] = GameParameter()
            
        end
        
        function this = setPlanet(this)
            switch this.numberPlanet
                case 1
                    this.planet = 'earth';
                    this.gForce = 9.81;
                case 2
                    this.planet = 'moon';
                    this.gForce = 9.81;
                case 3
                    this.planet = 'mars';
                    this.gForce = 9.81;
                case 4
                    this.planet = 'Europa (Moon)';
                    this.gForce = 9.81;
                case 5
                    this.planet = 'Ganymed (Moon)';
                    this.gForce = 9.81;
                case 6
                    this.planet = 'Io (Moon)';
                    this.gForce = 9.81;
                case 7
                    this.planet = 'Callisto (Moon)';
                    this.gForce = 9.81;
                case 8
                    this.planet = 'Iapetus (Mond)';
                    this.gForce = 9.81;
                case 9 
                    this.planet = 'Titan (Moon)';
                    this.gForce = 9.81;
                case 10
                    this.planet = 'Juri (Comet)';
                    this.gForce = 9.81;
                case 11 
                    this.planet = 'Pluto (Dwarfplanet)';
                    this.gForce = 9.81;   
                case 12
                    this.planet = 'Ypsilon Andromedae c';
                    this.gForce = 9.81;
                case 13 %Gliese 1214 b
                    this.planet = 'Gliese 1214 b';
                    this.gForce = 9.81;
                    this.numberPlanet = 1;
                otherwise
                    this.numberPlanet = 1;
            end                    
        end
        function this = nextPlanet(this)
            this.numberPlanet= this.numberPlanet+1;
            setPlanet();
        end 
        function this = nextWind(this)
            this.numberWind = this.numberWind + 1;
            switch this.numberWind
                case 1
                    this.wind = 'low';

                case 2
                    this.wind = 'medium';

                case 3
                    this.wind = 'high';
                    this.numberWind = 1;
                otherwise
                    this.numberWind = 1;
            end
        end 
        function this = nextMountain(this)
            this.numberMountain = this.numberMountain + 1;
            switch this.numberMountain
                case 1
                    this.mountain = 'low';

                case 2
                    this.mountain = 'medium';

                case 3
                    this.mountain = 'high';
                    this.mountain = 1;
                otherwise
                    this.mountain = 1;
            end
        end 
        function this = nextMode(this)
            this.numberMode = this.numberMode + 1;
            switch this.numberMode
                case 1
                    this.gameMode = 'tactics';
                case 2
                    this.gameMode = 'agilety';
                    this.numberMode = 0;
                otherwise
                    this.numberMode = 1;
            end
        end 
        
        function [this] = setPlayerQuantety(this, playerQuantety)
            this.playerQuantety = playerQuantety;
        end
        
        function [standardLivePoints] = getStandardLivePoints(this)
        standardLivePoints = this.standardLivepoints;
        end
    end
    
end

