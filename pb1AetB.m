clear
clc

f0 = 1000; %Fréquence du sinus
fe = 16000; %Fréquence d'échantillonage
A=2;
T0 = 1/f0;
Te = 1/fe;
D = 2;
t = (0:Te:D);
n = ceil(5*(T0/Te)); % nbre d'échantillons

figure;
x = A*sin(2*pi*f0*t);
plot(t(1:n),x(1:n));
xlabel('seconds');
title('Signal in the time domain - 5 periods');
zoom xon;

% valeur moyenne
Vm = mean(x(1:n));
disp("Vm = "+ Vm)
% puissance moyenne
Pm = mean(x(1:n).^2);
Pdbm = 10*log10((Pm/10^(-3)));
disp("Pm = "+ Pm +" W") % en W
disp("Pdbm = "+ Pdbm +" dBm") % en dBm
% valeur efficace
Aeff = sqrt(Pm);
disp("Aeff = "+ Aeff+ " W^(1/2)")