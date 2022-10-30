%%
clc
clear
clear all
%%
fontSize = 20;
windowSizes = 10 : 2 : 100

for k = 1 : length(windowSizes)
  smoothedSignal = movmean(y2, windowSizes(k));
  sad(k) = sum(abs(smoothedSignal - y2));
end
subplot(2, 1, 2);
plot(windowSizes, sad, 'b*-', 'LineWidth', 2);
grid on;
xlabel('Window Size', 'FontSize', fontSize);
ylabel('SAD', 'FontSize', fontSize);
disp("EXECUTANDO");

[a,b]=min(sad);
%Melhor Janela
fprintf('Melhor Janela:\n')
windowSizes(b)


