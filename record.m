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


soma = y + y2;
subplot(3, 1, 1);
plot(y);
subplot(3, 1, 2);
plot(y2);

%p = audioplayer(soma, Fs);

%play(p);
subplot(3,1,3);
plot(soma);

r = snr(y, y2);
