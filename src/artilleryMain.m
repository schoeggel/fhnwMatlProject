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
player1.X = player1.shapeX + 10;
player2.X = player2.shapeX + 290;
player1.Y = player1.shapeY + terrainshapeY(5);
player2.Y = player2.shapeY + terrainshapeY(62);

%draw tanks
patch(player1.X, player1.Y,'g')
patch(player2.X, player2.Y,'y')
    

answer=gui(1)
t = 0:1/280:pi;
x = 11:1:290
y = terrainshapeY(5) + 10 +180*sin(4*t);
comet(x,y)
%PlotComet_3D(x,y);

