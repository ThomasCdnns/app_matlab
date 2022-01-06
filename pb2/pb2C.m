clear
clc

%file="MarteauPiqueur01.mp3";
%file="Jardin01.mp3";
%file="Jardin02.mp3";
file="alarmes.mp3";

[y,Fs]=audioread(file);
Ts = 1/Fs;
S = -48;
G = 30;
G_DB = 20*log10(G);
pressionRef = 94;
P_SPL = 80;
Dt = 1;
dt = 0.5;
n = length(y);
D=0.001;
K=ceil(((D/Ts)-1)/2);
t = (0:(n-1))*Ts;

subplot(3,1,1)
plot(t(1:n),y(1:n))
title('Signal in the time domain')
xlabel('s')
ylabel('V')
grid on;
zoom xon;

tensionRMS = 10^((P_SPL+S-pressionRef)/20);
triggerValue = 10*log10((tensionRMS^2)/0.001)+G_DB;

Pdbm = PDBM('alarmes.mp3');
PnoiseDef = find(Pdbm>=triggerValue);
noises = zeros(1,n);
noises (PnoiseDef) = 1;
TnoiseDef = ceil(Dt*Fs);
TsilenceDef = ceil(dt*Fs);

noisesList = noises;
i0 = 1;
previousNoise = noises(1);
for i=2:length(noises)-1
    if noises(i) ~= previousNoise
        index = i-i0;
        if index >= TnoiseDef && previousNoise == 1
            noisesList(i0:i-1)=1;
        end
        if index <= TsilenceDef && previousNoise == 0
            noisesList(i0:i-1)=1;
        end
        i0 = i;
        previousNoise = noises(i);
        index = 0;
    end
end

subplot(3,1,2)
plot(t(1:n),noisesList(1:n), 'r')
title('Boolean noise detection')
xlabel('time')
ylabel('0: silence, 1:noise')
grid on;
zoom xon;

stateSwitches = zeros(1,length(noisesList));
for i = 1:length(noisesList)-1
    if noisesList(i) ~= noisesList(i+1)
        stateSwitches(i) = i;
    end
end
stateSwitches = find(stateSwitches>0);

for i=1:length(stateSwitches)/2
    startIndex = (2*i)-1;
    endIndex = 2*i;
    noiseTimeLength = abs((stateSwitches(startIndex) - stateSwitches(endIndex))*Ts);
    disp("Noise " + i + " lasts : " + noiseTimeLength + "s")
    subplot(3,1,3)
    dsp_max = DSP(Fs, y, startIndex, endIndex);
    disp("DSP Max for noise "+ i+ " :" + dsp_max)
end

function dsp_max = DSP(Fs, x, startIndex, endIndex)
x = x(startIndex::endIndex)
N = length(x);
xdft = fft(x);
xdft = xdft(1:N/2+1);
psdx = (1/(Fs*N)) * abs(xdft).^2;
psdx(2:end-1) = 2*psdx(2:end-1);
frequency_step = Fs/length(x);
freq = 0:frequency_step:Fs/2;
plot(freq,10*log10(psdx))
grid on
title('Periodogram Using FFT')
xlabel('Frequency (Hz)')
ylabel('Power/Frequency (dB/Hz)')
[M,I] = max(psdx);
dsp_max = 10*log10(M);
end


function Pdbm = PDBM(file)
[y,Fs]=audioread(file);
Ts = 1/Fs;
N = length(y);
d=0.0001;
K = ceil(((d/Ts)-1)/2);
P = zeros(1,N-2*K-1);
for n=K+1:N-K
    P(n) = mean(y(n-K:n+K).^2);
end
Pdbm = 10*log10(P/(10^(-3)));
end
