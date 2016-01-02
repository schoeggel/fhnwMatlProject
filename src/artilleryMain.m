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
set(fig,'WindowButtonDownFcn', @mymousedowncallback)
set(fig,'WindowButtonUpFcn', @mymouseupcallback)

%Polling schleife. Falls Mouse down, zählt die Powerbar nach oben
POWERTIMER=0;
GAMESTATE_PLAYERINPUT=1;

while GAMESTATE_PLAYERINPUT && strcmp(fig.Name , 'Artillery')
    pause(0.01);
    if mousedown
       POWERTIMER = POWERTIMER * 1.02 + 1.5;
       updatePowerBar(POWERTIMER/180);
    end
    
    if GAMESTATE_FIRE
        GAMESTATE_PLAYERINPUT = false;
        FIREPOWER = min(POWERTIMER/180,1);
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


%% Fire in the hole!
function [] = updatePowerBar(power)
% zeichnet die powerbar
blueX = [350,650,650,350];
blueY = [700,700,720,720];
pbarX = [350, 350+300*min(power,1), 350+300*min(power,1), 350];
pbarY = blueY;
patch(blueX,blueY,[0.6 0.9 1]); % Hellblau Himmel;
patch(pbarX,pbarY,'R');
end


function [angle] = getAngle(playernr)
    px =player1.posX;
    py =player1.posY;
    mouseposition = get(gca, 'CurrentPoint');
    mx  = max(mouseposition(1,1),px);   % max limitiert den winkel auf 0-90°
    my  = max(mouseposition(1,2),py);   % max limitiert den winkeln auf 0-90°
    angle=asind((my-py)/sqrt((my-py)^2 + (mx-px)^2)) ;
end


function [impactposX, impactposY, hit] = gunfire (playernr, startY, fireAngle, power)
    %% Parameter
    %
    %
    % Der winkel in Grad und Rad
    % 
    % $$ang_{rad} = \pi  \frac{ang_{deg}}{180}$$
    % 
    % fireAngle = 45;
    angRad = pi() * fireAngle/180;

    %% Berechnung der Abbschussgeschwindigkeit
    % 
    % $$Energie Projektil: E_{prj} \ Geschwindigkeit Projektil: v_{prj} \ Msse Projektil: m_{Projektil}$$
    % 
    % $$Wirkungsgrad Kanon: n_{can} Energie Treibladung $$
    %
    % $$E_{prj} = \frac{m_{prj}}{2} v_{prj}^{2}$$
    %
    % $$E_{prj} = E_{trbl} * n_{can}$$
    %
    % $$v_{prj} = \sqrt{ \frac{2 E_{prj}}{m_{prj}}}$$
    %
    masseProjektil = 1;
    energieTreibladung = 1000000;
    wirkungsGradKanone = 1;
    masseKanone = 10000;
%playernr
%startY
%fireAngle
%power

gunposX=player1.posX-7;
gunposY=player1.posY +3;
t=[gunposX:1:1000-gunposX];

    vStart = sqrt((2 * energieTreibladung * wirkungsGradKanone) / masseProjektil);
    vxStart = cos(angRad) * vStart;
    vyStart = sin(angRad) * vStart;
    tmax = 1000;

    g = 9.81;

    dichteMedium =1.3;
    koeffzient = 10;
    deltaT = 0.01;

    vx = (vxStart);
    vy = (vyStart);
    n=1;
    x(n)=player1.posX;
    y(n)=player1.posY;

    for t = 0 : deltaT : tmax
        
        ve = [vx, vy]/sqrt(vx^2 + vy^2);
        fVector = ve * (sqrt(vx^2 + vy^2)^2*koeffzient*dichteMedium)*deltaT;
        vx = vx - fVector(:,1)*deltaT;
        vy = vy - g * deltaT - fVector(:,2)*deltaT;

        x(n+1) = x(n)+vx * deltaT;
        y(n+1) = y(n)+vy * deltaT;
        n = n+1;
    end
    
    
    comet(x,y)



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
    [in,on]= inpolygon(x,y,terrainshapeX,terrainshapeY); 
    on=[];                                  % on line points: unwichtig
    projectilepath2=plot(x(in),y(in),'r+'); % points inside
    impactindex=find(in,1,'first');         % erster index innerhalb des terrain-polygons
    impactposX=x(impactindex);
    impactposY=y(impactindex);
    hit = 0;                                % wurde der panzer getroffen? TODO
    
