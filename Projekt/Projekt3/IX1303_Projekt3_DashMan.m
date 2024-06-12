%--------------------------------------------------------------------------
% IX1303-VT2023: PROJEKTUPPGIFT 3, Streckgubben
%
% Detta är en template.
% Ni ska fylla i koden som efterfrågas och svara på frågorna.
% Notera att alla svar på frågor måste skrivas på raden som börjar med "%".
%--------------------------------------------------------------------------

clear all

% Beskrivning av gif-filen
filename = 'dashman.gif';
TimePerFrame = 0.05;
NumberOfTimeSteps = 50;

%------------------
% SKAPA MATRISERNA
%------------------

%----- SKRIV KOD: Skapa den matris som rotaterar sträckgubben. 
%                 Du väljer vinkeln på rotationen, men notera att för
%                 att det ska se ut som att sträckgubben roterar måste
%                 rotationen mellan varje bild i filmen vara liten.   -----
theta = 2 * pi * 4 / NumberOfTimeSteps; % 4 full rotations in 50 steps
R = [cos(theta) -sin(theta) 0;
     sin(theta)  cos(theta) 0;
     0          0          1];

%----- SKRIV KOD: Skapa den matris som transkaterar sträckgubben.
dx = 0.5;
dy = 0.5; 
T = [1 0 dx;  
     0 1 dy;  
     0 0 1];   

%----- SKRIV KOD: Skapa den matris som förstorar sträckgubben.
scaling_factor = 8^(1/NumberOfTimeSteps); % Scale up to X times the size in 50 steps
S = [scaling_factor 0 0;
     0 scaling_factor 0;
     0 0 1];

%----- SKRIV KOD: Skapa den sammansatta matrisen som 
%                 beskriver den efterfrågade avbildningen -----
A = T * R * S;
  
%----- UPPDATERA KOD: Finn en "bounding-box" (en zoom-inställning) på formatet:
%                        [x-min, x-max, y-min, y-max]
%                     Så att vi ser gubben tydligt under animeringen - den
%                     får inte försvinna ut ur bilden.
BoundingBox = [-1,1,-1,1]*10;

%------------------------------
% SKAPA STRECKGUBBEN, DASH-MAN
%------------------------------

D=DashMan();
disp(fieldnames(D)); 


%-----------------------------------
% SKAPA FÖRSTA BILDEN I ANIMERINGEN
%-----------------------------------
figure(1);
clf; hold on;
plotDashMan(D); % Här ritar vi Dash-man som han ser ut från början
axis equal
axis(BoundingBox)
set(gca,'visible','off')
addFrameToGif(filename, 1, TimePerFrame)

%-----------------------------------------------------
% Loopa över alla bilder i animeringen, från 2 till 50
%-----------------------------------------------------
for i = 2:NumberOfTimeSteps -1
  % Transformera alla DASH-MAN's kroppsdelar
  D.head = A * D.head;
  D.body = A * D.body;
  D.arms = A * D.arms;
  D.legs = A * D.legs;

  %----- SKRIV KOD: Transformera alla DASH-MAN's kroppsdelar -----
  % Här ska du uppdatera punkter i D, dvs alla punkter i huvudet, kroppen osv.

 hold off
  plotDashMan(D); % Här ritar vi Dash-man som han ser ut efter transformationen
  axis equal
  axis(BoundingBox)
  set(gca,'visible','off')
  addFrameToGif(filename, i, TimePerFrame)
end



% Frågor:
%	1. Varför innehåller sista raden i D.head bara ettor?
% SVAR: Den sista raden i D.head består av bara ettor eftersom det är en 
% homogen koordinat. Homogena koordinater använder den sista raden för att 
% möjliggöra translationer med matrisoperationer. Genom att ha ettor i den 
% sista raden kan vi enkelt använda 3x3-matriser för att hantera både 
% rotationer och translationer samtidigt.

% 2. 2.	Beskriv skillnaden i gubbens rörelse över flera varv 
%      (d.v.s banan gubben rör sig längs) när man translaterar uppåt, neråt,
%      åt höger eller vänster?
% SVAR: Om gubben rör sig uppåt, följer han en spiralformig bana uppåt medan 
% han roterar och förstoras. Om han rör sig neråt, följer han en spiralformig 
% bana nedåt. När han rör sig åt höger, följer han en spiralformig bana åt 
% höger, och när han rör sig åt vänster, följer han en spiralformig bana åt 
% vänster. Kombinationen av translation, rotation och förstoring skapar en 
% komplex spiralrörelse.


% 3. Om man flyttar gubben en sträcka dx=0.1 per steg, och vi tar 50 steg
%    med kombinerad translation och rotation, varför har gubben inte
%    flyttats 50*0.1 åt höger?
% SVAR: Gubben har inte flyttats exakt 50*0.1 åt höger eftersom varje steg 
% också inkluderar en rotation och en förstoring, inte bara en translation. 
% Rotationerna gör att den totala förflyttningen inte är strikt åt höger. 
% Istället rör sig gubben i en spiralformad bana på grund av kombinationen 
% av alla dessa transformationer. Därför blir nettoförflyttningen efter 50 
% steg en kombination av rotation, förflyttning och förstoring, inte bara 
% translationen.