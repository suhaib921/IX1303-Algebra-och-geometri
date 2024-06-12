%--------------------------------------------------------------------------
% IX1303: PROJEKTUPPGIFT 2, CO2 mätning
%
% Detta är en template.
% Ni ska fylla i koden som efterfrågas och svara på frågorna.
% Notera att alla svar på frågor måste skrivas på raden som börjar med "%".
%--------------------------------------------------------------------------

clear all



%----- SKRIV KOD: Fyll i data-filens namn (ta med .csv, .txt, eller liknande) -----
filename = 'monthly_in_situ_co2_mlo.csv';
TABLE = readtable(filename);

% Display the column names to check
disp(TABLE.Properties.VariableNames);


%----- SKRIV KOD: Fyll i namnen på de kolumner som innehåller tid och data (dvs byt ut XXXXXX) -----
% Namnen på dessa kolumner finns oftast i csv filen. Men, om ni har
% läst in tabellen TABLE kan du se listan av kolumner genom att skriva 
% "T.Properties.VariableNames" i kommand-prompten. 
% Notera att när man arbetar med data någon annan skapat krävs ofta lite
% detektivarbete för att förstå exakt vad alla värden beskriver!
T = TABLE.Date;  % T ska vara en vektor med tiden för olika C02 mätningar
y = TABLE.CO2;  % y ska vara en vektor med data från CO2 mätningar 

% Filter data for the last 60-70 years (from 1950 onwards)
recent_data_idx = T >= 1950;
T = T(recent_data_idx);
y = y(recent_data_idx);

% Print first few entries to inspect
disp('First few entries of T and y:');
disp([T(1:10), y(1:10)]);

%----- SKRIV KOD: Ta bort alla vektor-element som inte innehåller riktig mätdata.
%
%  När man skapat datavektorerna så saknas ibland mätvärden och då har man
%  lagt till negativa värden. Så, om din y-vektor innehåller negativa värden,
%  använd raderna nedan för att ta bort dessa.
T = T( y>=0);
y = y( y>=0);

%  Vid inläsning av kan kan rader som används för kommentarer uppfattas som
%  data och då kan funktionen "readtable" stoppa in värdet NaN (Not a
%  Number) i vektor. För att hitta dessa kan vi använda funktionen
%  "isfinite".  Så, om din y-vektor innehåller NaN, eller andra icke-reella
%  värden, använd raderna nedan för att ta bort dessa.
T = T(isfinite(y));
y = y(isfinite(y));

% Skapa en S-vektor:
S = (T - 1950) / 50;  % Normalized time vector

% Print first few entries of S
disp('First few entries of S:');
disp(S(1:10));

%----- SKRIV KOD: Skapa en minstakvadrat anpassning av y(S) till en rät linje -----
X1    = [ones(size(S)),S];       % Byt ut 0
b1    = y;                        % Byt ut 0
beta1 = X1\b1;                   % Byt ut 0

%----- SKRIV KOD: Rita både mätdata och den linjära anpassningen i samma graf. -----
figure('name','Linjär minstakvadratanpassning')
hold on;
plot(T, y, 'bo');
plot(T, X1 * beta1, 'r-');
xlabel('Year');
ylabel('CO2 concentration (ppm)');
legend('Mätdata', 'Linjär anpassning');
hold off;

% Plot residuals for linear fit
figure('Name', 'Residuals for Linjär anpassning');
plot(T, y - (X1 * beta1), 'bo');
xlabel('Year');
ylabel('Residuals (ppm)');
title('Residuals for Linjär anpassning');


%----- SKRIV KOD: Skapa en minstakvadrat anpassning av y(S) till ett 
%                 andragradspolynom (kvadratisk anpassning) -----
X2    = [ones(size(S)), S, S.^2];     % Byt ut 0
b2    = y;                            % Byt ut 0
beta2 = X2\b2;                        % Byt ut 0


%----- SKRIV KOD: Rita både mätdata och den kvadratiska anpassningen i
%                 samma graf. -----
figure('name','Kvadratisk minstakvadratanpassning')
hold on;
plot(T, y, 'bo');
plot(T, X2 * beta2, 'r-');
xlabel('Year');
ylabel('CO2 concentration (ppm)');
legend('Mätdata', 'Kvadratisk anpassning');
hold off;


