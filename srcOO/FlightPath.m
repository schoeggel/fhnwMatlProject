classdef  FlightPath < handle
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        impact;
    end
    
    methods
        function [this]= FlightPath()
            
        end
        function [retCoordinates] = calcCoordinates(this, energie, winkel, Wether, Landscape, Player)

            %% Parameter
            % Der Winkel in Grad und Rad
            % 
            % $$ang_{rad} = \pi  \frac{ang_{deg}}{180}$$
            % 
            angle = winkel;
            angRad = pi() * angle/180;
            
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
            energieTreibladung = energie;
            wirkungsGradKanone = 0.8;
            masseKanone = 10000;
            g = 9.81;
            
            vStart = sqrt(2*energieTreibladung*wirkungsGradKanone/masseProjektil);
            vxStart = cos(angRad) * vStart;
            vyStart = sin(angRad) * vStart;
            tmax = 30;

            dichteMedium =1.3;
            koeffzient = 0.01;
            deltaT = 0.001;

            vx = (vxStart);
            vy = (vyStart);
            n=1;
            playerStartPos = Player.positionXY;
            x(n) = playerStartPos(1,1);
            y(n) = playerStartPos(2,1)+10;

            for t = 0 : deltaT : tmax

                ve = [vx, vy]/sqrt(vx^2 + vy^2);
                fVector = ve * (sqrt(vx^2 + vy^2)^2*koeffzient*dichteMedium)*deltaT;
                vx = vx - fVector(:,1)*deltaT - Wether.wind * koeffzient * dichteMedium*deltaT;
                vy = vy - g * deltaT - fVector(:,2)*deltaT;

                x(n+1) = x(n)+vx * deltaT;
                y(n+1) = y(n)+vy * deltaT;
                n = n+1;               
            end
            
            coordinates = [x;y];
            landArray = Landscape.getLandscape;
            finalLength = 13000;
            for ak = 1 : 1 : length(coordinates)
                xcor = round(coordinates(1,ak));
                ycor = coordinates(2,ak);

                if ycor < landArray(2,xcor-2)
                    this.impact = [xcor; ycor];
                    finalLength = ak;
                    break
                end 
                if xcor > 999
                    this.impact = [1000; ycor];
                    finalLength = ak;
                    break
                end
                if xcor < 4
                    this.impact = [1; ycor];
                    finalLength = ak;
                    break
                end
            end
            retCoordinates = coordinates(:,1:finalLength);
           
        end
        
        function [percentDamage] = isHit(this,PlayerArray, playerNr)
           
            tempPsXY = PlayerArray(playerNr).tankArray;
            if this.impact(1,1) > min(tempPsXY(1,:)) && this.impact(1,1) < max(tempPsXY(1,:))
                percentDamage = 100;
            else
                percentDamage = 0;
            end
        end
    end
    
end

