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



%generate landscape, get landscape vertices
[terrainshapeX,terrainshapeY] = genLandscape();
c=terrainshapeY;

%draw landscape
terrainhandler = patch(terrainshapeX,terrainshapeY, c,'EdgeColor','interp','MarkerFaceColor','flat');
colormap(0.4*summer+0.4*flipud(pink)+0.1*flipud(winter));
axis([1 1000 0 750])

% Panzerli: get Vertices
[player1.shapeX, player1.shapeY] = genPlayer(-1);
[player2.shapeX, player2.shapeY] = genPlayer( 5);

%Player center-positions
player1.posX = 40;
player2.posX = 1000-40;
player1.posY = terrainshapeY(40) + 1;
player2.posY = terrainshapeY(1000-40) + 1 ;

% translate player polgon to player position
player1.polygonX = player1.shapeX + player1.posX;
player2.polygonX = player2.shapeX + player2.posX;
player1.polygonY = player1.shapeY + player1.posY;
player2.polygonY = player2.shapeY + player2.posY;

%draw tanks
patch(player1.polygonX, player1.polygonY,'g')
patch(player2.polygonX, player2.polygonY,'y')
    
%draw Powerbar
updatePowerBar(0);

% Enable Mouse interaction
set(fig,'WindowButtonDownFcn',@mymousedowncallback)
set(fig,'WindowButtonUpFcn',@mymouseupcallback)

%Polling schleife. Falls Mouse down, zählt die Powerbar nach oben
POWERTIMER=0;
GAMESTATE_PLAYERINPUT=1;

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
        [impactposX, impactposY, hit] = gunfire(1,player1.posY+10,fireAngle,FIREPOWER);
        if impactposX ~= (-1)    % Einschläge ausserhalb des Spielfeldes nicht beachten
            impactcrater(impactposX,impactposY);
        end
        updatePowerBar(0);
        GAMESTATE_FIRE = false;
        GAMESTATE_PLAYERINPUT = true;
        POWERTIMER=0;
    end   
end


function [] = updatePowerBar(power)
% zeichnet die powerbar
% untergrund
blueX = [350,650,650,350];
blueY = [700,700,720,720];

pbarX = [350, 350+300*min(power,1), 350+300*min(power,1), 350];
pbarY = blueY;

patch(blueX,blueY,[0.6 0.9 1]); % Hellblau Himmel;
patch(pbarX,pbarY,'R');
%disp('Powerbar updatet.')    
end


function [angle] = getAngle(playernr)
    px=player1.posX;
    py=player1.posY;
    mouseposition = get(gca, 'CurrentPoint');
    mx  = max(mouseposition(1,1),px);   % max limitiert den winkel auf 0-90°
    my  = max(mouseposition(1,2),py);   % max limitiert den winkeln auf 0-90°
    angle=asind((my-py)/sqrt((my-py)^2 + (mx-px)^2)) ;
end


function [impactposX, impactposY, hit] = gunfire (playernr, startY, fireAngle, power)
% in ArtilleryMain integriert, weil beim Schuss auch noch das Terrain
% verändert wird.

%playernr
%startY
%fireAngle
%power

% alter comet zu testzwecken
%t = 0:1/290:pi;
%x = 15:1:290;
%y = startY +220*sin((rand+2+(1-power))*t);
%comet(x,y)

gunposX=player1.posX-7;
gunposY=player1.posY +3;
t=[gunposX:1:1000-gunposX];

% Wurparabel : TODO geht noch nicht...

