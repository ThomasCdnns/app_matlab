clc;
clear variables;

[y, Fs] = audioread('109.wav');

Ts = 1/Fs;
nbr_elts = length(y);
duree = (nbr_elts-1)*Ts;
t = 0:Ts:duree;

nbFenetre = 500;
tailleFenetre = nbr_elts / nbFenetre;
fft_y = zeros(1,240);

puissSeuil = 0.5;
for n = 0:nbFenetre-1    
    extraitFenetre = y(round((n*tailleFenetre+1)):round(((n+1)*tailleFenetre)));
    puissFenetre = extraitFenetre.^2;
    puissFenetreMoy = mean (puissFenetre);

    if (puissFenetreMoy > puissSeuil)
        fft_extraitFenetre = abs(fft(extraitFenetre));
        fft_extraitFenetre(1)=0;
        deltaf = Fs/length(extraitFenetre);
        [fft_max, idc_max] = max(fft_extraitFenetre);
        fft_freq = idc_max;
        fft_y(n) = fft_freq;
    end
end                               
bpm = 60*fft_y;
t2 = 0:tailleFenetre:nbr_elts-tailleFenetre;
figure(1);
subplot(2,1,1);
plot(t, y);
xlabel('seconds');
ylabel('amplitude');
title('109.wav');

subplot(2,1,2);
xlabel('temps');
ylabel('bpm');