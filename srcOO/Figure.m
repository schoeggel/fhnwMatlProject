classdef Figure
    %FIGURE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        screenSize = get(0,'ScreenSize');
    end
    
    properties (Access = private)
        fig;    % Figure Object
        title;  % Titeltext als String
        gameParameter;
        gameStates;
        btnPlayerCount;
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
        
        function [fighandler] = crateFigureMain(this)
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
        set(fig, 'color',  this.FIGURE_COLOR);

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
        axis([0 this.PLOT_W 0 this.PLOT_H]);
        axis manual; %axis wont be resized

        %set color for the court, hide axis ticks.
        % Himmelblau machen
        set(mainAxis, 'color', this.AXIS_COLOR, 'YTick', [], 'XTick', []);
        %handles to title for displaying wave, score
        axisTitle = title('Artillery');
        set(axisTitle, 'FontName', this.FONT,'FontSize', this.LARGE_TEXT);
        set(axisTitle, 'Color', this.TITLE_COLOR);

        colormap(0.4*summer+0.4*flipud(pink)+0.1*flipud(winter));
        
        hold on;
        fighandler = gcf;
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
            this.btnPlayerCount = uicontrol;
            this.btnPlayerCount.Style = 'pushbutton';
            this.btnPlayerCount.String = [this.gameParameter.gameMode];
            this.btnPlayerCount.Position = [0,this.gameStates.MENUE_HIGH-160,this.gameStates.MENUE_WIDTH,25];
            this.btnPlayerCount.ForegroundColor = this.gameStates.GREEN;
            this.btnPlayerCount.BackgroundColor = this.gameStates.BLACK;
            this.btnPlayerCount.FontName = this.gameStates.FONT;
            this.btnPlayerCount.FontSize = this.gameStates.TEXT_SIZE;
            this.btnPlayerCount.Callback = @this.btnGameModeClick;
            
            %% Auswahl btn Wetter / Wind      
            this.btnPlayerCount = uicontrol;
            this.btnPlayerCount.Style = 'pushbutton';
            this.btnPlayerCount.String = [this.gameParameter.gameMode];
            this.btnPlayerCount.Position = [0,this.gameStates.MENUE_HIGH-160,this.gameStates.MENUE_WIDTH,25];
            this.btnPlayerCount.ForegroundColor = this.gameStates.GREEN;
            this.btnPlayerCount.BackgroundColor = this.gameStates.BLACK;
            this.btnPlayerCount.FontName = this.gameStates.FONT;
            this.btnPlayerCount.FontSize = this.gameStates.TEXT_SIZE;
            this.btnPlayerCount.Callback = @this.btnGameModeClick;
            
                        %% Auswahl btn Wetter / Wind      
            this.btnPlayerCount = uicontrol;
            this.btnPlayerCount.Style = 'pushbutton';
            this.btnPlayerCount.String = [this.gameParameter.gameMode];
            this.btnPlayerCount.Position = [0,this.gameStates.MENUE_HIGH-160,this.gameStates.MENUE_WIDTH,25];
            this.btnPlayerCount.ForegroundColor = this.gameStates.GREEN;
            this.btnPlayerCount.BackgroundColor = this.gameStates.BLACK;
            this.btnPlayerCount.FontName = this.gameStates.FONT;
            this.btnPlayerCount.FontSize = this.gameStates.TEXT_SIZE;
            this.btnPlayerCount.Callback = @this.btnGameModeClick;
            
            this.fig.Visible = 'on';                  
        end
        
        function [processed] = redrawFigure()
            
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
        
        function btnPlayerCountClick(this,source,eventdata)
            if this.gameParameter.playerQuantety < this.gameParameter.maxPlayerQuantety
            this.gameParameter = this.gameParameter.setPlayerQuantety(this.gameParameter.playerQuantety+1);
            else
            this.gameParameter = this.gameParameter.setPlayerQuantety(2);
            end
            this.btnPlayerCount.String = ['N off Players >> ',  num2str(this.gameParameter.playerQuantety)];
        end;
    end
    
end

