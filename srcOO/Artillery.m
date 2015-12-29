function [] = Artillery()
clear;
close all;


param = GameParameter;  % Instanz GameParameter erzeugen
state = GameStates;         % Instanz GameStates erzeugen

screen = Figure(state, param);
screen.drawMenue();
waitfor(screen.getFig());

     
   

    %%Speilfeld Erzeugen
    gameScreen = Figure(state,param);
    gameScreen.drawGamescreen();
    %% Landschaft Erzeugen und Zeichnen
    lndsc = Landscape(param);
    lndsc.genLandscape();
    terrain =  lndsc.getLandscape();
    gameScreen.drawInScreen(terrain);
    
    %% Spielelemente Erzeugen
    
    
        %% Loop Speieler Erstellen und Zeicjnen
        
    for iCount = 1 : 1 : param.playerQuantety
        player(iCount) = Player(iCount, ['CrashTestDummy>> ', num2str(iCount)], 'artillery', param );
        player(iCount).genTank;
        player(iCount).posTank(lndsc, param);
        tank = player(iCount).getTank;
        gameScreen.drawElement(tank);
    end
    
    %% Wetter Erstellen
    weth = Wether(param);
    windShape = gameScreen.drawElementCol(weth.getWindShape,weth.getWindShapeColor);
    
    %% Start Spiel
    
    %% Wetter Ermitteln
    weth.updateWether;
    gameScreen.updateElementCol(windShape, weth.getWindShape,weth.getWindShapeColor);
    %% Zug ermitteln
    round(rand * param.playerQuantety);
    
    % Taktik oder Geschicklichkeit
    % Mode Laden + Anzeigen
    if param.numberMode == 1;
        gameScreen.drawGameButtons();
    else
        gameScreen.drawPowerBar();
    end
    
    fire = 0;
    if param.numberMode == 1;
        waitFor(gameScreen.Fire)
        gameScreen.getPower;
        gameScreen.getAngle;
    else   
        %% Warten auf eingabe
        %Polling schleife. Falls Mouse down, zählt die Powerbar nach oben
       while fire == 0 
            powertimer = 0;
            pause(0.01);
            if mousedown
               powertimer = powertimer * 1.02 + 1.5;
               updatePowerBar(POWERTIMER/180);
            end
            if mouseUp
                angle = gameScreen.getAngle();
                power = powertimer;
                fire = 1;
            end
        end
             
    end
    
    %% Schuss Rechnen
    shot = FlightPath();
    coordinate = shot.calcCoordinates(power, angle , weth,lndsc, player(1));
    %state.getActualPlayer
    comet(coordinate(1,:),coordinate(2,:));
    %% Treffer ermitteln
    shot.isHit(player,2)
    
    %% Schuss Zeichnen
    lndsc.terrainArray = gameScreen.drawImpactCircle(lndsc.getLandscape, shot.impact);
    terrain =  lndsc.getLandscape();
    gameScreen.updateInScreen(terrain);
     
    
end

