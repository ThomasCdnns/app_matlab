k=6;
lenz3=mod(length(z2),k);     %nb d'echantillons dans z3
z3=z2(1:k:end);
Tt=1/Ft;                    %période d'echantillonnage de base
Tez3=k*Tt;                  %période du signal sous-echan
Fz3=1/Tez3;                 %frequence du signal sous-echan
z3Duration=length(z3)/Fz3;  %

t6=0:Tez3:z3Duration;
t6(1)=[];
figure(6)
subplot(2,1,1)
plot(t6,z3)

Z3=fft(z3,M);
modZ3=abs(Z3);
L6=length(modZ3);
f6=0:Fz3/L6:(L6-1)*Fz3/L6;
subplot(2,1,2)
plot(f6,modZ3)