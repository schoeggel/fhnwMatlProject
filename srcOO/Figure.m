%%  Header
%
%   Title: createFigure.m
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

classdef Figure < handle
    %FIGURE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        screenSize = get(0,'ScreenSize');
    end
    
    properties (Access = private)
        fig;            % Figure Object
        title;          % Titeltext als String
        gameParameter;
        gameStates;
        btnPlayerCount;
        btnMode;
        btnWind;
        btnMountain;
        btnPlanet;
        btnStart;
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
            this.btnPlanet.Position = [0,this.gameStates.MENUE_HIGH-295,this.gameStates.MENUE_WIDTH,25];
            this.btnPlanet.ForegroundColor = this.gameStates.GREEN;
            this.btnPlanet.BackgroundColor = this.gameStates.BLACK;
            this.btnPlanet.FontName = this.gameStates.FONT;
            this.btnPlanet.FontSize = this.gameStates.TEXT_SIZE;
            this.btnPlanet.Callback = @this.btnPlanetClick;
            
            
            %% Start 
            this.btnStart = uicontrol;
            this.btnStart.Style = 'pushbutton';
            this.btnStart.String = '>> Start the f...... Game >>';
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
         FIGURE_FULLSCREEN = true;
         FIGURE_WIDTH = 950;     % pixels
         FIGURE_HEIGHT = 650;
         FIGURE_COLOR = [.15, .15, .15];
         AXIS_COLOR = [0.6 0.9 1]; % Hellblau Himmel
         FONT = 'Courier'; 
         MESSAGE_SPACE = 15; %spacing between message lines
         LARGE_TEXT = 18; %text sizes
         SMALL_TEXT = 14;
         TINY_TEXT = 13;
         TITLE_COLOR = [.0,.8,.0];
         %FIGURE_COLOR = [.15, .15, .15]; %program background
         %FIGURE_COLOR = [0.6 0.9 1] % Hellblau Himmel

        %% Setup der Anzeige
            % Ermitteln der Bildschirmgrösse
            screenSize = get(0,'ScreenSize');

            % in die linke obere ecke stzen
            fig = figure('units','normalized','outerposition',[0 0 1 1]);
            set(fig, 'Name', 'Artillery');

        %     fig = figure('Position',[(screenSize(3)-FIGURE_WIDTH)/2,...
        %       (screenSize(4)-FIGURE_HEIGHT)/2, ...
        %       FIGURE_WIDTH, ...
        %       FIGURE_HEIGHT]);
        %       %custom close function.

        % set(fig,'CloseRequestFcn',@my_closefcn);

            %set background color for figure
            set(fig, 'color', FIGURE_COLOR);

            %make custom mouse pointer
            pointer = NaN(16, 16);
            pointer(8, 1:16) = 1;
            pointer(1:16, 8) = 1;
            pointer(8, 8) = 2;
            set(fig, 'Pointer', 'Custom');
            set(fig, 'PointerShapeHotSpot', [4, 4]);
            set(fig, 'PointerShapeCData', pointer);

        %     %register keydown and keyup listeners
        %     set(fig,'KeyPressFcn',@keyDownListener)
        %     %set(fig, 'KeyReleaseFcn', @keyUpListener);
        %     set(fig,'WindowButtonDownFcn', @mouseDownListener);
        %     set(fig,'WindowButtonUpFcn', @mouseUpListener);
        %     set(fig,'WindowButtonMotionFcn', @mouseMoveListener);

            %figure can't be resized
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

            hold on;
            fighandler=gcf;
        end
        
        function [] = drawInScreen(this,terrain)
            shapeX = terrain(1,:);
            shapeY = terrain(2,:);
            shapeC = terrain(1,:);
            p = patch(shapeX,shapeY, shapeC,'EdgeColor','interp','MarkerFaceColor','flat');
            colormap(0.4*summer+0.4*flipud(pink)+0.1*flipud(winter));
            axis(this.gameParameter.axisArray);
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
       function [] = updateElement(this,p,shape)
            color = p.FaceColor;
            this.deleteElement(p);
            this.drawElementCol(shape,color);
       end
       function [] = updateElementCol(this,p,shape,color)
            this.deleteElement(p);
            this.drawElementCol(shape,color);
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
        
        function btnPlayerCountClick(this,source,eventdata)
            if this.gameParameter.playerQuantety < this.gameParameter.maxPlayerQuantety
            this.gameParameter = this.gameParameter.setPlayerQuantety(this.gameParameter.playerQuantety+1);
            else
            this.gameParameter = this.gameParameter.setPlayerQuantety(2);
            end
            this.btnPlayerCount.String = ['N off Players >> ',  num2str(this.gameParameter.playerQuantety)];
        end;  
        
        function btnGameModeClick(this,source,eventdata)
            this.gameParameter = this.gameParameter.nextMode;
            this.btnMode.String = this.gameParameter.gameMode;
        end;
        function btnWindClick(this,source,eventdata)
            this.gameParameter = this.gameParameter.nextWind;
            this.btnWind.String = this.gameParameter.wind;
        end;        
        function btnMountainClick(this,source,eventdata)
            this.gameParameter = this.gameParameter.nextMountain;
            this.btnMountain.String = this.gameParameter.mountain;
        end;
        function btnPlanetClick(this,source,eventdata)
            this.gameParameter = this.gameParameter.nextPlanet;
            this.btnPlanet.String = this.gameParameter.planet;
        end;
        function btnStartClick(this,source,eventdata)
            this.gameStates.setMenueProccessed(1);
            close(this.fig)
        end;
        
    end
    
end

