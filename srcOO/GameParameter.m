classdef GameParameter < handle 
    %UNTITLED3 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        
    end
    
    properties (GetAccess=public)
        standardLivepoints = 100;
        playerQuantety = 2;
        maxPlayerQuantety = 6;
        planet = 'Planet>> earth';
        numberPlanet = 1;
        gForce = 9.81;
        gameMode = 'Game Mode>> tactics';
        numberMode = 1;
        wind = 'Wind>> medium';
        numberWind = 2;
        windMultiplicator; % für Planeten vorgesehen
        atmosphere;        % für Planeten vorgesehen
        mountain = 'Mountains>> medium';
        numberMountain = 2;
        
        %% Landscape Constants
        % resolution = [x] <== auf diese x-auflösung wird gestreckt/interpoliert.
        % Iteration muss zwingend >= 1 sein. im ersten Druchlauf werden 3
        % Ecken des Berges gesetzt (Linker Rand, Mitte(Berg) und  rechter Rand)
        % im 4. Durchlauf werden Korrekturen vorgenommen, Enden flächer etc.
        RESOLUTION = 1;
        % JITTER: Random Abweichung der zwischenschritte
        % um diesen Zufallsbereich weicht der Geländepunkt vom Mittelwert der
        % seiner Nachbarn ab (100 heisst, der Punkt kann um +- 50 abweichen)
        JITTER = 40;            % maximalabweichung vom mittelwert der 2 nachbarn, wenn ein neuer punkt gerechent wird
        JITTERBALANCE = 0.75;   %0.5 bedeutet, der Jitter ist nach oben und unten gleich verteilt. 1= 100% nach oben.
        DAEMPFUNG= 1.4;         %Jitter wird nach jeder iteration gedämpft        
        BERGOFFSET = 55;        % wie viel höher ist die Bergspitze
        YLIMITS = [5 200];       % Keine Punkte ausserhalb [von bis] zugelassen. 
        PLATFORMOFFSET=+5;      % die spieler-orte // 
        POSTSMOOTHING= 10;      % unterhalb bergrenze wird nachträglich geglättet
        FELSUEBERGANG=[50 70];% zwischen 60 und 90 Höhe passiert der Felsübergang, keine Glättung mehr
        max_iterations=6;       % auf 6 stehen lassen! Erzeugt polygon mit (3+2^max_iterations) Ecken

    end
    

    methods
        function [this] = GameParameter()
            
        end
        
        function this = setPlanet(this)
            switch this.numberPlanet
                case 1
                    this.planet = 'Planet>> Earth';
                    this.gForce = 9.81;
                case 2
                    this.planet = 'Moon>> Moon';
                    this.gForce = 9.81;
                case 3
                    this.planet = 'Planet>> Mars';
                    this.gForce = 9.81;
                case 4
                    this.planet = 'Jupiter Moon>> Europa';
                    this.gForce = 9.81;
                case 5
                    this.planet = 'Jupiter Moon>> Ganymed';
                    this.gForce = 9.81;
                case 6
                    this.planet = 'Jupiter Moon>> Io';
                    this.gForce = 9.81;
                case 7
                    this.planet = 'Jupiter Moon>> Callisto';
                    this.gForce = 9.81;
                case 8
                    this.planet = 'Saturn Moon>> Iapetus';
                    this.gForce = 9.81;
                case 9 
                    this.planet = 'Saturn Moon>> Titan';
                    this.gForce = 9.81;
                case 10
                    this.planet = 'Rosettas Comet>> Juri';
                    this.gForce = 9.81;
                case 11 
                    this.planet = 'Dwarfplanet>> Pluto';
                    this.gForce = 9.81;   
                case 12
                    this.planet = 'Exoplanet>> Ypsilon Andromedae c';
                    this.gForce = 9.81;
                case 13 %Gliese 1214 b
                    this.planet = 'Exoplanet>> Gliese 1214 b';
                    this.gForce = 9.81;
                    this.numberPlanet = 0;
                otherwise
                    this.numberPlanet = 0;
            end                    
        end
        function this = nextPlanet(this)
            this.numberPlanet= this.numberPlanet+1;
            this.setPlanet();
        end 
        function this = nextWind(this)
            this.numberWind = this.numberWind + 1;
            switch this.numberWind
                case 1
                    this.wind = 'Wind>> low';

                case 2
                    this.wind = 'Wind>> medium';

                case 3
                    this.wind = 'Wind>> high';
                    this.numberWind = 0;
                otherwise
                    this.numberWind = 0;
            end
        end 
        function this = nextMountain(this)
            this.numberMountain = this.numberMountain + 1;
            switch this.numberMountain
                case 1
                    this.mountain = 'Mountains>> low';

                case 2
                    this.mountain = 'Mountains>> medium';

                case 3
                    this.mountain = 'Mountains>> high';
                    this.numberMountain = 1;
                otherwise
                    this.numberMountain = 1;
            end
        end 
        function this = nextMode(this)
            this.numberMode = this.numberMode + 1;
            switch this.numberMode
                case 1
                    this.gameMode = 'Game Mode>> tactics';
                case 2
                    this.gameMode = 'Game Mode>> agilety';
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

