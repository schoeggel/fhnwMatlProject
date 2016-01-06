%%  Class Header

%   Class Name: GameParameter.m
%   Call: name = GameParameter()
%
%   Zweck: In der Instanz dieser Klasse werden alle vom Spieler
%   veränderbaren (oder welche es einmal sein könnten) Parameter
%   gespeichert. Die Modifikation der Parameter über das Menue 
%   erfolgt in Instanzen dieser Klasse

%% Changelog
% * Version 00.00.13  12.11.15  Raphael Waltenspül    Menu zur eingabe von
% Parametern erstellt
% * Version 00.01.00  22.11.15  Raphael Waltenspül    Umbau in
% Objektoriert erfogt
% * Version 00.01.01  12.11.15  Raphael Waltenspül    Menu zur eingabe von
% Parametern erweitert auf Objektorientiert
% * Version 00.01.02  10.12.15  Raphael Waltenspül   Neu Erstellen der
% Handle Classes GameParameter, Gamestates, Wether
% * Version 00.01.11  02.01.16  Raphael Waltenspül   Aufräumen fertigstellen
% Gameablauf
% * Version 01.00.00b  03.01.16  Raphael Waltenspül   Buglist Testen
% Kommentieren Dokumentieren

%%  Input und Output
% für Methoden, siehe Methoden

%   Konstruktor:   void
%   Precondition:  
%
%   Postcondition: Ein GameParameter Instanz ist erstellt
%   
%	Variables:
%       Für Instanzvariabeln siehe Properties
%
%%   Implementierte Methoden

% [this] = GameParameter()
% this = setPlanet(this)
% this = nextPlanet(this)
% this = nextWind(this)
% this = nextMountain(this)
% this = nextMode(this)
% [this] = setPlayerQuantety(this, playerQuantety)
% [standardLivePoints] = getStandardLivePoints(this)
%
%% Buglist TODO / this

