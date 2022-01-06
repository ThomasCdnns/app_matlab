clear
clc

f0 = 440;
fe1 = 8000;
A = 1;
D = 0.1;

T0 = 1/f0;
Te1 = 1/fe1;

t = (0:Te1:D);
n = ceil(5*(T0/Te1));

figure;
subplot(2,1,1))
x = A*sin(2*pi*f0*t);
plot(t(1:n),x(1:n))
xlabel('seconds')
title('Signal in the time domain - 5 periods');
zoom xon;

subplot(2,1,2)
xlabel('frequency')
title('')
plot(abs(fft(x)))