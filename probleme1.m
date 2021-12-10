clear
clc

f0 = 1000; %Fréquence du sinus
fe = 16000; %Fréquence d'échantillonage
A=2;
T0 = 1/f0;
Te = 1/fe;
D = 2;
t = (0:Te:D);
nt0 = ceil(5*(T0/Te)); % nbre d'échantillons
d=0.01;
K = ((d/T0)-1)/2;

figure;
subplot(nombrePlotsX,nombrePlotsY,1);
x1 = A*sin(2*pi*f0*t);
analyze(t, x1, fe, nt0);

x2 = abs(x1);
subplot(nombrePlotsX,nombrePlotsY,4);
analyze(t, x2, fe, nt0);

x3 = [];
modulo = mod(t,T0);
for i = 1:length(modulo)
    index = modulo(1,i);
    if index<(T0/2) && index>=0
        x3 = [x3, 2];
    else
        x3 = [x3, 0.5];
    end
end
subplot(nombrePlotsX,nombrePlotsY,7);
analyze(t, x3, fe, nt0);

nt0 = ceil(5*(T0/Te));
B=1.80; % à corriger
%f0 = 1/80^(-3);
f0 = 1000;
T0 = 1/f0;
nt0 = ceil(5*(T0/Te));
phi = pi/3;
y = B*sin(2*pi*f0*t+phi);
subplot(nombrePlotsX,nombrePlotsY,10);
analyze(t, y, fe, nt0);

marteaufile = 'MarteauPiqueur01.mp3';
jardin1file = 'Jardin01.mp3';
jardin2file = 'Jardin02.mp3';
ville1file = 'Ville01.mp3';

S = -48;
G = 30;
P_SPL = 60;
Dt = 1;
dt = 0.5;
K=(1/100*Te-1)/2;

[y,Fs]=audioread(marteaufile);
n = length(y);
isNoise = false;
countSilent = 0;
countNoise = 0;

puissancemoyenne(marteaufile)

for i=1:n-K
    if <P_SPL
        countSilent = countSilent+1;
        if countSilent >= 22050 && isNoise==true
            isNoise = false;
            disp("Bruit pénible pendant : " + countNoise/Fs + "s")
            disp("Puissance moyenne du bruit : ")
        end
    end
       
    if y(1,i)>=P_SPL
        countNoise = countSilent + 1;
        if countNoise >= 44100 && isNoise==false
            isNoise = true;
            disp("Silence pendant : " + countSilent/Fs + "s")
        end
    end
end

function time = getTime(Fs, file)
[y,Fs]=audioread(file);
n=length(y);
time=(0:(n-1))/Fs;
end

function signal = fileToSignal(Fs, file)
[y,Fs]=audioread(file);
signal = y;
end

function Cxy = intercorellation(t, x, y, nt0, T0, emplacement)
Cxy = [];
n = length(x);
y1 = [y,zeros(1,n-1)];
for i=1:n
    Cxy = [Cxy, (1/n)*sum(x.*y1(i:n+i-1))];
end
subplot(4, 3, emplacement)
plot(t(1:nt0),x(1:nt0), 'b');
hold on
plot(t(1:nt0),y(1:nt0), 'g');
hold on
plot(t(1:nt0),Cxy(1:nt0), 'r');
xlabel('seconds');
title('Intercorrelation in the time domain');
zoom xon;
end

function P = puissanceinstant(file)
[x,Fs]=audioread(file);
length = getTime(Fs, file);
Ts = 1/Fs;
nt0 = length/Ts;
d=0.01;
K = ((d/Ts)-1)/2;
P=1;
for n=K+1:nt0-K
    P(n) = (1/(2*K+1)*sum(x(n-K:n+K).^2));
end
end

function f = analyze(t, x, fe, nt0)
plot(t(1:nt0),x(1:nt0));
xlabel('seconds');
title('Signal in the time domain - 5 periods');
zoom xon;
disp("Fréquence échantillonage : "+ fe);
% valeur moyenne
% valeur_moyenne = (1/n2)*sum(x);
Vm = mean(x(1:nt0));
disp("Vm = "+ Vm)
% puissance moyenne
Pm = mean(x(1:nt0).^2);
Pdbm = 10*log10((Pm/10^(-3)));
disp("Pm = "+ Pm +" W") % en W
disp("Pdbm = "+ Pdbm +" dBm") % en dBm
% valeur efficace
Aeff = sqrt(Pm);
disp("Aeff = "+ Aeff+ " W^(1/2)")
disp("------------------------------------")
end