classdef GameParameter
    %UNTITLED3 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        FIGURE_FULLSCREEN = true;
        FIGURE_WIDTH = 464;     % pixels
        FIGURE_HEIGHT = 750;
        FIGURE_COLOR = [.0,.0,.0];
        AXIS_COLOR = [.2,.0,.0];
        PLOT_W = 200; %width in plot units. this will be main units for program
        PLOT_H = 324; %height
        FONT = 'Courier'; 
        MESSAGE_SPACE = 15; %spacing between message lines
        LARGE_TEXT = 18; %text sizes
        SMALL_TEXT = 14;
        TINY_TEXT = 13;
        TITLE_COLOR = [.0,.8,.0];
    end
    
    properties (Access=private)
    end
    

    
    methods
        function setPlanet(strPlanet)
            switch strPlanet
                case 'earth'
                case 'moon'
                case 'mars'
                case 'europa'   
                otherwise
            end                    
        end
    end
    
end

