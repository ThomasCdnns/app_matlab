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

x3 = abs(x);
subplot(2,1,1);
plot(t(1:n),x3(1:n));
xlabel('seconds');
title('Signal in the time domain - 5 periods');
zoom xon;
disp("Fréquence échantillonage : "+ fe);
% valeur moyenne
Vm = mean(x3(1:n));
disp("Vm = "+ Vm)
% puissance moyenne
Pm = mean(x3(1:n).^2);
Pdbm = 10*log10((Pm/10^(-3)));
disp("Pm = "+ Pm +" W") % en W
disp("Pdbm = "+ Pdbm +" dBm") % en dBm
% valeur efficace
Aeff = sqrt(Pm);
disp("Aeff = "+ Aeff+ " W^(1/2)")

x4 = [];
modulo = mod(t,T0);
for i = 1:length(modulo)
    index = modulo(1,i);
    if index<(T0/2) && index>=0
        x4 = [x4, 2];
    else
        x4 = [x4, 0.5];
    end
end
subplot(2,1,2);
plot(t(1:n),x4(1:n));
xlabel('seconds');
title('Signal in the time domain - 5 periods');
zoom xon;
disp("Fréquence échantillonage : "+ fe);
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