% Plot residuals for quadratic fit
figure('Name', 'Residuals for Kvadratisk anpassning');
plot(T, y - (X2 * beta2), 'bo');
xlabel('Year');
ylabel('Residuals (ppm)');
title('Residuals for Kvadratisk anpassning');

%----- SKRIV KOD: Skapa en minstakvadrat anpassning av y(S) till ett
%                 tredjegradspolynom (kubiska anpassning) -----
X3    = [ones(size(S)), S, S.^2, S.^3];  % Byt ut 0
b3    = y;                               % Byt ut 0
beta3 = X3\b3;                           % Byt ut 0


%----- SKRIV KOD: Rita både mätdata och den kubiska anpassningen i samma graf. -----
figure('name','Kubisk minstakvadratanpassning')
hold on;
plot(T, y, 'bo');
plot(T, X3 * beta3, 'r-');
xlabel('Year');
ylabel('CO2 concentration (ppm)');
legend('Mätdata', 'Kubisk anpassning');
hold off;

% Plot residuals for cubic fit
figure('Name', 'Residuals for Kubisk anpassning');
plot(T, y - (X3 * beta3), 'bo');
xlabel('Year');
ylabel('Residuals (ppm)');
title('Residuals for Kubisk anpassning');

% Frågor:
% 1. Beskriv med egna ord hur de tre kurvorna beskriver. Framför allt, blir
%    lösningen lite eller mycket bättre när vi går från en rät linje till
%    en andragradsfunktion? Blir den mycket bättre när vi går från en
%    andragradsfunktion till en tredjegradsfunktion?
% SVAR: Den linjära passningen ger en grov approximation av den övergripande
% trenden, tydligt från det systematiska parabolmönstret i residualerna. 
% Den kvadratiska passningen förbättras avsevärt genom att modellera
% krökningen i data, vilket kan ses i den mer slumpmässiga fördelningen av 
% residualer. Den kubiska passformen förfinar passformen ytterligare och 
% fångar mer subtila variationer, med rester jämnt fördelade runt noll. 
% Den mest anmärkningsvärda förbättringen är från den linjära till den 
% kvadratiska passformen, där den kubiska passformen erbjuder ytterligare,
% men mindre, förbättringar.




% 2. Kan man använda dessa anpassningar för att uppskatta koldioxidhalterna
%    i atmosfärern om 2 år? Motivera ditt svar.
% SVAR: Ja, dessa passningar kan användas för att uppskatta CO2-nivåer om 2 år,
% men med viss försiktighet. Tidsramen är tillräckligt kort för att den 
% nuvarande trenden sannolikt kommer att fortsätta, vilket gör de kvadratiska
% och kubiska modellerna särskilt användbara för kortsiktiga förutsägelser.
% De förbättrade residualerna i dessa modeller indikerar en bättre passform 
% och mer tillförlitliga kortsiktiga förutsägelser.

% 3. Kan man använda dessa anpassningar för att uppskatta koldioxidhalterna
%    i atmosfärern om 6 månader? Motivera ditt svar.
% SVAR: Ja, dessa passningar kan användas för att uppskatta CO2-nivåer 
% på 6 månader. Med tanke på den korta tidsperioden bör modellerna ge 
% tillförlitliga uppskattningar eftersom trenderna sannolikt inte kommer 
% att förändras drastiskt under en så kort period. De mindre resterna(residuals)
% och förbättrade passformen hos de kvadratiska och kubiska modellerna stödjer 
% deras användning för kortsiktiga prognoser.

% 4. Kan man använda dessa anpassningar för att uppskatta koldioxidhalterna
%    i atmosfärern om 50 år? Motivera ditt svar.
% SVAR: Nej, dessa passningar bör inte användas för att förutsäga CO2-nivåer
% om 50 år. Polynompassningar, särskilt sådana av högre ordning, kan ge 
% orealistiska extrapolationer över långa perioder. Sådana förutsägelser 
% kräver mer sofistikerade modeller som tar hänsyn till olika faktorer 
% och potentiella förändringar i trender, policyer och andra influenser. 
% Resterna(residuals), även om de är små, garanterar inte korrekta 
% långsiktiga förutsägelser på grund av polynommodellernas begränsningar 
% när det gäller att fånga långsiktiga trender.