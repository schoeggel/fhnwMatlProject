%%  Header
%
%   Title: artillery.m
%
%   Precondition:   nothing
%
%   Postcondition:  
%
%   Call: 
%
%	Variables:
%
%   Modified:
%
%


function []=artillery()

close all
clear all
clc
globals();
mousedown = false;
GAMESTATE_PLAYERINPUT = true;
FIREPOWER=0;
GAMESTATE_FIRE= false

%% CONSTANTS                                
%#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

%% colors
%#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

GREEN = [.1, .7, .1];
BLUE = [.3, .3, .9];
WHITE = [1, 1, 1];
RED = [.9, .3, .3];

%% Bildschirm Starten
%#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#


fig=createFigure(); %Figure erstellen und FigureHandler dazu erhalten




%generate landscape, get landscape vertices, draw it
[terrainshapeX,terrainshapeY] = genLandscape();
c=terrainshapeY;

patch(terrainshapeX,terrainshapeY, c,'EdgeColor','interp','MarkerFaceColor','flat');
colormap(0.4*summer+0.4*flipud(pink)+0.1*flipud(winter));
axis([1 300 0 300])



% Panzerli: get Vertices
[player1.shapeX, player1.shapeY] = genPlayer(-1);
[player2.shapeX, player2.shapeY] = genPlayer(5);

%Player center-positions
player1.posX = 15
player2.posX = 290
player1.posY = terrainshapeY(5) + 3
player2.posY = terrainshapeY(62) +3 

% translate player polgon to player position
player1.polygonX = player1.shapeX + player1.posX;
player2.polygonX = player2.shapeX + player2.posX;
player1.polygonY = player1.shapeY + player1.posY;
player2.polygonY = player2.shapeY + player2.posY ;

%draw tanks
patch(player1.polygonX, player1.polygonY,'g')
patch(player2.polygonX, player2.polygonY,'y')
    
%draw Powerbar
updatePowerBar(0);


% Enable Mouse interaction
set(fig,'WindowButtonDownFcn',@mymousedowncallback)
set(fig,'WindowButtonUpFcn',@mymouseupcallback)




%Polling schleife. Falls Mouse down, zählt die Powerbar nach oben

POWERTIMER=0
%pause(1.5)
GAMESTATE_PLAYERINPUT

while GAMESTATE_PLAYERINPUT && strcmp(fig.Name,'Artillery')
    pause(0.01);
    if mousedown
       POWERTIMER=POWERTIMER*1.02 + 1.5;
       updatePowerBar(POWERTIMER/180);
    end
    
    if GAMESTATE_FIRE
        GAMESTATE_PLAYERINPUT = false;
        FIREPOWER=min(POWERTIMER/180,1)
        fireAngle=getAngle();
        gunfire(1,player1.posY+10,fireAngle,FIREPOWER);
        updatePowerBar(0);
        GAMESTATE_FIRE = false;
        GAMESTATE_PLAYERINPUT = true;
        POWERTIMER=0;
        
    end
    
end








function mymousedowncallback(hObject,~)
    if GAMESTATE_PLAYERINPUT
        mouseposition = get(gca, 'CurrentPoint');
        mx  = mouseposition(1,1);
        my  = mouseposition(1,2);
        disp(['You clicked X:',num2str(mx),', Y:',num2str(my)]);
        mousedown=true;
        tic
    end
end




function mymouseupcallback(hObject,~)
    if GAMESTATE_PLAYERINPUT
        mouseposition = get(gca, 'CurrentPoint');
        mx  = mouseposition(1,1);
        my  = mouseposition(1,2);
        disp(['You released button X:',num2str(mx),', Y:',num2str(my), ' Time elapesed: ', num2str(POWERTIMER)]);
        mousedown=false;
        GAMESTATE_FIRE = true
    end
end



function [] = updatePowerBar(power)
% zeichnet die powerbar
% untergrund
blueX = [100,200,200,100];
blueY = [250,250,257,257];

pbarX = [100, 100+100*min(power,1), 100+100*min(power,1), 100];
pbarY = blueY;

patch(blueX,blueY,[0.6 0.9 1]); % Hellblau Himmel;
patch(pbarX,pbarY,'R');
%disp('Powerbar updatet.')    
end


function [angle] = getAngle(playernr)
    px=player1.posX 
    py=player1.posY
    
    mouseposition = get(gca, 'CurrentPoint');
    mx  = max(mouseposition(1,1),px);   % max limitiert den winkel auf 0-90°
    my  = max(mouseposition(1,2),py);   % max limitiert den winkeln auf 0-90°
        
    angle=asind((my-py)/sqrt((my-py)^2 + (mx-px)^2))
    
end


%% quelle: http://stackoverflow.com/questions/2769249/matlab-how-to-get-the-current-mouse-position-on-a-click-by-using-callbacks
% set(f,'WindowButtonDownFcn',@mytestcallback)
% function mytestcallback(hObject,~)
% pos=get(hObject,'CurrentPoint');
% disp(['You clicked X:',num2str(pos(1)),', Y:',num2str(pos(2))]);
% end

%% Quelle :http://stackoverflow.com/questions/14684577/matlab-how-to-get-mouse-click-coordinates
% set(imageHandle,'ButtonDownFcn',@ImageClickCallback);
% function ImageClickCallback ( objectHandle , eventData )
% axesHandle  = get(objectHandle,'Parent');
% coordinates = get(axesHandle,'CurrentPoint'); 
% coordinates = coordinates(1,1:2);
% message     = sprintf('x: %.1f , y: %.1f',coordinates (1) ,coordinates (2));
% helpdlg(message);
% end

end

