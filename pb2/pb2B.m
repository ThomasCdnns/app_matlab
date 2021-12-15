clear
clc

F1 = 1440; %Fréquence du sinus
F2 = 2000;
Fe = 8000; %Fréquence d'échantillonage
A=1;
T1 = 1/F1;
T2 = 1/F2;
Te = 1/Fe;
D = 1;
t = (0:Te:D);
n1 = ceil(5*(T1/Te)); % nbre d'échantillons
n2 = ceil(5*(T2/Te));
x1 = A*sin(2*pi*F1*t);
x2=A*sin(2*pi*F2*t);
y = x1.*x2;
N = length(y); 
delta_f = Fe/N;                  
vf1 = (0:N-1) * delta_f;

figure;
subplot(5,1,1)
plot(t(1:n1),x1(1:n1));
xlabel('seconds');
title('Signal in the time domain - 5 periods');
zoom xon;

subplot(5,1,2)
x2=A*sin(2*pi*F2*t);
plot(t(1:n2),x1(1:n2));
xlabel('seconds');
title('Signal in the time domain - 5 periods');
zoom xon;

subplot(5,1,3)
y = x1.*x2;
N = length(y); 
plot(t(1:n1),y(1:n1));
xlabel('seconds');
title('X1 multiplied by X2 - 5 periods');
zoom xon;

subplot(5,1,4)
ffty = abs(fft(y));
plot(vf1,ffty);
title('FFT de Y');
ylabel('Hz')
zoom xon;

subplot(5,1,5)
ffty_db = 20*log10(ffty);
plot(vf1, ffty_db)
ylabel('dB');
title('FFT de Y');
zoom xon;


