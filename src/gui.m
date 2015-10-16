function [answer] = gui(playernr)
%GUI Summary of this function goes here
%   Detailed explanation goes here

prompt = {'angle:','power:'};
dlg_title = strcat('Player:',num2str(playernr));
num_lines = 1;
defaultans = {'45','100'};
answer = inputdlg(prompt,dlg_title,num_lines,defaultans);


end

