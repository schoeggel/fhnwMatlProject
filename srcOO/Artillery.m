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
        player(iCount).tankHandler = gameScreen.drawElement(tank);
    end
    
    state.setPlayerInGame( param.playerQuantety) ;
    
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
    
    roundEnd = 0;
    
    while roundEnd == 0;
        gameScreen.drawActualPlayer(state);
        fire = 0;
        power = 1;
        angle = 1;
        if param.numberMode == 1;
            while gameScreen.fireEvent == 0;
                pause(0.1)
            end
            gameScreen.fireEvent = 0;
            power = gameScreen.getPower;
            angle = gameScreen.getAngle;
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
        if mod(state.getActualPlayer, 2) == 0;
            angle = 180 - angle;
        end    
        coordinate = shot.calcCoordinates(power, angle , weth, lndsc, player(state.getActualPlayer));
        
        %state.getActualPlayer
        comet(coordinate(1,:),coordinate(2,:));
        %% Treffer ermitteln
        
        for pk = 1 : 1 : param.playerQuantety
            if shot.isHit(player, pk) > 0
                gameScreen.deleteElement(player(pk).tankHandler);
                player(pk).livePoints = player(pk).livePoints - 100;
                if state.decreasePlayerInGame == 1
                    roundEnd = 1;
                end
            end
        end

        %% Schuss Zeichnen
        try 
            lndsc.terrainArray = gameScreen.drawImpactCircle(lndsc.getLandscape, shot.impact);
        catch IndexExceedsMatrixDimensions
              IndexExceedsMatrixDimensionsCount = 1;
        end
        terrain =  lndsc.getLandscape();
        gameScreen.updateInScreen(terrain);
        
        if state.getPlayerInGame > 1
            state.nextPlayer(param, player);
        else
            state.nextPlayer(param, player);
            player(state.getActualPlayer).score = player(state.getActualPlayer).score+1;
        end
        pause(0.1);
    end

end

