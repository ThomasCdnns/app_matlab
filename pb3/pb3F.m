clear
clc

%Sample the signal, sound it and plot it.
[y,Fs]=audioread('Pi_C_96K.wav');
disp(Fs)
n=length(y);
soundsc(y);