%Classdef
classdef GameParameter < handle 
    properties (GetAccess=public)
        standardLivepoints = 100; % Stadarwert der Lebenspunkte eines Spieler
        playerQuantety = 2; % Stadarwert der Anzahl Mitspieler
        maxPlayerQuantety = 6; % Stadarwert der maximalen Anzahl Mitspiele
        planet = 'Planet>> earth'; % Stadarwert des gewählten Planetes Text
        numberPlanet = 1; % Stadarwert des gewählten Planetes Nummer
        gForce = 9.81; % Anziehung des gewählten Planetes -- Wirksam in späterer Version
        gameMode = 'Game Mode>> tactics'; % Stadarwert des gewählten Spielmodes Text
        numberMode = 1; % Stadarwert des gewählten Spielmodes Nummer
        wind = 'Wind>> medium'; % Stadarwert des gewählten Windstärke Text
        numberWind = 2; % Stadarwert des gewählten Windstärke Nummer
        windMultiplicator; % für Planeten vorgesehen -- Wirksam in späterer Version
        atmosphere;        % für Planeten vorgesehen -- Wirksam in späterer Version
        mountain = 'Mountains>> medium'; %% Stadarwert der gewählten Berhöhe Text
        numberMountain = 2; %% Stadarwert der gewählten Berhöhe Nummer
        
        numberRounds = 10; %% Stadarwert der gewählten anzah Spielrunden
        
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
        JITTERBALANCE = 0.75;   % 0.5 bedeutet, der Jitter ist nach oben und unten gleich verteilt. 1= 100% nach oben.
        DAEMPFUNG= 1.4;         %Jitter wird nach jeder iteration gedämpft        
        BERGOFFSET = 55;        % wie viel höher ist die Bergspitze
        YLIMITS = [20 200];       % Keine Punkte ausserhalb [von bis] zugelassen. 
        PLATFORMOFFSET=+5;      % die spieler-orte // 
        POSTSMOOTHING= 10;      % unterhalb bergrenze wird nachträglich geglättet
        FELSUEBERGANG=[50 70];% zwischen 60 und 90 Höhe passiert der Felsübergang, keine Glättung mehr
        max_iterations=6;       % auf 6 stehen lassen! Erzeugt polygon mit (3+2^max_iterations) Ecken
        
        detonationRadius = 20; % Stadarwert des Detonationsradios -- Wird in Späteren Versionen ev. geändert
        maxAngle = 180;        % Stadarwert des maximal einstellbaren Kanonenwinkels
        maxPower = 100000;     % Stadarwert der maximal einstellbaren Energie
        powerLimit = 100000;   % Energie welche zur Zerstörung der kanone führt
        
        PLOT_W = 1000;  % briete des Plots
        PLOT_H = 750;   % Höhe des Plots
        axisArray = [0 1000 0 750]; % Achsen Array
        
        maxTankPos = 0.3 %% in welchem Bereich der Arraylänge der tank plaziert werden darf
    
    end
    

    methods
        %% GameParameter konstruktor   
        % Zweck: Erstellt eine Instanz der GameParameter
        %
        % Pre:
        %
        % Post: Instanz GameParameter ist erstellt
        %
        % Input: void
        %
        % Output: this -- Instanz GameParameter
        %y
        %
        function [this] = GameParameter()
            
        end
        
        %% GameParameter setPlanet      
        % Zweck: Stellt den Planeten ein
        %
        % Pre: Instanz GameParameter ist erstellt
        %
        % Post: Planet ist eingestellt, Variabeln Modifiziert
        %
        % Input: Instanz GameParameter, instanzvariabeln
        %
        % Output: Instanz GameParameter, instanzvariabeln
        %
        % Modifizierte InstanzVraiabeln: 
        %   this.planet
        %   this.gForce
        %   this.numberPlanet
        %
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
                otherwise
                    this.numberPlanet = 0;
            end                    
        end
       %% GameParameter nextPlanet      
        % Zweck: Stellt den Planeten um und ruft die Einstellungsmethode
        % für den Planeten auf
        %
        % Pre: Instanz GameParameter ist erstellt
        %
        % Post: Planet ist umgestellt, Variabeln Modifiziert
        %
        % Input: Instanz GameParameter, instanzvariabeln
        %
        % Output: Instanz GameParameter, instanzvariabeln
        %
        % Modifizierte InstanzVraiabeln: 
        %   this.numberPlanet
        %
        function this = nextPlanet(this)
            if this.numberPlanet == 13
               this.numberPlanet = 0;
            end
            this.numberPlanet= this.numberPlanet+1;
            this.setPlanet();
        end 
        %% GameParameter nextWind      
        % Zweck: Stellt den Wind um
        %
        % Pre: Instanz GameParameter ist erstellt
        %
        % Post: Wind ist umgestellt, Variabeln Modifiziert
        %
        % Input: Instanz GameParameter, instanzvariabeln
        %
        % Output: Instanz GameParameter, instanzvariabeln
        %
        % Modifizierte InstanzVraiabeln: 
        %   this.wind
        %   this.numberWind 
        %
        function this = nextWind(this)
            if this.numberWind == 3
               this.numberWind = 0;
            end
            this.numberWind = this.numberWind + 1;
            switch this.numberWind
                case 1
                    this.wind = 'Wind>> low';

                case 2
                    this.wind = 'Wind>> medium';

                case 3
                    this.wind = 'Wind>> high';
                otherwise
                    this.numberWind = 0;
            end
        end 
        %% GameParameter nextMountain      
        % Zweck: Stellt die Berghöhe um
        %
        % Pre: Instanz GameParameter ist erstellt
        %
        % Post: Berghöhe ist umgestellt, Variabeln Modifiziert
        %
        % Input: Instanz GameParameter, instanzvariabeln
        %
        % Output: Instanz GameParameter, instanzvariabeln
        %
        % Modifizierte InstanzVraiabeln: 
        %   this.mountain
        %   this.numberMountain
        %   this.BERGOFFSET
        %
        function this = nextMountain(this)
            if this.numberMountain == 3
               this.numberMountain = 0;
            end
            this.numberMountain = this.numberMountain + 1;
            switch this.numberMountain
                case 1
                    this.mountain = 'Mountains>> low';
                    this.BERGOFFSET = 25;
                case 2
                    this.mountain = 'Mountains>> medium';
                    this.BERGOFFSET = 75;
                case 3
                    this.mountain = 'Mountains>> high';
                    this.BERGOFFSET = 115;
                otherwise
                    this.numberMountain = 1;
            end
        end 
        %% GameParameter nextMode      
        % Zweck: Stellt die Spielmodus um
        %
        % Pre: Instanz GameParameter ist erstellt
        %
        % Post: Spielmodus ist umgestellt, Variabeln Modifiziert
        %
        % Input: Instanz GameParameter, instanzvariabeln
        %
        % Output: Instanz GameParameter, instanzvariabeln
        %
        % Modifizierte InstanzVraiabeln: 
        %   this.numberMode
        %   this.gameMode
        %
        function this = nextMode(this)
            if this.numberMode == 2
               this.numberMode = 0;
            end
            this.numberMode = this.numberMode + 1;
            switch this.numberMode
                case 1
                    this.gameMode = 'Game Mode>> tactics';
                case 2
                    this.gameMode = 'Game Mode>> agilety';
                otherwise
                    this.numberMode = 1;
            end
        end 
        %% GameParameter setPlayerQuantety      
        % Zweck: Stellt die Spieleranzahl ein
        %
        % Pre: Instanz GameParameter ist erstellt
        %
        % Post: Spieleranzahl ist eingestellt. Variabeln Modifiziert
        %
        % Input: Instanz GameParameter, instanzvariabeln
        %  playerQuantety -- Spieler anzahl
        %
        % Output: Instanz GameParameter, instanzvariabeln
        %
        % Modifizierte InstanzVraiabeln: 
        %   this.playerQuantety
        %
        function [this] = setPlayerQuantety(this, playerQuantety)
            this.playerQuantety = playerQuantety;
        end
        
        %% GameParameter getStandardLivePoints      
        % Zweck: Stellt die Spieleranzahl ein
        %
        % Pre: Instanz GameParameter ist erstellt
        %
        % Post: standardLivePoints sind zurückgegeben
        %
        % Input: Instanz GameParameter, instanzvariabeln
        %
        % Output: Instanz GameParameter, instanzvariabeln
        %   standardLivePoints -- Standardlebenspunkte
        %
        function [standardLivePoints] = getStandardLivePoints(this)
            standardLivePoints = this.standardLivepoints;
        end
    end
    
end

