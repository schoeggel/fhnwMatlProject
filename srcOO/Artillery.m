function [] = Artillery()
clear;
close all;


param = GameParameter;  % Instanz GameParameter erzeugen
state = GameStates;         % Instanz GameStates erzeugen

screen = Figure(state, param);
screen.drawMenue();

% TODO Warten auf Menue bestätigung besser lösen...
    while(state.getProcessState == 0) % Wraten Bis Parmeter im Menue eingestellt sind
        x=1;
    end
    
    %% Landschaft Erzeugen
     
    %% Loop Speieler Erstellen
    for iCount = 1 : 1 : param.playerQuantety
        player(iCount) = Player(iCount, ['CrashTestDummy>> ', num2str(iCount)], 'artillery', param );
    end
    
    %% Wetter Erstellen
    
    
    %%Speilfeld Erzeugen
    gameScreen = Figure(state,param);
    
    %% Zeichnen
    
end

