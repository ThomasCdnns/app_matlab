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

x = A*sin(2*pi*f0*t);

B=1.80; % à corriger
phi = pi/3;

y = B*sin(2*pi*f0*t+phi);

Cx = [];
nx = length(x);
x1 = [x,zeros(1,nx-1)];
for i=1:nx
    Cx = [Cx, (1/nx)*sum(x.*x1(i:nx+i-1))];
end

Cxy = [];
nx = length(x);
y1 = [y,zeros(1,nx-1)];
for i=1:nx
    Cxy = [Cxy, (1/nx)*sum(x.*y1(i:nx+i-1))];
end

figure;
subplot(2,1,1)
plot(t(1:n), x(1:n), 'b')
hold on
plot(t(1:n),Cx(1:n), 'g')
xlabel('seconds')
title('Autocorrelation of signal x')

subplot(2,1,2)
plot(t(1:n), y(1:n), 'b')
hold on
plot(t(1:n),x(1:n), 'g')
hold on
plot(t(1:n),Cxy(1:n), 'r')
xlabel('seconds')
title('Intercorrelation between signal x and y')
zoom xon