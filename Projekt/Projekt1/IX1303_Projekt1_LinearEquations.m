%--------------------------------------------------------------------------
% IX1303: PROJEKTUPPGIFT 1, Linjära ekvationssystem
%
% Detta är en template.
% Ni ska fylla i koden som efterfrågas och svara på frågorna.
% Notera att alla svar på frågor måste skrivas på raden som börjar med "%".
%--------------------------------------------------------------------------

clear all

%--------------------------------------------------------------------------
% PROBLEM 1: Numeriska beräkningar av determinanter.
M1 = [1, 4 
      2, 8];

M2 = [1, 4/3; 1.1, 4.4/3];

% Determinants
determinanten_av_M1 = det(M1);             % Byt ut "0"
determinanten_av_M2 = det(M2);             % Byt ut "0"


%Display the results
fprintf('Determinant of M1: %.16f\n', determinanten_av_M1);
disp(determinanten_av_M1);
fprintf('Determinant of M2: %.16f\n', determinanten_av_M2);
disp(determinanten_av_M2);

% (a) Varför blir inte båda determinanterna exakt noll?
% SVAR:  Determinanten av M2 är inte exakt noll på grund av numeriska 
% precisionbegränsningar i MATLAB.

% (b) Använd beräkningen för determinanterna ovan får att uppskatta hur
%     stora fel kan vi förvänta oss vid beräkning av determinanter?
% SVAR: Eftersom determinanten av M1 är exakt noll och determinanten av M2 
% är mycket nära noll men inte exakt noll, kan vi förvänta oss ett fel i 
% storleksordningen 10^-16. Detta fel beror på precisionen i MATLAB:s 
% flyttalsberäkningar.


%--------------------------------------------------------------------------
% PROBLEM 2: Matrisinverser

m1 = [ 4; 6; 15];            % Byt ut "0"
m2 = [ 2; 3; 5];             % Byt ut "0"
m3 = cross(m1,m2);           % Cross product to get m3
M  = [m1, m2 ,m3];

% (a) Vad är vinkeln mellan m1 och m3?
% SVAR: 90 grader
theta_m1_m3 = acosd(dot(m1,m3)/(norm(m1)*norm(m3)));  %angle=arccos((m1*m3)/(||m1||* ||m3||))  => ||m1||  är magnitude = (v1²+
%v2²+v3²)^0.5
fprintf('Vinkeln mellan m1 och m3: %.2f grader\n', theta_m1_m3);


% (b) Vad är vinkeln mellan m2 och m3?
% SVAR: 90 grader
theta_m2_m3 = acosd(dot(m2,m3)/(norm(m2)*norm(m3)));
fprintf('Vinkeln mellan m2 och m3: %.2f grader\n', theta_m2_m3);


% (c)	Är de tre vektorerna linjärt oberoende?
% SVAR:  Ja, vektorerna är linjärt oberoende
linjart_oberoende = rank(M) == 3;
fprintf('Är vektorerna linjärt oberoende: %d\n', linjart_oberoende);


%	(d) Vad är determinanten av matrisen M? Använd funktionen "det".
% SVAR: Determinanten är 325
determinanten_av_M = det(M);             % Byt ut "0"
fprintf('Determinanten av M: %.16f\n', determinanten_av_M);

%	(e) Vilket påstående i "invertable matrix theorem", från Lay's bok, ska
%     man använda tillsammans med svaret i c) för att avgöra om matrisen 
%     M är inverterbar?
% SVAR: Enligt invertable matrix theorem är matrisen M inverterbar om dess 
% kolonner är linjärt oberoende (som i svaret på fråga c).

% (f) Vilket påstående i "invertable matrix theorem", från Lay's bok, ska
%     man använda tillsammans med svaret i d) för att avgöra om matrisen
%     M är inverterbar?
% SVAR: Enligt "invertible matrix theorem" är matrisen M inverterbar om dess 
% determinant inte är noll (som i svaret på fråga d).


% (g) Använd Matlab's funktion inv för att beräkna inversen av matrisen M.
%     Är svaret från inv rimligt?
% SVAR: Ja, svaret är rimligt eftersom matrisen M är inverterbar.
inversen_av_M = inv(M);               % Byt ut "[]"
fprintf('Inversen av M:\n');
disp(inversen_av_M);




%--------------------------------------------------------------------------
% PROBLEM 3: Matrisers rank och nollrum

m1 = [  1; 2; 3];
m2 = [ -1; 2; 1];
m3 = m1 + m2; 
m4 = m1 - m2;  
M4 = [m1, m2, m3, m4];

% (a) Vad har matrisen M4 för rang? Använd funktionen "rank".
% SVAR: Rang(M4)= 2
rang_av_M4 = rank(M4);
fprintf('Rang av M4: %d\n', rang_av_M4);


% (b) Hur många pivotkolumner och hur många fria variabler har M4?
%     Notera att detta är relaterat till matrisens rang.
% SVAR: Antal pivotkolumner och fria variabler är 2
pivotkolumner = rang_av_M4;
fria_variabler = size(M4, 2) - rang_av_M4;
fprintf('Antal pivotkolumner: %d\n', pivotkolumner);
fprintf('Antal fria variabler: %d\n', fria_variabler);


