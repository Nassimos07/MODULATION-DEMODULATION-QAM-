
clc
clear 
close all
M=256;
[y, Fs] = audioread('xylophone.wav'); %L'audio est enregistré dans y et échantilloné a la fréquence Fs
max_value = max(y); %valeur max de l'audio
min_value = min(y); %valeur min de l'audio
l=12;
x = []; %vecteur 
step_size = (max_value - min_value)/(12); %calcul du pas 
i = min_value;
while ((i>=min_value) && (i<=max_value)) %calcul des valeurs du pas
x = [x,i];
i = i + step_size;
end
for i=1:length(y) %quantification
for j=1:(length(x)-1)
if((y(i)>=x(j))&& (y(i)<=x(j+1))) %vérifier la marge dans la quelle se trouve chaque valeur de y 
y1(i) = x(j+1); %échantillon quantifié 
end
end
end
figure(2)
plot(y);
title('Original audio signal');
figure(3);
plot(y1);
title('Quantized audio signal');
% QAM sur signal quantifié

y2 = zeros(1,length(y1)); % va contenir le signal encodé
for i = 2:length(x)
for j = 1:length(y1)
if(x(i)==y1(j))
y2(j) = i-2;
end
end
end
qam = qammod(y2,M,'PlotConstellation',true);
figure(5)
plot(qam)
title('QAM modulation signal');
demodulated =qamdemod(qam,M);
figure(6)
plot(demodulated)