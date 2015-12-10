classdef Figure
    %FIGURE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        screenSize = get(0,'ScreenSize');
    end
    
    properties (Access = private)
        fig;    % Figure Object
        title;  % Titeltext als String
        btnPlayerCount;
    end    
    
    methods
        %% Konstruktor
        % 
        function this = Figure()
           this.fig = figure;
           this.fig.Visible = 'off';
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
        
        function [] = drawMenue(this, GameStates, GameParameter)
            this.fig.Name = 'Artillery Menue';
            this.fig.MenuBar = 'none';
            this.fig.ToolBar = 'none';
            this.fig.NumberTitle = 'off';
            this.fig.Position = GameStates.MENUE_POSITION;
            this.fig.Color = GameStates.BLACK;
                 
            %% Die Objekte im GUI erstellen
            %
            % Titel
            this.title = uicontrol;
            this.title.Style = 'text';
            this.title.String = 'Welcome to Artillery';
            this.title.Position = [0,GameStates.MENUE_HIGH-65,GameStates.MENUE_WIDTH,35];
            this.title.ForegroundColor = GameStates.TITLE_COLOR;
            this.title.BackgroundColor = GameStates.BLACK;
            this.title.FontName = GameStates.FONT;
            this.title.FontSize = GameStates.TITLE_SIZE;
            %% Auswahl Spieleranzahl      
            this.btnPlayerCount = uicontrol;
            this.btnPlayerCount.Style = 'pushbutton';
            this.btnPlayerCount.String = ['N off Players >> ',  num2str(GameParameter.playerQuantety)];
            this.btnPlayerCount.Position = [0,GameStates.MENUE_HIGH-115,GameStates.MENUE_WIDTH,25];
            this.btnPlayerCount.ForegroundColor = GameStates.GREEN;
            this.btnPlayerCount.BackgroundColor = GameStates.BLACK;
            this.btnPlayerCount.FontName = GameStates.FONT;
            this.btnPlayerCount.FontSize = GameStates.TEXT_SIZE;
            this.btnPlayerCount.Callback = @this.btnPlayerCountHover;
            
            this.fig.Visible = 'on';
                    
%             btn_sin = uicontrol('Style','pushbutton', 'String','Plot Sinus',  'Position',[100,280,100,35], 'FontSize', 9,...
%                         'Callback',@btn_sin_Callback);
%             btn_cos = uicontrol('Style','pushbutton', 'String','Plot Cosinus',...
%                         'Position',[300,280,100,35], 'FontSize', 9,...
%                         'Callback',@btn_cos_Callback);         
%             txt1    = uicontrol('Style','text','String','GUI ohne GUIDE',...
%                         'Position',[95,315,300,30], 'FontSize', 10);
%             axes1   = axes('Units','pixels','Position',[60,60,400,200]);     
        end
        
        function [processed] = redrawFigure()
            
        end
        
        function btnPlayerCountHover(this,source,eventdata, GameParameter) 
            GameParameter.setPlayerQuantety( GameParameter.playerQuantety + 1);
        end;
    end
    
end

