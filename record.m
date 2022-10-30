Fs = 8000;
nBits = 16;
nChannels = 1;

recObj = audiorecorder(Fs,nBits,nChannels);
recObj2 = audiorecorder(Fs, nBits, nChannels);
recDuration = 5; % record for 5 seconds



disp("Som: ")
recordblocking(recObj,recDuration);
disp("Ruido: ")
recordblocking(recObj2,recDuration);

y = getaudiodata(recObj);
y2 = getaudiodata(recObj2);

t = 0:seconds(1/Fs):seconds(5);
t = t(1:end-1);


soma = y + y2;
%subplot(3, 2, 1);
%plot(t, y);
%xlim([0 Fs*recDuration]);
%xlabel('Tempo(s)');
%ylabel('Decibeis(dB)');
%title('Som');

subplot(3, 1, 1);
plot(t, y2);
ylim([-0.2 0.2]);
xlabel('Tempo(s)');
ylabel('Decibeis(dB)');
title('Ruido');


%p = audioplayer(soma, Fs);

%play(p);

subplot(3,1,2);
plot(t, soma);
xlabel('Tempo(s)');
ylabel('Decibeis(dB)');
title('Soma')

r = snr(y, y2);

window = 10;
mask = ones(1, window)/window;
movingAverage = conv(y2, mask,'same');
teste = movmean(y2, window);
subplot(3, 1, 2);
plot(t, movingAverage);
ylim([-0.2 0.2]);
xlabel('Tempo(s)');
ylabel('Decibeis(dB)');
title('Media movel');

cleanFilter = y2 - movingAverage;
subplot(3, 1, 3);
plot(t, cleanFilter);
ylim([-0.2 0.2]);
xlabel('Tempo(s)');
ylabel('Decibeis(dB)');
title('Grafico de erro');


tocar = audioplayer(movingAverage, Fs);
tocar2 = audioplayer(y2, Fs);


disp("Tocando Ruido...");
play(tocar);


