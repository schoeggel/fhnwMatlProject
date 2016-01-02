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
           ORANGE = [0.9,0.4,0.1];
           YELLOW = [0.9,0.9,0.1];
           MAGENTA = [1,0,1];
           SKY = [0.6 0.9 1]; % Hellblau Himmel
                                            
           varScreenSize = get(0,'ScreenSize');
           SCREEN_WIDTH;
           SCREEN_HIGH;
                      
           MENUE_HIGH;
           MENUE_WIDTH;
           MENUE_POSITION;
           
           GAME_HIGH;
           GAME_WIDTH;
           GAME_POSITION;
    end
    
    properties (Access = private)
      %% Mit folgenden Parameter wird der Status des Programess Beschrieben
      menueProcessed = 0;
      
      
      %%
      actualPlayer = 1;
      playerInGame;
      
      gameRound = 1;
    end
    
    methods
        function this = GameStates()
            
           this.SCREEN_WIDTH = this.varScreenSize(3);
           this.SCREEN_HIGH = this.varScreenSize(4);
                                                         
           this.MENUE_HIGH = this.SCREEN_HIGH/8*5;
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
        function [] = setPlayerInGame(this, number)
            this.playerInGame = number ;
        end
        function [playerInGame] = decreasePlayerInGame(this)
            this.playerInGame = this.playerInGame - 1;
            playerInGame = this.playerInGame;
        end   
        function [playerInGame] = getPlayerInGame(this)
            playerInGame = this.playerInGame;
        end  
        
        function [] = setActualPlayer(this,number)
            this.actualPlayer = number;
        end
        function [actPlayer] = getActualPlayer(this)
           actPlayer = this.actualPlayer;
        end      
        function [] = nextPlayer(this, GameParameter, PlayerArray)
            if GameParameter.playerQuantety == this.actualPlayer
                this.actualPlayer = 1;
            else
                if PlayerArray(this.actualPlayer + 1).livePoints > 0
                    this.actualPlayer = this.actualPlayer + 1;
                else
                   this.actualPlayer = this.actualPlayer + 1;
                   this.nextPlayer(GameParameter, PlayerArray);
                end
            end
        end
        
        function [gameRound] = getGameRound(this)
            gameRound = this.gameRound;
        end
        
        function [gameRound] = nextGameRound(this, GameParameter)
            this.gameRound = this.gameRound + 1;
            if  this.gameRound > GameParameter.numberRounds
                this.gameRound = 'End';
            end
            gameRound = this.gameRound;
        end
        
    end
end

