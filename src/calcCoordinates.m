function [] = calcCoordinates()
    format long;

    %% Parameter
    %
    %
    % Der winkel in Grad und Rad
    % 
    % $$ang_{rad} = \pi  \frac{ang_{deg}}{180}$$
    % 
    angle = 45;
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
    energieTreibladung = 2000;
    wirkungsGradKanone = 20;
    masseKanone = 10000;

    vStart = 100;
    vxStart = cos(angRad) * vStart;
    vyStart = sin(angRad) * vStart;
    tmax = 13;

    g = 9.81;

    dichteMedium =1.3;
    koeffzient = 1;
    deltaT = 0.01;

    vx = (vxStart);
    vy = (vyStart);
    n=1;
    x(n)=1;
    y(n)=1;

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

end
    
