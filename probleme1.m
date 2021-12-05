f0 = 1000; %Fréquence du sinus
fe = 16000; %Fréquence d'échantillonage
A=2;
T0 = 1/f0;
Te = 1/fe;
D = 2;
t = (0:Te:D);
nt0 = ceil(5*(T0/Te)); % nbre d'échantillons (cast it to closest integer -->  ceil)

figure;
subplot(3,1,1);
x1 = A*sin(2*pi*f0*t);
analyze(t, x1, fe, nt0);
x2 = abs(x1);
subplot(3,1,2);
analyze(t, x2, fe, nt0);
x3 = [];
modulo = mod(t,T0);
for i = 1:length(modulo)
    index = modulo(1,i);
    if index<(T0/2) && index>=0
        x3 = [x3, 2];
    else
        x3 = [x3, 0.5];
    end
end

subplot(3,1,3);
analyze(t, x3, fe, nt0);

function f = analyze(t, x, fe, nt0)
plot(t(1:nt0),x(1:nt0));
xlabel('seconds');
title('Signal in the time domain - 5 periods');
zoom xon;

disp("Fréquence échantillonage : "+ fe);
% valeur moyenne
% valeur_moyenne = (1/n2)*sum(x);
Vm = mean(x(1:nt0));
disp("Vm = "+ Vm);
% puissance moyenne
% puissance_moyenne = (1/n2)*sum(x_squared);
Pm = mean(x(1:nt0).^2);
disp("Pm = "+ Pm +" W") % en W et dBm
% valeur efficace
Aeff = sqrt(Pm);
disp("Aeff = "+ Aeff+ " W^(1/2)")
disp("------------------------------------")
end


