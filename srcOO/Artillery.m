function [] = Artillery()
clear;
close all;


param = GameParameter;      % Instanz GameParameter erzeugen
state = GameStates;         % Instanz GameStates erzeugen

screen = Figure(state, param);
screen.drawMenue();
waitfor(screen.getFig());
 
   
    %% Spielelemente Erzeugen
    
    
    %% Loop Speieler Erstellen und Zeicjnen
        
    for iCount = 1 : 1 : param.playerQuantety
        player(iCount) = Player(iCount, ['CrashTestDummy>> ', num2str(iCount)], 'artillery', param );
    end
       
    
    %% Start Spiel
    while state.getGameRound < param.numberRounds
        %%Speilfeld Erzeugen
        gameScreen = Figure(state,param);
        gameScreen.drawGamescreen();
        
        state.setPlayerInGame(param.playerQuantety);
            
        %% Landschaft Erzeugen und Zeichnen
        lndsc = Landscape(param);
        lndsc.genLandscape();
        terrain =  lndsc.getLandscape();
        gameScreen.drawInScreen(terrain);
        
        gameScreen.drawPlayserPoints(param, player);
        gameScreen.drawGameRound(param, state);
        
        
        for iCount = 1 : 1 : param.playerQuantety
            player(iCount).genTank;
            player(iCount).posTank(lndsc, param);
            tank = player(iCount).getTank;
            player(iCount).tankHandler = gameScreen.drawElementCol(tank,player(iCount).getTankColor);     
        end
        
        %% Wetter Erstellen
        weth = Wether(param);
        windShape = gameScreen.drawElementCol(weth.getWindShape,weth.getWindShapeColor);
    
    

        %% Zug ermitteln
        state.setActualPlayer(round((rand) * (param.playerQuantety-1))+1);

        % Taktik oder Geschicklichkeit
        % Mode Laden + Anzeigen
        if param.numberMode == 1;
            gameScreen.drawGameButtons();
        else
            gameScreen.drawPowerBar();
        end

        roundEnd = 0;

        while roundEnd == 0;
    %% Wetter Ermitteln
            weth.updateWether;
            gameScreen.updateElementCol(windShape, weth.getWindShape,weth.getWindShapeColor);

            gameScreen.drawActualPlayer(state, player(state.getActualPlayer).getTankColor);
            fire = 0;
            power = 1000;
            angle = 45;
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
               powertimer = 0;
               while fire == 0 
                    pause(0.01);
                    while gameScreen.mousedown == 1   
                       powertimer = powertimer * 1.005 + 0.25;
                       gameScreen.updatePowerBar(powertimer/180);
                       fire = 1;
                       angle = player(state.getActualPlayer).calcAngle(gameScreen.mouseX,gameScreen.mouseY);    
                       power = powertimer * 200;
                       pause(0.000001);  
                    end
                end

            end

            %% Schuss Rechnen
            shot = FlightPath();
            if mod(state.getActualPlayer, 2) == 0;
                angle = 180 - angle;
            end  

            try 
                coordinate = shot.calcCoordinates(power, angle , weth, lndsc, player(state.getActualPlayer));
            catch
            end
            
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
        state.nextGameRound(param);
        
        for iCount = 1 : 1 : param.playerQuantety
            player(iCount).livePoints = GameParameter.getStandardLivePoints;
        end
        
        fig = gameScreen.getFig();
        fig.delete;
    end

end