%für debug einschlag krater testen: gerade von oben nach unten
%x=ones(1,size(t,2))*((90.1-fireAngle)/90)*1000;
x=ones(1,1000);
x=x.*(1000-fireAngle/90*1000);
y=[1000:-1:1];
projectilepath=plot(x,y);


    % collision detection 
    % 'in' und 'on' sind wie eine maske für die x und y punkte.
    % um den Einschlag zu detektieren, muss einfach die erste davon verwendet
    % werden, die 1 und nicht 0 ist.
    [in,on]= inpolygon(x,y,terrainshapeX,terrainshapeY); % on line points: unwichtig
    on=[];
    projectilepath2=plot(x(in),y(in),'r+'); % points inside
    impactindex=find(in,1,'first');   % erster index innerhalb des terrain-polygons
    impactposX=x(impactindex);
    impactposY=y(impactindex);
    hit = 0;
    
delete(projectilepath)
delete(projectilepath2)
end


function [] = impactcrater(impactposX, impactposY)
% rechnet den impactcrater ins terrain-polygono hinein.
% Krater besteht aus 2 phasen. phase 1: loch, es wird absolut gerechnet ein
% Kreis oder kreisähnliches Loch aus dem polygon rausgerechnet. Phase 2
% erzeugt relativ zur bestehenden terrain-Linie einen leichten Hügel. Als
% mögliche 3. Phase könnte oberhalb des Terrains noch der Blast-Radius
%(Shock-Zone) angezeichnet werden (nur ganz kurz). Panzer innerhalb dieses
% Shock-Radius stehen für 2 Züge  unter Schock und schiessen
% ungenau. 
        
explosionradius=15+round(10*rand);%explosion radius nicht immer gleich gross
%deformY=real(sqrt(explosionradius.^2-(terrainshapeX-(round(impactposX))).^2)); % halbkreisformel
%dieser halbkreis kann jetzt nicht einfach vom bestehenden gelände
%subtrahiert werden, sieht schlecht aus. Besser so: zur obigen
%kreisabweichung (delta) in der Y achse den einschlagpunkt Y addieren.
%Dann auf der x-achse von einschlagpunkt-r 2r nach rechts: den kleineren
%wert nehmen von kreis oder bestehendem terrain. Das sägt einen kreis aus. 
%überhängende landschaft ist aber nicht möglich, dort ists dann senkrecht.
%deformY=-deformY+round(impactposY); %das kreisdelta auf die höhe des einschlagpunktes (y) beingen
%ivon=round(impactposX-explosionradius);
%ibis=round(ivon+2*explosionradius);
%terrainshapeY(ivon:ibis)=min(terrainshapeY(ivon:ibis),deformY(ivon:ibis));

[terrainshapeX,terrainshapeY] = calcCirlce(terrainshapeX, terrainshapeY, impactposX, impactposY, explosionradius);

delete(terrainhandler); % altes Terrain löschen, danach neues zeichnen, wieder gleichen handler zuweisen!
terrainhandler=patch(terrainshapeX,terrainshapeY, terrainshapeY,'EdgeColor','interp','MarkerFaceColor','flat');

