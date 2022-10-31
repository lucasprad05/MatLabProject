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

%%
soma = y + y2;
subplot(3, 1, 1);
plot(t, y);
%xlim([0 FsrecDuration]);
xlabel('Tempo(s)');
ylabel('Amplitude');
title('Som');

subplot(3, 1, 2);
plot(t, y2, 'r');
ylim([-0.2 0.2]);
xlabel('Tempo(s)');
ylabel('Amplitude');
title('Ruido');

p = audioplayer(soma, Fs);

play(p);

subplot(3,1,3);
plot(t, soma, 'g');
xlabel('Tempo(s)');
ylabel('Amplitude');
title('Soma')

r = snr(y, y2);
fprintf('snr:\n')
r

%%
fontSize = 10;
windowSizes = 10 : 2 : 100;

for k = 1 : length(windowSizes)
  smoothedSignal = movmean(soma, windowSizes(k));
  sad(k) = sum(abs(smoothedSignal - y));
end
[a,b]=min(sad);
%Melhor Janela
fprintf('Melhor Janela:\n')
windowSizes(b)

window = windowSizes(b);
mask = ones(1, window)/window;
movingAverage = conv(y2, mask,'same');
teste = movmean(y2, window);
figure

subplot(3, 1, 1);
plot(t, y2, 'r');
ylim([-0.2 0.2]);
xlabel('Tempo(s)');
ylabel('Amplitude');
title('Ruido');

subplot(3, 1, 2);
plot(t, movingAverage, 'k');

ylim([-0.2 0.2]);
xlabel('Tempo(s)');
ylabel('Amplitude');
title('Media movel');

cleanFilter = y2 - movingAverage;

subplot(3, 1, 3);
plot(t, cleanFilter, 'y');
ylim([-0.2 0.2]);
xlabel('Tempo(s)');
ylabel('Amplitude');
title('Grafico de erro');


tocar = audioplayer(movingAverage, Fs);
tocar2 = audioplayer(y2, Fs);


%disp("Tocando Ruido...");
%play(tocar);


%%
figure
plot(windowSizes, sad, 'bo-', 'LineWidth', 2);
grid on;
xlabel('Window Size', 'FontSize', fontSize);
ylabel('SAD', 'FontSize', fontSize);
disp("EXECUTANDO");

disp("Tocando Ruido...");
play(tocar);


