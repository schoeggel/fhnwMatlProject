function [] = Artillery()
clear;
close all;


param = GameParameter;  % Instanz GameParameter erzeugen
state = GameStates;         % Instanz GameStates erzeugen

screen = Figure(state, param);
screen.drawMenue();

    while(state.getProcessState == 0) % Wraten Bis Parmeter im Menue eingestellt sind
        x=1;
    end
    
    %% Landschaft Erzeugen
     
    %% Loop Speieler Erstellen
    for i :1:state.playerQuantety
         
    end
    
    %% Wetter Erstellen
    
    
    %%Speilfeld Erzeugen
    gameScreen = Figure(state,param);
    
    %% Zeichnen
    
end

