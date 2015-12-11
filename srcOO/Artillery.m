function [] = Artillery()
clear;
close all;


param = GameParameter;  % Instanz GameParameter erzeugen
state = GameStates;         % Instanz GameStates erzeugen

screen = Figure(state, param);
screen.drawMenue();

    while(false) % TODO
        fig.modifyParameter(param);
    end

end

