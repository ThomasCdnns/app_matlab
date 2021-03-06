clear
clc

puissanceInstant('MarteauPiqueur01.mp3')
puissanceInstant('Jardin01.mp3')
puissanceInstant('Jardin02.mp3')
puissanceInstant('Ville01.mp3')

function P = puissanceInstant(file)
[y,Fs]=audioread(file);
Ts = 1/Fs;
nt0 = height(y);
d=0.01;
K = ceil(((d/Ts)-1)/2);
for n=K+1:nt0-K
    P(n) = ((1/(2*K+1))*sum(y(n-K:n+K).^2));
end
P = mean(P);
Pdbm = 10*log10(P/(10^(-3)));
disp("Puissance instantanée : " + P + "W")
disp("Puissance instantanée : " + Pdbm + "dBm")
disp("---------------------------------------")
end



