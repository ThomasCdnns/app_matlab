clc
clear
[y, Fe] = audioread('100.wav');
t = linspace(0,length(y)/Fe,length(y));
figure(1) 
plot(t,y)

R = zeros(1,10);

A=y;
maxVal = max(A(1:Fe));
indinceMax = find(A == maxVal);
c = indinceMax(indinceMax>=1 & indinceMax<=(Fe));

k=1;
for i = 1:1:2*length(y)/Fe-3
maxVal1 = max(A(Fe +(Fe*i)/2 : (Fe*i)/2 + 3*Fe/2 ));
    if maxVal1 <= maxVal*1.1 && maxVal1 >= maxVal*0.9
        indincex1 = find(A == maxVal1);
        b = indincex1(indincex1>=(Fe*i/2+Fe) & indincex1<=(Fe*i/2 + 3*Fe/2));
        distance = b(1) - c(1);
        if distance>=126
            c = b;
            tempsDiff=10*distance/3600;
            bpm = 60/tempsDiff(1);
            R(k) = ceil(bpm);
            k=k+1;
        end
    end
end
disp(sum(R)/k+1 + " bpm")


