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

%xy = Position+polygon vertices
player1.X = player1.shapeX + 15;
player2.X = player2.shapeX + 290;
player1.Y = player1.shapeY + terrainshapeY(5) + 3;
player2.Y = player2.shapeY + terrainshapeY(62) +3 ;

%draw tanks
patch(player1.X, player1.Y,'g')
patch(player2.X, player2.Y,'y')
    

%Polling schleife. Falls Mouse down, zählt die Powerbar nach oben




set(fig,'WindowButtonDownFcn',@mytestcallback)
function mytestcallback(hObject,~)
 mouseposition = get(gca, 'CurrentPoint');
    mx  = mouseposition(1,1);
    my  = mouseposition(1,2);
 disp(['You clicked X:',num2str(mx),', Y:',num2str(my)]);
%disp(mouseposition);

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

