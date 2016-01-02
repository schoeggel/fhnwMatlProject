classdef Figure < handle
%%  Class Header
%
%   Title: Figure.m
%
%   Precondition:   nothing
%
%   Postcondition: 
%   Erzeugt ein Grafikfenster in dem das Spiel Abläuft
%
%   Call: 
%
%	Variables:
%
%   Modified:
%
%  
    
    properties
        screenSize = get(0,'ScreenSize');
        fireEvent  = 0;
        mousedown;
        mouseX;
        mouseY;
    end
    
    properties (Access = private)
        fig;            % Figure Object
        title;          % Titeltext als String
        gameParameter;
        gameStates;
        terrainhandler;
        btnPlayerCount;
        btnMode;
        btnWind;
        btnMountain;
        btnPlanet;
        txtRounds;
        sldRounds;
        btnStart;
        player;
        fire;
        angleText;
        angleSlider;
        powerText;
        powerSlider;
        playerPoints;
        gameRound;

    end    
    
    methods
        %% Konstruktor
        % 
        function this = Figure(GameStates,GameParameter)
           this.fig = figure;
           this.fig.Visible = 'off';
           this.gameStates = GameStates;
           this.gameParameter = GameParameter;
        end
        
        function [] = drawMenue(this)
            
            this.fig.Name = 'Artillery Menue';
            this.fig.MenuBar = 'none';
            this.fig.ToolBar = 'none';
            this.fig.NumberTitle = 'off';
            this.fig.Position = this.gameStates.MENUE_POSITION;
            this.fig.Color = this.gameStates.BLACK;
                 
            %% Die Objekte im GUI erstellen
            %
            % Titel
            this.title = uicontrol;
            this.title.Style = 'text';
            this.title.String = 'Welcome to Artillery';
            this.title.Position = [0,this.gameStates.MENUE_HIGH-65,this.gameStates.MENUE_WIDTH,35];
            this.title.ForegroundColor = this.gameStates.TITLE_COLOR;
            this.title.BackgroundColor = this.gameStates.BLACK;
            this.title.FontName = this.gameStates.FONT;
            this.title.FontSize = this.gameStates.TITLE_SIZE;
            
            %% Auswahl btn Spieleranzahl      
            this.btnPlayerCount = uicontrol;
            this.btnPlayerCount.Style = 'pushbutton';
            this.btnPlayerCount.String = ['N off Players >> ',  num2str(this.gameParameter.playerQuantety)];
            this.btnPlayerCount.Position = [0,this.gameStates.MENUE_HIGH-115,this.gameStates.MENUE_WIDTH,25];
            this.btnPlayerCount.ForegroundColor = this.gameStates.GREEN;
            this.btnPlayerCount.BackgroundColor = this.gameStates.BLACK;
            this.btnPlayerCount.FontName = this.gameStates.FONT;
            this.btnPlayerCount.FontSize = this.gameStates.TEXT_SIZE;
            this.btnPlayerCount.Callback = @this.btnPlayerCountClick;
            
            %% Auswahl btn Spielmodi      
            this.btnMode = uicontrol;
            this.btnMode.Style = 'pushbutton';
            this.btnMode.String = [this.gameParameter.gameMode];
            this.btnMode.Position = [0,this.gameStates.MENUE_HIGH-160,this.gameStates.MENUE_WIDTH,25];
            this.btnMode.ForegroundColor = this.gameStates.GREEN;
            this.btnMode.BackgroundColor = this.gameStates.BLACK;
            this.btnMode.FontName = this.gameStates.FONT;
            this.btnMode.FontSize = this.gameStates.TEXT_SIZE;
            this.btnMode.Callback = @this.btnGameModeClick;
            
            %% Auswahl btn Wetter / Wind      
            this.btnWind = uicontrol;
            this.btnWind.Style = 'pushbutton';
            this.btnWind.String = [this.gameParameter.wind];
            this.btnWind.Position = [0,this.gameStates.MENUE_HIGH-205,this.gameStates.MENUE_WIDTH,25];
            this.btnWind.ForegroundColor = this.gameStates.GREEN;
            this.btnWind.BackgroundColor = this.gameStates.BLACK;
            this.btnWind.FontName = this.gameStates.FONT;
            this.btnWind.FontSize = this.gameStates.TEXT_SIZE;
            this.btnWind.Callback = @this.btnWindClick;
            
            %% Auswahl btn Berge   
            this.btnMountain = uicontrol;
            this.btnMountain.Style = 'pushbutton';
            this.btnMountain.String = [this.gameParameter.mountain];
            this.btnMountain.Position = [0,this.gameStates.MENUE_HIGH-250,this.gameStates.MENUE_WIDTH,25];
            this.btnMountain.ForegroundColor = this.gameStates.GREEN;
            this.btnMountain.BackgroundColor = this.gameStates.BLACK;
            this.btnMountain.FontName = this.gameStates.FONT;
            this.btnMountain.FontSize = this.gameStates.TEXT_SIZE;
            this.btnMountain.Callback = @this.btnMountainClick;
            
            %% Auswahl btn Planet   
            this.btnPlanet = uicontrol;
            this.btnPlanet.Style = 'pushbutton';
            this.btnPlanet.String = [this.gameParameter.planet];
            this.btnPlanet.Position = [0,this.gameStates.MENUE_HIGH-385,this.gameStates.MENUE_WIDTH,25];
            this.btnPlanet.ForegroundColor = this.gameStates.GREEN;
            this.btnPlanet.BackgroundColor = this.gameStates.BLACK;
            this.btnPlanet.FontName = this.gameStates.FONT;
            this.btnPlanet.FontSize = this.gameStates.TEXT_SIZE;
            this.btnPlanet.Callback = @this.btnPlanetClick;
                                 
            %% Anzahl Runden 
            this.txtRounds = uicontrol;
            this.txtRounds.Style = 'text';
            this.txtRounds.String = ['Rounds >> ', num2str(this.gameParameter.numberRounds)];
            this.txtRounds.Position = [0,this.gameStates.MENUE_HIGH-295,this.gameStates.MENUE_WIDTH,25];
            this.txtRounds.ForegroundColor = this.gameStates.GREEN;
            this.txtRounds.BackgroundColor = this.gameStates.BLACK;
            this.txtRounds.FontName = this.gameStates.FONT;
            this.txtRounds.FontSize = this.gameStates.TEXT_SIZE;
            
            %% Anzahl Runden 
            this.sldRounds = uicontrol;
            this.sldRounds.Style = 'slider';
            this.sldRounds.String = 'Rounds';
            this.sldRounds.Position = [0,this.gameStates.MENUE_HIGH-340,this.gameStates.MENUE_WIDTH,25];;
            this.sldRounds.ForegroundColor = this.gameStates.RED;
            this.sldRounds.BackgroundColor = this.gameStates.BLACK;
            this.sldRounds.FontName = this.gameStates.FONT;
            this.sldRounds.FontSize = this.gameStates.TEXT_SIZE;
            this.sldRounds.Callback = @this.sldRoundsChange;
            
            
            %% Start 
            this.btnStart = uicontrol;
            this.btnStart.Style = 'pushbutton';
            this.btnStart.String = '>> Start the best Game >>';
            this.btnStart.Position = [0, 0,this.gameStates.MENUE_WIDTH,25];
            this.btnStart.ForegroundColor = this.gameStates.RED;
            this.btnStart.BackgroundColor = this.gameStates.BLACK;
            this.btnStart.FontName = this.gameStates.FONT;
            this.btnStart.FontSize = this.gameStates.TEXT_SIZE;
            this.btnStart.Callback = @this.btnStartClick;
            
            this.fig.Visible = 'on';                  
        end
        
        function [] = drawGamescreen(this)

        %% CONSTANTS                                
        % #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
        % TODO ersetzen durc Klass

             FIGURE_COLOR = this.gameStates.BACK_BLACK;
             AXIS_COLOR = this.gameStates.SKY;
             FONT = this.gameStates.FONT; 
             LARGE_TEXT = this.gameStates.TITLE_SIZE; %text sizes
             TITLE_COLOR = this.gameStates.TITLE_COLOR;

            % in die linke obere ecke stzen
            %fig = figure('units','normalized','outerposition',[0 0 1 1])
            this.fig.Units = 'normalized';
            this.fig.Name = 'Artillery';
            this.fig.MenuBar = 'none';
            this.fig.ToolBar = 'none';
            this.fig.NumberTitle = 'off';
            this.fig.Position = this.gameStates.GAME_POSITION;
            this.fig.Color = this.gameStates.BLACK;
            
            % Fullscreen
            % Quelle 
            % http://stackoverflow.com/questions/15286458/automatically-maximize-figure-in-matlab
            % http://www.mathworks.com/matlabcentral/answers/98331-is-it-possible-to-maximize-minimize-or-get-the-state-of-my-figure-programmatically-in-matlab
            % vom 28.12.2015
             this.fig.Visible = 'on'; 
             pause(0.1)
             jFrame = get(handle(this.fig), 'JavaFrame');
             jFrame.setMaximized(1);
             pause(0.1)
             this.fig.Resize = 'off';

            % Eigener Mousepointer
            pointer = NaN(16, 16);
            pointer(8, 1:16) = 1;
            pointer(1:16, 8) = 1;
            pointer(8, 8) = 2;
            this.fig.Pointer = 'Custom';
            this.fig.PointerShapeHotSpot = [4, 4];
            this.fig.PointerShapeCData = pointer;
            this.fig.PointerShapeCData = pointer;
            
            %     %register keydown and keyup listeners
            %     set(fig,'KeyPressFcn',@keyDownListener)
            %     %set(fig, 'KeyReleaseFcn', @keyUpListener);
            %     set(fig,'WindowButtonDownFcn', @mouseDownListener);
            %     set(fig,'WindowButtonUpFcn', @mouseUpListener);
            %     set(fig,'WindowButtonMotionFcn', @mouseMoveListener);
            %   figure can't be resized
               % set(fig, 'Resize', 'off');

            mainAxis = axes(); %handle for axis
            axis(this.gameParameter.axisArray);
            axis manual; %axis wont be resized

            %set color for the court, hide axis ticks.
            % Himmelblau machen
            set(mainAxis, 'color', AXIS_COLOR, 'YTick', [], 'XTick', []);
            %handles to title for displaying wave, score
            axisTitle = title('Artillery');
            set(axisTitle, 'FontName', FONT,'FontSize', LARGE_TEXT);
            set(axisTitle, 'Color', TITLE_COLOR);

            colormap(0.4*summer+0.4*flipud(pink)+0.1*flipud(winter));
            
            this.fig.Resize = 'off';
            hold on;

        end
        
        function [] = drawActualPlayer(this, GameState, color)
            axes = this.gameParameter.axisArray;
            leftBorder = (this.gameStates.SCREEN_WIDTH - (axes(1,2)+100)) / 2 ;
            fromleftBorder = 10;
            fromTop = this.gameStates.SCREEN_HIGH - 160;
        % Player
            this.player = uicontrol;
            this.player.Style = 'text';
            this.player.String =  ['Player >> ', num2str(GameState.getActualPlayer)];
            this.player.Position = [fromleftBorder, fromTop, leftBorder , 50];
            this.player.ForegroundColor = color;
            this.player.BackgroundColor = this.gameStates.BLACK;
            this.player.FontName = this.gameStates.FONT;
            this.player.FontSize = this.gameStates.TEXT_SIZE ;
        end
        function [] = drawPlayserPoints(this, GameParameter, Player)
            axes = this.gameParameter.axisArray;
            leftBorder = (this.gameStates.SCREEN_WIDTH - (axes(1,2)+100)) / 2 ;
            fromleftBorder = 10;
            fromTop = this.gameStates.SCREEN_HIGH - 200;
            high = 50;
            space = 25;
            
        % Player Pints
            for pk = 1 : 1 : GameParameter.playerQuantety
                playerPoints(pk) = uicontrol;
                playerPoints(pk).Style = 'text';
                playerPoints(pk).String =  ['Player ', num2str(pk), ' >> ', num2str(Player(pk).score)];
                playerPoints(pk).Position = [fromleftBorder, fromTop - space * pk, leftBorder , high];
                playerPoints(pk).ForegroundColor = Player(pk).getTankColor;
                playerPoints(pk).BackgroundColor = this.gameStates.BLACK;
                playerPoints(pk).FontName = this.gameStates.FONT;
                playerPoints(pk).FontSize = this.gameStates.TEXT_SIZE_TINY ;  
            end
                this.playerPoints = playerPoints;
        end
        function [] = drawGameRound(this, GameParameter, GameState)
            axes = this.gameParameter.axisArray;
            width = (this.gameStates.SCREEN_WIDTH - (axes(1,2)+100));
            fromleftBorder = 10;
            fromTop = this.gameStates.SCREEN_HIGH - 110;
            high = 30;
            
        % Player Pints
            for pk = 1 : 1 : GameParameter.playerQuantety
                this.gameRound = uicontrol;
                this.gameRound.Style = 'text';
                this.gameRound.String =  ['Round >> ', num2str(GameState.getGameRound), ' of ', num2str(GameParameter.numberRounds)];
                this.gameRound.Position = [fromleftBorder, fromTop, width , high];
                this.gameRound.ForegroundColor = GameState.TITLE_COLOR;
                this.gameRound.BackgroundColor = this.gameStates.BLACK;
                this.gameRound.FontName = this.gameStates.FONT;
                this.gameRound.FontSize = this.gameStates.TEXT_SIZE_SMALL;  
            end   
        end
        
        function [] = drawGameButtons(this)
            
            buttonWidth = 150;
            buttonHigh = 50;
            fromleftBorder = (this.gameStates.SCREEN_WIDTH - buttonWidth)/2 ;
            fromBot = 10;
            
            %% Feuer Befehl     
            this.fire = uicontrol;
            this.fire.Style = 'pushbutton';
            this.fire.String = '!!!FIRE!!!';
            this.fire.Position = [fromleftBorder, fromBot , buttonWidth , buttonHigh];
            this.fire.ForegroundColor = this.gameStates.RED;
            this.fire.BackgroundColor = this.gameStates.BLACK;
            this.fire.FontName = this.gameStates.FONT;
            this.fire.FontSize = this.gameStates.TEXT_SIZE;
            this.fire.Callback = @this.btnFireClick;
            
            % Anzeige des Winkels
            this.angleText = uicontrol;
            this.angleText.Style = 'text';
            this.angleText.String = 'Angle >> ';
            this.angleText.Position = [(fromleftBorder - buttonWidth - 30), fromBot + buttonHigh, buttonWidth , buttonHigh];
            this.angleText.ForegroundColor = this.gameStates.YELLOW;
            this.angleText.BackgroundColor = this.gameStates.BLACK;
            this.angleText.FontName = this.gameStates.FONT;
            this.angleText.FontSize = this.gameStates.TEXT_SIZE ;
            
            %% Einstellen des Winkels     
            this.angleSlider = uicontrol;
            this.angleSlider.Style = 'slider';
            this.angleSlider.String = 'ANGLE';
            this.angleSlider.Position = [(fromleftBorder - buttonWidth - 30), fromBot , buttonWidth , buttonHigh];
            this.angleSlider.ForegroundColor = this.gameStates.GREEN;
            this.angleSlider.BackgroundColor = this.gameStates.BLACK;
            this.angleSlider.FontName = this.gameStates.FONT;
            this.angleSlider.FontSize = this.gameStates.TEXT_SIZE;
            this.angleSlider.Callback = @this.btnAngleClick;
              
            % Anzeige des POWER
            this.powerText = uicontrol;
            this.powerText.Style = 'text';
            this.powerText.String = 'POWER >> ';
            this.powerText.Position = [fromleftBorder + buttonWidth + 30, fromBot + buttonHigh, buttonWidth , buttonHigh];
            this.powerText.ForegroundColor = this.gameStates.ORANGE;
            this.powerText.BackgroundColor = this.gameStates.BLACK;
            this.powerText.FontName = this.gameStates.FONT;
            this.powerText.FontSize = this.gameStates.TEXT_SIZE;  
            
            %% Einstellen der POWER   
            this.powerSlider = uicontrol;
            this.powerSlider.Style = 'slider';
            this.powerSlider.String = 'POWER';
            this.powerSlider.Position = [fromleftBorder + buttonWidth + 30, fromBot ,buttonWidth,buttonHigh];
            this.powerSlider.ForegroundColor = this.gameStates.GREEN;
            this.powerSlider.BackgroundColor = this.gameStates.BLACK;
            this.powerSlider.FontName = this.gameStates.FONT;
            this.powerSlider.FontSize = this.gameStates.TEXT_SIZE;
            this.powerSlider.Callback = @this.btnPowerClick;
        end        
        
        function [] = drawPowerBar(this)       
            this.updatePowerBar(0);
            set(this.fig,'WindowButtonDownFcn', @this.myMouseDownCallBack)
            set(this.fig,'WindowButtonUpFcn', @this.myMouseUpCallBack)   
        end 
        
        function [] = updatePowerBar(this,power)
        % zeichnet die powerbar
            blueX = [350,650,650,350];
            blueY = [700,700,720,720];
            pbarX = [350, 350+300*min(power,1), 350+300*min(power,1), 350];
            pbarY = blueY;
            patch(blueX,blueY,[0.6 0.9 1]); % Hellblau Himmel;
            patch(pbarX,pbarY,'R');
        end
        
        function [p] = drawInScreen(this,terrain)
            shapeX = terrain(1,:);
            shapeY = terrain(2,:);
            shapeC = terrain(1,:);
            p = patch(shapeX,shapeY, shapeC,'EdgeColor','interp','MarkerFaceColor','flat');
            colormap(0.4*summer+0.4*flipud(pink)+0.1*flipud(winter));
            axis(this.gameParameter.axisArray);
            this.terrainhandler = p;
            uistack(this.terrainhandler, 'bottom')
        end        
        function [p] = updateInScreen(this, terrain)
            this.terrainhandler.delete;
             p = this.drawInScreen(terrain);
        end
        
        function [p] = drawElement(this, shape)
                color = [0 0 0];
                p = this.drawElementCol(shape, color);
        end
        function [p] = drawElementCol(this,shape,color)
             polygonX = shape(1,:);
             polygonY = shape(2,:);
             p = patch(polygonX, polygonY, color);
        end
        function [] = deleteElement(this,p)
             p.delete;
        end
        function [] = updateElement(this,p, shape)
            color = p.FaceColor;
            this.deleteElement(p);
            this.drawElementCol(shape,color);
        end
        function [] = updateElementCol(this,p,shape,color)
            this.deleteElement(p);
            this.drawElementCol(shape,color);
        end
            
        function [] = drawShockwave(this, impact)
            r = this.gameParameter.detonationRadius;
            
            % rechnet den explosionsradius und die explosion, macht einen fadeout 
            % löscht sie wieder, bevor die funktion zurückkehrt
            alpha = linspace( 0,2*pi,100);        % Intervall
            shockX=3*r*cos(alpha)+impact(1,1);      % Kreis
            shockY=3*r*sin(alpha)+impact(2,1);      % Kreis
            blast2 = patch(shockX,shockY,'w');    % Kreis zeichnen, handler=blast2
            blast2.LineStyle='none';             % Kreislinie nicht zeichnen        
            uistack(this.terrainhandler, 'top')      %terrain nach ganz vorne bringen, Blast Radius ist nur in der Luft.

            shockX=0.99*r*cos(alpha)+impact(1,1);
            shockY=0.99*r*sin(alpha)+impact(2,1); 
            blast0=patch(shockX,shockY,[0.6 0.9 1]); % Hellblau Himmel;  % hintergrund "patchen" mit hellblau, das richtige loch wird erst später reingegerechnet.
            blast1=patch(shockX,shockY,'r');         % roter Explosionsradius darüber zeichnen
            blast0.LineStyle='none';
            blast1.LineStyle='none';
        
            ptime = 0.015;                           % pause zeit zwischen den animationsschritten
            for fadesteps = 0.5:-0.03:0             % animation deckkraft von 0.5 bis 0
               pause(ptime);
               blast1.FaceAlpha=max(0,fadesteps*8-3);% der Explosionsradius rot klingt schneller ab
               blast2.FaceAlpha=fadesteps;
            end   
            delete(blast2);                      % Die Animation ist fertig, alle
            delete(blast1);                     % benutzten Elemente löschen
            delete(blast0);  
   
            uistack(this.terrainhandler, 'bottom')
        end       
        function [newTerrain] = drawImpactCircle(this, terrain, impact)        
            
            x1arr = terrain(1,:);
            y1arr = terrain(2,:);
            centerX = impact(1,1) ;
            centerY = impact(2,1);
            
            r = this.gameParameter.detonationRadius;
            
            % Landschaftspunkte ausserhalb des Radius holen:
            intersections = this.getOuterIntersections( x1arr, y1arr, centerX, centerY, r);

            %Für die Verständlichkeit:
            outerLeftX  =   x1arr(intersections(1));
            outerLeftY  =   y1arr(intersections(1));
            outerRightX =   x1arr(intersections(2));
            outerRightY =   y1arr(intersections(2));
            craterSteps =   intersections(2)-intersections(1)-1;
            craterSteps =   20;   % Anzahl Koordinatenpaare für den Bogen

            %Kreissegment Start und Endpunkte rechnen in Bogenmass
            % mit complex-zahlen machen, sonst gibts noch
            % QuadrantenFallunterscheidung! Dazu muss aber der Einschlagpunkt die 
            % Koordinate 0+0i haben
            z= outerLeftX - centerX + (outerLeftY-centerY) * i;
            circleStart=angle(z);

            z= outerRightX - centerX + (outerRightY-centerY) * i;
            circleEnd=angle(z);

            % der Bogen muss zwingend im Gegenuhrzeigersinn erfolgen, sonst gibts
            % Hügel und andere Fehler.
            if circleEnd<circleStart 
                circleEnd=circleEnd+2*pi;
            end
            
            % Schockwelle zeichnen (Animation, dauert einen Moment)
            this.drawShockwave(impact)

            % rechnet den Explosions-Bogen in n=craterSteps Schritten
            phi=linspace(circleStart, circleEnd, craterSteps);
            arcX=r*cos(phi);
            arcY=r*sin(phi);
            x =arcX + centerX;
            y =arcY + centerY;

            %Terrain-Matrizen anpassen, ein Stück davon ersetzen
            partXbefore = x1arr(1:intersections(1));
            partXafter = x1arr(intersections(2):end);
            partYbefore =y1arr(1:intersections(1));
            partYafter = y1arr(intersections(2):end);
            terrainshapeX = [partXbefore, x, partXafter];  
            terrainshapeY = [partYbefore, y, partYafter];
            newTerrain = [terrainshapeX; terrainshapeY];
            
        end
        
        function [intersections] = getOuterIntersections(this, x1arr, y1arr, centerX, centerY,r)
            % intersections = [left,right]
            % Erstelle Array mit distanzen zum Kreismittelpunkt 
            % normaler pythagoras
            distance=(((x1arr - centerX).^2 + (y1arr-centerY).^2).^0.5);

            %finde den ersten Punkt *vor* dem Radius (Krater soll nicht
            %eingzackt sein, sondern eher gegen aussen gerissen.
            withinRadius=distance<r;
            isect1=max(1,find(withinRadius,1,'first')-1);
            %finde den letzten Punkt *nach* dem Radius
            isect2=min(size(x1arr,2),find(withinRadius,1,'last')+1);
            intersections = [isect1, isect2];
        end

        function [] = updateState(this,GameStates)       
           this.gameState = GameStates;
        end
        function [] = updateParameters(this,GameParameter)       
           this.gameParameter = GameParameter;
        end
        
        function [GameParameter] = getParameters(this)
            GameParameter = this.gameParameter;
        end
        function [fig] = getFig(this)
            fig = this.fig;
        end
        
        function [power] = getPower(this)
            power = this.powerSlider.Value * this.gameParameter.maxPower;
        end
        function [angel] = getAngle(this)
            angel = this.angleSlider.Value * this.gameParameter.maxAngle;
        end
        
        function btnPlayerCountClick(this,source,eventdata)
            if this.gameParameter.playerQuantety < this.gameParameter.maxPlayerQuantety
            this.gameParameter = this.gameParameter.setPlayerQuantety(this.gameParameter.playerQuantety+1);
            else
            this.gameParameter = this.gameParameter.setPlayerQuantety(2);
            end
            this.btnPlayerCount.String = ['N off Players >> ',  num2str(this.gameParameter.playerQuantety)];
        end
        
        function btnGameModeClick(this,source,eventdata)
            this.gameParameter = this.gameParameter.nextMode;
            this.btnMode.String = this.gameParameter.gameMode;
        end
        
        function btnWindClick(this,source,eventdata)
            this.gameParameter = this.gameParameter.nextWind;
            this.btnWind.String = this.gameParameter.wind;
        end;        
        function btnMountainClick(this,source,eventdata)
            this.gameParameter = this.gameParameter.nextMountain;
            this.btnMountain.String = this.gameParameter.mountain;
        end
        function btnPlanetClick(this,source,eventdata)
            this.gameParameter = this.gameParameter.nextPlanet;
            this.btnPlanet.String = this.gameParameter.planet;
        end
        function sldRoundsChange(this,source,eventdata)
            this.gameParameter.numberRounds = this.sldRounds.Value * 100;
            this.txtRounds.String = ['Rounds >> ', num2str(this.gameParameter.numberRounds)];
        end
        function btnStartClick(this,source,eventdata)
            this.gameStates.setMenueProccessed(1);
            close(this.fig)
        end
        
        function [] = btnFireClick(this,source,eventdata)
            this.fireEvent = 1;
        end
        function btnAngleClick(this,source,eventdata)
            value = this.angleSlider.Value * this.gameParameter.maxAngle;
            this.angleText.String = ['Angle >>   ', num2str(value)];
        end;
        function btnPowerClick(this,source,eventdata)
            value = this.powerSlider.Value * this.gameParameter.maxPower;
            this.powerText.String = ['Power >>   ', num2str(value)];
        end;
        
        % Mouse Callbacks 
        function myMouseDownCallBack(this,hObject,~)
            % quelle: http://stackoverflow.com/questions/2769249/matlab-how-to-get-the-current-mouse-position-on-a-click-by-using-callbacks
            % set(f,'WindowButtonDownFcn',@mytestcallback)
            % function mytestcallback(hObject,~)
            % pos=get(hObject,'CurrentPoint');
            % disp(['You clicked X:',num2str(pos(1)),', Y:',num2str(pos(2))]);
            % end
            % Quelle :http://stackoverflow.com/questions/14684577/matlab-how-to-get-mouse-click-coordinates
            % set(imageHandle,'ButtonDownFcn',@ImageClickCallback);
            % function ImageClickCallback ( objectHandle , eventData )
            % axesHandle  = get(objectHandle,'Parent');
            % coordinates = get(axesHandle,'CurrentPoint'); 
            % coordinates = coordinates(1,1:2);
            % message     = sprintf('x: %.1f , y: %.1f',coordinates (1) ,coordinates (2));
            % helpdlg(message);
            % end
                mouseposition = get(gca, 'CurrentPoint');
                this.mouseX   = mouseposition(1,1);
                this.mouseY  = mouseposition(1,2);
                this.mousedown = 1;
        end      
        function myMouseUpCallBack(this,hObject,~)
                mouseposition = get(gca, 'CurrentPoint');
                this.mouseX  = mouseposition(1,1);
                this.mouseY  = mouseposition(1,2);
                this.mousedown = 0; 
        end




        
    end
    
end

