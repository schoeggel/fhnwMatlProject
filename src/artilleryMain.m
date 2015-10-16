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
clc
clf
globals();
fig=createFigure(); %Figure erstellen und FigureHandler dazu erhalten
fig



%generate landscape, get landscape vertices, draw it
[terrainshapeX,terrainshapeY] = genLandscape();
c=terrainshapeY;
colormap(0.4*summer+0.4*flipud(pink)+0.1*flipud(winter));
patch(terrainshapeX,terrainshapeY, c,'EdgeColor','interp','MarkerFaceColor','flat');
%axis([1 inf 0 120])



% Panzerli: get Vertices
[player1.shapeX, player1.shapeY] = genPlayer(-1)
[player2.shapeX, player2.shapeY] = genPlayer(5)

%xy = Position+polygon vertices
player1.X = player1.shapeX + 3;
player2.X = player2.shapeX + 63;
player1.Y = player1.shapeY + terrainshapeY(6);
player2.Y = player2.shapeY + terrainshapeY(63);

%draw tanks
patch(player1.X, player1.Y,'g')
patch(player2.X, player2.Y,'y')



    
answer=gui(1)



