clc;
clear variables;

[y, Fs] = audioread('102.wav');


Ts = 1/ Fs;                                          % période d'échantillonage
nbr_elts = length(y);
duree = (nbr_elts-1)*Ts;                              % durée du signal
t = 0:Ts:duree;                                      % vecteur temps

nbFenetre = 240;                                     % nombre de fenetres choisi arbitrairement
tailleFenetre = nbr_elts / nbFenetre;                 % nombre d'éléments par fenetres
fft_y = zeros(1,240);                                         % création d'un vecteur qui va contenir les puissances moyennes de chaque fenetre 

puissSeuil = 0.5;                                   % on choisit la valeur arbitrairement pour chaque signal différent ( on estime la valeur la meilleure valeur à taton)
for n = 0:nbFenetre-1    
    extraitFenetre = y(round((n*tailleFenetre+1)):round(((n+1)*tailleFenetre))); % fenêtres glissantes sans recouvrement
    puissFenetre = extraitFenetre.^2;                              % vecteur des puissances instantanées pour la fenetre
    puissFenetreMoy = mean (puissFenetre);                         % puissance moyenne sur la fenetre

    if (puissFenetreMoy > puissSeuil)                              % on ajoute seulement les fft qui ne sont pas considérées comme du bruit 
        fft_extraitFenetre = abs(fft(extraitFenetre));
        fft_extraitFenetre(1)=0;                                   % on enlève la première valeur car elle est toujours maximum sinon (on ne comprend pas pourquoi)
        deltaf = Fs/length(extraitFenetre);
        [fft_max, idc_max] = max(fft_extraitFenetre);              % On détermine le maximum
        fft_freq = idc_max;                                        % ainsi que son emplacements
        fft_y(n) = fft_freq;
    end
end                               
bpm = 60*fft_y;                                                    % définition du nombre de battements par minutes                                   % nombre de fenetres choisi arbitrairement
t2 = 0:tailleFenetre:nbr_elts-tailleFenetre;
figure(1);
subplot(2,1,1);
plot(t, y);
xlabel('seconds');
ylabel('amplitude');
title('109.wav');

subplot(2,1,2);
disp("a" + length(t2));
disp("b" + length(bpm));
plot (t2, bpm);
xlabel('temps');
ylabel('bpm');