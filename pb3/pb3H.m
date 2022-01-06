clear
clc

%Sample the signal, sound it and plot it.
[y,Fs]=audioread('Pi_C_96K.wav');
n=length(y);
t=(0:(n-1))/Fs;
z = 1/2*(y(:,1) + y(:,2));

subplot(3,1,1);
plot(t,z)
title('Temporal signal variation')
xlabel('time(s)')

Y = fft(z);
L=length(y);

f = Fs*(0:(L/2))/L;
f1 = Fs*(0:(L-1))/L;

subplot(3,1,2);
plot(f1,abs(Y))
title('Amplitude Spectrum')
xlabel('f (Hz)')
ylabel('Magnitude')

P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

subplot(3,1,3);
plot(f,P1) 
title('Single-Sided Amplitude Spectrum')
xlabel('f (Hz)')
ylabel('Magnitude')