clear
clc

f0 = 440;
fe1 = 8000;
fe2 = 500;
A = 1;
D = 0.1;

T0 = 1/f0;
Te1 = 1/fe1;
Te2 = 1/fe2;

t1 = (0:Te1:D);
t2 = (0:Te2:D);
n1 = ceil(5*(T0/Te1));
n2 = ceil(5*(T0/Te2));

figure;
s1 = A*sin(2*pi*f0*t1);
s2 = A*sin(2*pi*f0*t2);
plot(t1(1:n1),s1(1:n1))
hold on;
plot(t2(1:n2),s2(1:n2), 'mo')
xlabel('seconds')
title('Signal in the time domain - 5 periods');
zoom xon;