clc
clear
[y, Fe] = audioread('102.wav');
t = linspace(0,length(y)/Fe,length(y));
figure(1)
plot(t,y)
L = length(y);
f1 = Fe*(0:(L-1))/L;
figure(2)
plot(t,abs(fft(y)))

R = zeros(1,10);

