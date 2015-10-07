function landscape()
% Iteration muss zwingend >= 1 sein. im ersten Druchlauf werden 3
% Ecken des Berges gesetzt (Linker Rand, Mitte(Berg) und  rechter Rand)
% im 4. Durchlauf werden Korrekturen vorgenommen, Enden flächer etc.

% JITTER: Random Abweichung der zwischenschritte
% um diesen Zufallsbereich weicht der Geländepunkt vom Mittelwert der
% seiner Nachbarn ab (100 heisst, der Punkt kann um +- 50 abweichen)
JITTER = 38;     
DAEMPFUNG= 1.3;             
BERGOFFSET = 45;
PLATFORMOFFSET=-15;
POSTSMOOTHING=120;
FELSGRENZE=63;          %ab da wird nicht mehr gesmootht
HYSTERESIS=10;   
max_iterations=17;

%% Limits für max_iterations durchsetzten
max_iterations=floor(max_iterations);
if (max_iterations < 1) iterations = 1; end
if (max_iterations > 9) iterations = 9;end  % 1+2^9 Punkte reichen aus!

% Vektor initialisieren                   
terrain=zeros(max_iterations,2^max_iterations+1);

%Start und Ende  und mittelpunkt setzen
terrain (1,2)= rand*JITTER + BERGOFFSET;    % Mittenwert (der Berg)
while (1)
    terrain (1,1) = rand*50;   % Startwert (Linker Rand)
    terrain (1,3) = rand*50;   % Endwert (rechter Rand)  
    % nicht jeden Wurf übernehmen
    if (terrain (1,1)+terrain (1,3) < 50) && (terrain (1,1)+terrain (1,3) >15) break;end 
end
  
% die Terrainpunkte werden in einer Matrix erstellt. ähnlich wie bei der 
% erstellung des pascalschen Dreiecks. Zu Beginn sind nur in der ersten
% Zeile die Werte von Links, Rechts und der Mitte (Berg). Jede Iteration
% erzeugt die Werte in eine nächste Zeile und fügt dort die neuen Punkte
% ein. start bei 2, weil die erste bereits gesetzt (die 3 Startpunkte).
for rowindex=2:1:max_iterations   %für jede iteration gibts eine neue Zeile  in der Matrix
   for colindex=1:1:2^rowindex+1   %Jede Zeile hat mehr Werte als die letzte
        if mod(colindex, 2) > 0    %ungerade zeilen übernehmen bestehende werte (verschoben)
            terrain(rowindex,colindex)= terrain(rowindex-1, (colindex+1)/2);
        else    %gerade Zeilen berechnen einen neuen mittelwert +- random
            left= terrain(rowindex-1, (colindex)/2);
            right= terrain(rowindex-1, (colindex+2)/2);
            % Die Dämpfung wichtig: Einerseits soll die Gesamtlandschaft
            % nicht zu flach sein, andernseits müssen die
            % Zufallshöhenunterschiede bei fortschreitenden Detailgraden
            % immer kleiner werden. Um zu Beginn wenig zu dämpfen und
            % später sehr stark, wird die DAEMPFUNG^ITERATION verwendet.
            % die Korrektur an der Iteration (rowidex-1.8) stellt quasi den
            % Arbeitspunkt der Dämpfung ein.
            %terrain(rowindex,colindex)= (left+right)/2 + (rand*JITTER-(JITTER/2))/DAEMPFUNG^((rowindex-2)*DAEMPFUNG^2.2);
            %terrain(rowindex,colindex)= (left+right)/2 + (rand*JITTER-(JITTER/3.7))/DAEMPFUNG^(rowindex-2);
            terrain(rowindex,colindex)= (left+right)/2 + (rand*JITTER-(JITTER/2))/DAEMPFUNG^((rowindex-2.4)*DAEMPFUNG^2.2);
        end
   end
plot(terrain(rowindex,1:2^rowindex+1));axis([1 inf 0 100])
   
   % *Ein paar Korrekturen für die Positionierung, es geht
   % am einfachsten in der 4. Iteration, wenn 17 Punkte gesetzt sind:
   
   if rowindex == 4 % Beide Spieler  etwas nach unten.
        terrain(4,2) = max(terrain(4,2) + PLATFORMOFFSET,5);
        terrain(4,16)= max(terrain(4,16) + PLATFORMOFFSET,5);
        
       %Spielfeld gegen aussen flacher machen, gegen innen leicht flacher.
        terrain(4,1) = terrain(4,1)-((terrain(4,1)-terrain(4,2))/1.1);
        terrain(4,3) = terrain(4,3)-((terrain(4,3)-terrain(4,2))/2);
      
        % auch für den anderen Spieler:
        terrain(4,17) = terrain(4,17)-((terrain(4,17)-terrain(4,16))/1.1);
        terrain(4,15) = terrain(4,15)-((terrain(4,15)-terrain(4,16))/2);
        plot(terrain(rowindex,1:2^rowindex+1));axis([1 inf 0 100])
        
        % zufällig ein wenig die Spitzen mutieren
        dice=rand*4
        if (dice > 1) && (dice <=2)   terrain(4,9) = terrain(4,9) -5 + rand*15; disp('Mutation 1');  end
        if (dice > 2) && (dice <=3.5) terrain(4,8) = terrain(4,8) -5 + rand*15; disp('Mutation 2'); end
        if (dice > 2.5) && (dice <=4) terrain(4,10)= terrain(4,10)-5 + rand*15; disp('Mutation 3'); end
   end
end 

%% Glättung:
for s=1:floor(POSTSMOOTHING/100*2^max_iterations)
    for colindex=2:1:2^rowindex % Letzte Zeile ist relevant ==> glätten, aber Bergspitzen / Felsen unberührt lassen
        if terrain(max_iterations,colindex) > FELSGRENZE smoothit = 0; end               %Hyterese einbauen, sonst wechselt
        if terrain(max_iterations,colindex) < (FELSGRENZE-HYSTERESIS) smoothit = 1;end   %sich glatt und nicht glatt im Grenzbereich dauernd ab
        
        if smoothit == 1
            mittelwert=(terrain(max_iterations,colindex-1)+terrain(max_iterations,colindex+1))/2; % Mittelwert von der 2 nachbarpunkte
            difference = terrain(max_iterations,colindex)-mittelwert; % Abweichung gegenüber dem mittel der 2 Nachbarpunkte
            terrain(max_iterations,colindex)= terrain(max_iterations,colindex)-0.1*(difference); %Angleichen in kleinen Schritten
        end 
    end
end

area(terrain(max_iterations,:));axis([1 inf 0 100]) % Landschaft provisorisch al Plot zeichnen.
end


