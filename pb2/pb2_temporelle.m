clc
clear

file="105.wav";
disp(getBPM(file))

function bpm = getBPM(file)

[y, Fs] = audioread(file);
Ts = 1/Fs;
y_size = length(y);
duree = (y_size-1)*Ts;
t = 0:Ts:duree;
figure(1)
plot(t,y)

R = zeros(1,10);

max_value = max(y(1:Fs));
max_indice = find(y == max_value);
pic2 = max_indice(max_indice>=1 & max_indice<=Fs);

k=1;
for i = 1:1:2*length(y)/Fs-3
max_value_1 = max(y(Fs+(Fs*i)/2:(Fs*i)/2+3*Fs/2));
    if max_value_1 <= max_value*1.15 && max_value_1>=max_value*0.85
        max_indice_1 = find(y == max_value_1);
        pic1 = max_indice_1(max_indice_1>=(Fs*i/2+Fs) & max_indice_1<=(Fs*i/2 + 3*Fs/2));
        distance = pic1(1) - pic2(1);
        if distance>=50
            pic2 = pic1;
            deltaT=10*distance/3600;
            bpm = 60/deltaT(1);
            R(k) = ceil(bpm);
            k=k+1;
        end
    end
end
bpm=sum(R)/k+1;
end

