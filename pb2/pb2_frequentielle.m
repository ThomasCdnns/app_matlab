clear all
choix = input('Choisir le fichier [0-9]: ');
if choix == 0
    [y, Fs] = audioread('100.wav');
elseif choix == 1
    [y, Fs] = audioread('101.wav');
elseif choix == 2
    [y, Fs] = audioread('102.wav');
elseif choix == 3
    [y, Fs] = audioread('103.wav');
elseif choix == 4
    [y, Fs] = audioread('104.wav');
elseif choix == 5
    [y, Fs] = audioread('105.wav');
elseif choix == 6
    [y, Fs] = audioread('106.wav');
elseif choix == 7
    [y, Fs] = audioread('107.wav');
elseif choix == 8
    [y, Fs] = audioread('108.wav');
elseif choix == 9
    [y, Fs] = audioread('109.wav');
end

index=find(y>0.4);
y=y(index);
y_size = length(y);
t = (0:y_size-1)/Fs;

fft_y = 20*log10(abs(fft(y)));
fft_size=length(fft_y);
f=0:Fs/fft_size:(fft_size-1)*Fs/fft_size;
triggerValue = 5; %valeur arbitraire
fft1 = fft_y(triggerValue:20);
[max_value,max_indice] = max(fft1);
bpm=(((max_indice+triggerValue-2)*Fs)/y_size) * 60;
disp("BPM : " + bpm)

figure(1)
subplot(2,1,1)
plot(t,y)
title('Son');
xlabel('Temps en secondes');
ylabel('Amplitude');
grid on

subplot(2,1,2)
plot(fft_y)
title('FFT');
xlabel('Fréquence en Hertz')
ylabel('dB')
grid on