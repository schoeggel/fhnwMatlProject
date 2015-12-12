classdef GameStates < handle
    %GAMESTATES Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (GetAccess = public)
           
           FONT = 'Courier';    % Globel Font
           FONT_SERIF = 'Times New Roman';
           TITLE_SIZE = 19;     %text sizes
           TEXT_SIZE = 15;
           TEXT_SIZE_SMALL = 15;
           TEXT_SIZE_TINY = 13;
           
           TITLE_COLOR = [.0,.1,.8];
           GREEN = [.01, .5, .01];
           HOVER_GREEN = [.01, .7, .01]
           BLACK = [.01, .01, .01]; %% Black for Backround 
           BACK_BLACK = [.01, .01, .01]; %% Black for Backround
           RED = [0.8,0.1,0.15];
                                            
           varScreenSize = get(0,'ScreenSize');
           SCREEN_WIDTH;
           SCREEN_HIGH;
                      
           MENUE_HIGH;
           MENUE_WIDTH;
           MENUE_POSITION;
           
           GAME_HIGH;
           GAME_WIDTH;
           GAME_POSITION;

           
%          FIGURE_FULLSCREEN = true;
%          FIGURE_WIDTH = 950;     % pixels
%          FIGURE_HEIGHT = 650;
%          FIGURE_COLOR = [.15, .15, .15]; % RGB
%          AXIS_COLOR = [0.6 0.9 1]; % Hellblau Himmel
%          PLOT_W = 1000; %width in plot units. this will be main units for program
%          PLOT_H = 750; %height
%          FONT = 'Courier'; 
%          MESSAGE_SPACE = 15; %spacing between message lines
%          LARGE_TEXT = 18; %text sizes
%          SMALL_TEXT = 14;
%          TINY_TEXT = 13;
%          TITLE_COLOR = [.0,.8,.0];
%          %FIGURE_COLOR = [.15, .15, .15]; %program background
%          %FIGURE_COLOR = [0.6 0.9 1] % Hellblau Himmel
    end
    
    properties (Access = private)
      %% Mit folgenden Parameter wird der Status des Programess Beschrieben
      menueProcessed = 0;
    end
    
    methods
        function this = GameStates()
            
           this.SCREEN_WIDTH = this.varScreenSize(3);
           this.SCREEN_HIGH = this.varScreenSize(4);
                                                         
           this.MENUE_HIGH= this.SCREEN_HIGH/8*5;
           this.MENUE_WIDTH = this.MENUE_HIGH/8*5;
           
           this.MENUE_POSITION = [this.SCREEN_WIDTH/2-this.MENUE_WIDTH/2, ...
               this.SCREEN_HIGH/2 - this.MENUE_HIGH/2,this.MENUE_WIDTH, this.MENUE_HIGH];
           
           this.GAME_HIGH= this.varScreenSize(4);
           this.GAME_WIDTH= this.varScreenSize(3);
           
           this.GAME_POSITION = [ 0, 0, this.GAME_WIDTH, this.GAME_HIGH];
        end
        
        function this = setMenueProccessed(this, state)
            this.menueProcessed = state;
        end
        function state = getProcessState(this)
            state = this.menueProcessed;
        end
    end
end