delete(projectilepath)                      %debug plot wieder löschen
delete(projectilepath2)                     %debug plot wieder löschen
end


function [] = impactcrater(impactposX, impactposY)
% rechnet den impactcrater ins terrain-polygono hinein.
% zeichnet ein hellblaues loch über das bestehende terrain
% zeichnet den weissen blast-Radius darüber
% zeichnet den roten Explosionsradius darüber
% Blendet Blast und Explosionsradius in einer Animation aus
% Löscht das alte terrain, alle radien (rot, weiss blau) 
% und zeichnet das neue Terrain.
        
% Option: Panzer innerhalb dieses Shock-Radius stehen für 2 Züge  
% unter Schock und schiessen ungenau. 
        
    explosionradius=15+round(10*rand);%explosion radius nicht immer gleich gross
    [terrainshapeX,terrainshapeY] = calcCirlce(terrainshapeX, terrainshapeY, impactposX, impactposY, explosionradius);
delete(terrainhandler); % altes Terrain löschen, danach neues zeichnen, wieder gleichen handler zuweisen!
    terrainhandler=patch(terrainshapeX,terrainshapeY, terrainshapeY,'EdgeColor','interp','MarkerFaceColor','flat');
end

%     function [intersections] = getOuterIntersections(x1arr,y1arr,centerX,centerY,r)
%         % intersections = [left,right]
%         % Erstelle Array mit distanzen zum Kreismittelpunkt 
%         % normaler pythagoras
%         distance=(((x1arr-centerX).^2 + (y1arr-centerY).^2).^0.5);
%     
%         %finde den ersten Punkt *vor* dem Radius (Krater soll nicht
%         %eingzackt sein, sondern eher gegen aussen gerissen.
%         withinRadius=distance<r;
%         isect1=max(1,find(withinRadius,1,'first')-1);
%         %finde den letzten Punkt *nach* dem Radius
%         isect2=min(size(x1arr,2),find(withinRadius,1,'last')+1);
%         intersections = [isect1, isect2];
%     end
% 
% 
%     function [x2arr, y2arr] = calcCirlce(x1arr, y1arr, centerX, centerY, r);
%         % Landschaftspunkte ausserhalb des Radius holen:
%         intersections = getOuterIntersections(x1arr,y1arr,centerX,centerY,r);
% 
%         %Für die Verständlichkeit:
%         outerLeftX  =   x1arr(intersections(1));
%         outerLeftY  =   y1arr(intersections(1));
%         outerRightX =   x1arr(intersections(2));
%         outerRightY =   y1arr(intersections(2));
%         craterSteps =   intersections(2)-intersections(1)-1;
%         craterSteps =   20;   % Anzahl Koordinatenpaare für den Bogen
% 
%         %Kreissegment Start und Endpunkte rechnen in Bogenmass
%         % mit complex-zahlen machen, sonst gibts noch
%         % QuadrantenFallunterscheidung! Dazu muss aber der Einschlagpunkt die 
%         % Koordinate 0+0i haben
%         z= outerLeftX - centerX + (outerLeftY-centerY) * i;
%         circleStart=angle(z);
% 
%         z= outerRightX - centerX + (outerRightY-centerY) * i;
%         circleEnd=angle(z);
% 
%         % der Bogen muss zwingend im Gegenuhrzeigersinn erfolgen, sonst gibts
%         % Hügel und andere Fehler.
%         if circleEnd<circleStart 
%             circleEnd=circleEnd+2*pi;
% end
% 
%         % Schockwelle zeichnen (Animation, dauert einen Moment)
%         drawShockwave()
%         
%         % rechnet den Explosions-Bogen in n=craterSteps Schritten
%         phi=linspace(circleStart, circleEnd, craterSteps);
%         arcX=r*cos(phi);
%         arcY=r*sin(phi);
%         x=arcX + centerX;
%         y=arcY + centerY;
% 
%         %Terrain-Matrizen anpassen, ein Stück davon ersetzen
%         partXbefore=x1arr(1:intersections(1));
%         partXafter= x1arr(intersections(2):end);
%         partYbefore=y1arr(1:intersections(1));
%         partYafter= y1arr(intersections(2):end);
%         x2arr=[partXbefore, x, partXafter];  
%         y2arr=[partYbefore, y, partYafter];
% 
%        
%         function  drawShockwave
%         % rechnet den explosionsradius und die explosion, macht einen fadeout 
%         % löscht sie wieder, bevor die funktion zurückkehrt
%         alpha=linspace( 0,2*pi,100);        % Intervall
%         shockX=3*r*cos(alpha)+centerX;      % Kreis
%         shockY=3*r*sin(alpha)+centerY;      % Kreis
%         blast2=patch(shockX,shockY,'w')     % Kreis zeichnen, handler=blast2
%         blast2.LineStyle='none'             % Kreislinie nicht zeichnen        
%         uistack(terrainhandler, 'top')      %terrain nach ganz vorne bringen, Blast Radius ist nur in der Luft.
%        
%         shockX=0.99*r*cos(alpha)+centerX;
%         shockY=0.99*r*sin(alpha)+centerY; 
%         blast0=patch(shockX,shockY,[0.6 0.9 1]); % Hellblau Himmel;  % hintergrund "patchen" mit hellblau, das richtige loch wird erst später reingegerechnet.
%         blast1=patch(shockX,shockY,'r');         % roter Explosionsradius darüber zeichnen
%         blast0.LineStyle='none';
%         blast1.LineStyle='none';
%         
%         ptime = 0.015                           % pause zeit zwischen den animationsschritten
%         for fadesteps = 0.5:-0.03:0             % animation deckkraft von 0.5 bis 0
%            pause(ptime);
%            blast1.FaceAlpha=max(0,fadesteps*8-3);% der Explosionsradius rot klingt schneller ab
%            blast2.FaceAlpha=fadesteps;
%         end   
%             delete(blast2);                     % Die Animation ist fertig, alle
%             delete(blast1);                     % benutzten Elemente löschen
%             delete(blast0);     
%         end
%     end
% 
% function mymousedowncallback(hObject,~)
%     if GAMESTATE_PLAYERINPUT
%         mouseposition = get(gca, 'CurrentPoint');
%         mx  = mouseposition(1,1);
%         my  = mouseposition(1,2);
%         disp(['You clicked X:',num2str(mx),', Y:',num2str(my)]);
%         mousedown=true;
%         tic
%     end
% end
% 
% %% Mouse Callbacks 
% function mymouseupcallback(hObject,~)
%     if GAMESTATE_PLAYERINPUT
%         mouseposition = get(gca, 'CurrentPoint');
%         mx  = mouseposition(1,1);
%         my  = mouseposition(1,2);
%         disp(['You released button X:',num2str(mx),', Y:',num2str(my), ' Time elapesed: ', num2str(POWERTIMER)]);
%         mousedown=false;
%         GAMESTATE_FIRE = true
%     end
% end
% 
% % quelle: http://stackoverflow.com/questions/2769249/matlab-how-to-get-the-current-mouse-position-on-a-click-by-using-callbacks
% % set(f,'WindowButtonDownFcn',@mytestcallback)
% % function mytestcallback(hObject,~)
% % pos=get(hObject,'CurrentPoint');
% % disp(['You clicked X:',num2str(pos(1)),', Y:',num2str(pos(2))]);
% % end
% 
% % Quelle :http://stackoverflow.com/questions/14684577/matlab-how-to-get-mouse-click-coordinates
% % set(imageHandle,'ButtonDownFcn',@ImageClickCallback);
% % function ImageClickCallback ( objectHandle , eventData )
% % axesHandle  = get(objectHandle,'Parent');
% % coordinates = get(axesHandle,'CurrentPoint'); 
% % coordinates = coordinates(1,1:2);
% % message     = sprintf('x: %.1f , y: %.1f',coordinates (1) ,coordinates (2));
% % helpdlg(message);
% % end

end

