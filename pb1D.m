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
B=1.80; % à corriger
phi = pi/3;
y = B*sin(2*pi*f0*t+phi);

plot(t(1:n), y(1:n))