end

    function [intersections] = getOuterIntersections(x1arr,y1arr,centerX,centerY,r)
        % intersections = [left,right]
        % Erstelle Array mit distanzen zum Kreismittelpunkt // Test ok
        % normaler pythagoras
        distance=(((x1arr-centerX).^2 + (y1arr-centerY).^2).^0.5);
    
        %finde den ersten Punkt *vor* dem Radius (Krater soll nicht
        %eingzackt sein, sondern eher gegen aussen gerissen.
        withinRadius=distance<r;
        isect1=max(1,find(withinRadius,1,'first')-1);
        %finde den letzten Punkt *nach* dem Radius
        isect2=min(size(x1arr,2),find(withinRadius,1,'last')+1);
        intersections = [isect1, isect2];
    end


    function [x2arr, y2arr] = calcCirlce(x1arr, y1arr, centerX, centerY, r);
        %berechnet die exakten eckpunkte des kraters, liegend auf der strecke
        %des letzten (resp. ersten) punktes der landschaft ausserhalb des
        %explosionsradius.
        % Ladschaftspunkte ausserhalb des Radius holen:
        intersections = getOuterIntersections(x1arr,y1arr,centerX,centerY,r);

        %Für die Verständlichkeit:
        outerLeftX  =   x1arr(intersections(1));
        outerLeftY  =   y1arr(intersections(1));
        outerRightX =   x1arr(intersections(2));
        outerRightY =   y1arr(intersections(2));
        craterSteps =   intersections(2)-intersections(1)-1;
        craterSteps =   20;   % mal fixieren, geht vielleicht??

        %Kreissegment Start und Endpunkte rechnen in Bogenmass
        % mit complex-zahlen machen, sonst gibts noch
        % QuadrantenFallunterscheidung! Dazu muss aber der Einschlagpunkt die 
        % Koordinate 0+0i haben
        z= outerLeftX - centerX + (outerLeftY-centerY) * i;
        circleStart=angle(z)   ;

        z= outerRightX - centerX + (outerRightY-centerY) * i;
        circleEnd=angle(z);
              
        % der Bogen muss zwingend im Gegenuhrzeigersinn erfolgen, sonst gibts
        % Hügel und andere Fehler.
        if circleEnd<circleStart 
            circleEnd=circleEnd+2*pi;
        end

        % Schockwelle zeichnen
        drawShockwave()
        
        % rechnet den Explosions-Bogen in n=craterSteps Schritten
        phi=linspace(circleStart, circleEnd, craterSteps);
        arcX=r*cos(phi);
        arcY=r*sin(phi);
        x=arcX + centerX;
        y=arcY + centerY;

        %Terrain-Matrizen anpassen, ein Stück davon ersetzen
        partXbefore=x1arr(1:intersections(1));
        partXafter= x1arr(intersections(2):end);
        partYbefore=y1arr(1:intersections(1));
        partYafter= y1arr(intersections(2):end);
        x2arr=[partXbefore, x, partXafter];  
        y2arr=[partYbefore, y, partYafter];

       
        function  drawShockwave
        % rechnet den explosionsradius und die explosion, warten einen
        % augenblick. löscht sie wieder, bevor die funktion zurückkehrt
        % circleStart und circleEnd sollten beim Aufruf bekannt sein, ebnso
        % die Einschlagsposition.
        
        alpha=linspace( 0,2*pi,100);
        shockX=3*r*cos(alpha)+centerX;
        shockY=3*r*sin(alpha)+centerY;
        blast2=patch(shockX,shockY,'w')
        blast2.LineStyle='none'
        
        
        %terrain nach ganz vorne bringen
        uistack(terrainhandler, 'top')
        
        
        shockX=0.99*r*cos(alpha)+centerX;
        shockY=0.99*r*sin(alpha)+centerY; % ein bisschen grösser sieht noch cool aus
        blast0=patch(shockX,shockY,[0.6 0.9 1]); % Hellblau Himmel;  % hintergrund "patchen" mit hellblau, das richtige loch wird erst später reingegerechnet.
        blast1=patch(shockX,shockY,'r')
        blast0.LineStyle='none'
        blast1.LineStyle='none'
        
        
        
        ptime = 0.015
        for fadesteps = 0.5:-0.03:0
           pause(ptime);
           blast1.FaceAlpha=max(0,fadesteps*8-3);
           blast2.FaceAlpha=fadesteps;
        end   
            delete(blast2)
            delete(blast1)
            delete(blast0)
        
        
        
%         alpha=linspace( circleEnd,circleStart+2*pi,craterSteps);
%         shockX=r*cos(alpha);
%         shockY=r*sin(alpha);
%         x=shockX + centerX;
%         y=shockY + centerY;
%         plot(x,y);
        
        end
        
        
        
    end


    function [x,y] = calcCircleFull(centerX,centerY,r, nsteps)
        %rechnet einen Kreis in nsteps Schritten plus offset
        phi=linspace(0, 2*pi, nsteps);
        xrel=r*cos(phi);
        yrel=r*sin(phi);
        x=xrel+centerX;
        y=yrel+centerY;
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

