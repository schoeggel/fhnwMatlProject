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
    % Taktik oder Geschicklichkeit
    
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
    round(rand * param.playerQuantety)
    
    %% Spieler Anzeigen
    
    %% Warten auf eingabe
    
    %% Schuss Rechnen
    shot = FlightPath();
    coordinate =   shot.calcCoordinates(4000,45,weth,lndsc,player(state.getActualPlayer));
    comet(coordinate(1,:),coordinate(2,:));
    %% Treffer ermitteln
    
    %% Schuss Zeichnen
    
end