% (c) Vad är nollrummet till M4? För detta kan du använda funktionen null.
%     Notera att svaret måste skrivas på ett matematiskt korrekt sätt, så
%     att det beskriver ett vektorrum. Svaret kan skrivas som en mening,
%     eller med matematisk notation. Talen i vektorerna kan avrundas till
%     att ha fyra decimaler.
% SVAR:  Nollrummet till M4 beskrivs av de vektorer som utgör nollrum_av_M4. 
% Om nollrummet har dimensionen (4 - rang_av_M4), så finns det så många 
% linjärt oberoende lösningar i nollrummet.
bas_till_nollrummmet_for_M4 = null(M4,"rational");            % Byt ut "[]"
fprintf('Nollrummet till M4:\n');
disp(bas_till_nollrummmet_for_M4);


%--------------------------------------------------------------------------
% PROBLEM 4: Ekvationssystem med många obekanta
%
% List över antalet frihetsgrader (värden på n) som ska studeras.
% Här har vi alltså fyra olika fall som ska studeras, först n=3,
% sen n=100, sen n=1000 och till sist n=10000.
nList = [3, 100, 1000, 10000];

% Initiera tidsvektorerna. Här sätter vi alla värden till noll, men inne i
% looper ska ni sätta in den tid det tog att lösa ekvationssystemet.
Tid_mldivide = zeros(size(nList));
Tid_inv      = zeros(size(nList));

% Loop över de olika frihetsgraderna.
% Loopen innebär att koden mellan "for" och "end" kommer att köras 4 gånger
% (eftersom length(nList)=4), först med i=1, sen i=2, i=3 och i=4.
for i=1:length(nList)

  % Här skapar vi en variabel n. Värdet på n är 3 först gången vi går
  % igenom loopen, sen 100, 1000 och 10000.
  % Värdet på n är antalet dimensioner hos ekvationssystemet vi ska lösa.
  n=nList(i);

  %----- SKRIV KOD: Skapa nxn matrisen A -----
  %   Här är A=I-C, där C=kR och R är en matris med slumptal
  %   mellan 0 och 1. För att A ska vara inverterbar använder vi k=0.9/n
  k=0.9/n;
  R = rand(n);            % Byt ut "0"
  C = k*R;                % Byt ut "0"
  A = eye(n)-C;           % Byt ut "0"
  
  
  %----- SKRIV KOD:Skapa kolumn-vektorn b -----
  b = rand(n,1);            % Byt ut "0"
  
  
  tic;
  %----- SKRIV KOD: Lös ekvationssystemet med mldivide -----
  losning_med_mldivide = A\b;             % Byt ut "0"
  
  Tid_mldivide(i)=toc;
  
  
  tic;
  %----- SKRIV KOD: Lös ekvationssystemet med inv -----
  losning_med_inv = inv(A)*b;                  % Byt ut "0"
  
  Tid_inv(i)=toc;
  
  
  %----- SKRIV KOD: Beräkna relativa skillnaden mellan lösningarna
  %                 från mldivide och inv                          -----
  relativa_skillnaden = norm(losning_med_mldivide-losning_med_inv)/ norm(losning_med_mldivide);              % Byt ut "0"
  fprintf('Relativa skillnaden för n=%d: %.16f\n', n, relativa_skillnaden);
end


figure; hold on
%----- SKRIV KOD: Rita andra figuren -----
plot(nList, Tid_mldivide, '-o', 'DisplayName', 'mldivide');
plot(nList, Tid_inv, '-x', 'DisplayName', 'inv');
set(gca,'xscale','log');
set(gca,'yscale','log');
xlabel('Antal obekanta (n)');
ylabel('Tid (sekunder)');
legend show;


figure; hold on
plot(nList, Tid_mldivide, '-o', 'DisplayName', 'mldivide');
plot(nList, Tid_inv, '-x', 'DisplayName', 'inv');
set(gca,'xscale','log');
set(gca,'yscale','log');
xlabel('Antal obekanta (n)');
ylabel('Tid (sekunder)');
legend show;



% Frågor:
% (a) Antag att du ska lösa ett problem med tre obekanta en eller ett par
%     gånger. Hur väljer du metod? Är det viktigt att välja rätt metod?
% SVAR: För problem med tre obekanta som bara ska lösas ett par gånger, 
% spelar det inte så stor roll vilken metod du väljer. Båda metoderna kommer 
% att ge dig svar snabbt.

% (b) Antag att du ska lösa ett problem med tre obekanta 10 000 gånger.
%     Hur väljer du metod? Är det viktigt att välja rätt metod?
% SVAR:Om du ska lösa problemet 10 000 gånger, är det bättre att använda 
% mldivide. Den är generellt snabbare och mer numeriskt stabil jämfört med 
% att använda inversen.

% (c) Antag att du ska lösa ett problem med 10 000 obekanta en eller ett
%     par gånger. Hur väljer du metod? Är det viktigt att välja rätt metod?
% SVAR: För stora problem med många obekanta är det viktigt att använda 
% mldivide eftersom det är mer effektivt och hanterar numerisk stabilitet 
% bättre än att använda inv.

% (d) Kör om alla räkningar tre gånger. Varför får du olika resultat varje
%     gång du kör programmet?
% SVAR:  Du får olika resultat varje gång eftersom funktionen rand genererar 
% olika slumptal varje gång du kör programmet. Dessutom kan små numeriska 
% fel uppstå och ackumuleras under beräkningarna.

% (e) Hur stor är den relativa skillnaden i beräkningstid mellan de två
%     metoderna för 10 000 obekanta?
% SVAR: Den relativa skillnaden i beräkningstid mellan de två metoderna 
% kan beräknas genom att ta skillnaden mellan Tid_inv och Tid_mldivide och 
% sedan dela med Tid_mldivide. Så formeln blir 
% (Tid_inv(end) - Tid_mldivide(end)) / Tid_mldivide(end).