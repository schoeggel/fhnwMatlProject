classdef Figure < handle
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
        end;
        
    end
    
end

