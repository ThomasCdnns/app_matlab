clc;
close all;
clear variables;

Fe = 8000;               
D = 0.050;
Te = 1/Fe;               
t = 0:Te:D;           
n = length(t);    

y = zeros(1,n);
y(t<=0.005) = 1;

N = length (y); 

fft_y = abs (fft(y));            
fft_dB_y = 20*log10(fft_y);      

delta_f = Fe/N;                  
vf1 = (0:N-1) * delta_f;                   
  
figure(1);                       
subplot (3,1,1)                   

plot(t, y);
xlabel('Temps en s');
ylabel('amplitude en V');
title('Signal y');

subplot (3,1,2)

plot(vf1, fft_y);
xlabel('Fréquence en Hz');
ylabel('Amplitude en Volts');
title('FFT du signal y en Volts');

subplot (3,1,3)
plot(vf1, fft_dB_y);
xlabel('Fréquence en Hz');
ylabel('|X(f)| en dB');
title('FFT du signal y en dB');