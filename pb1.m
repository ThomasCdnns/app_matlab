clear
clc

[y,Fs]=audioread('MarteauPiqueur01.mp3');
Ts = 1/Fs;
S = -48; %3,98mV
G = 30;
P_SPL = 80;
Dt = 1;
dt = 0.5;
n = height(y);
K=ceil(((0.01/Ts)-1)/2);

isNoise = false;
countSilent = 0;
countNoise = 0;

for i=K+1:n-K
    if Pdbm(i)+G<(-P_SPL)
        countSilent = countSilent+1;
        if countSilent >= dt*Fs && isNoise==true
            isNoise = false;
            disp("Bruit pénible pendant : " + countNoise/Fs + "s")
            disp("Puissance moyenne du bruit : ")
        end
    end

    if Pdbm(i)+G>=(-P_SPL)
        countNoise = countSilent + 1;
        if countNoise >= Dt*Fs && isNoise==false
            isNoise = true;
            disp("Silence pendant : " + countSilent/Fs + "s")
        end
    end
end

function output = Pdbm(i)
[y,Fs]=audioread('MarteauPiqueur01.mp3');
Ts = 1/Fs;
d=0.001;
K = ceil(((d/Ts)-1)/2);
P = ((1/(2*K+1))*sum(y(i-K:i+K).^2));
output = 10*log10(P/(10^(-3)));
end