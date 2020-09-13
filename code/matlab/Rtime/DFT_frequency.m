% clc
% clear all
%% read the data from RP.plt
[RT,Bc]= readRP();
%%
L = 2000;                     % Length of signal
iN=30001;
Rs=RT(iN:(iN+L),2);
t = (0:L)*T;                % Time vector
%%
Fs = 100;                    % Sampling frequency
T = 1/Fs;                     % Sample time

%%
% type one
% y = 0.7*sin(2*pi*5*t) + sin(2*pi*12*t); 

% type two
% for i=1:L
% y(i) = 0.7*sin(2*pi*5*t(i))*exp(-pi*t(i)*t(i)); 
% end

% type three
y=Rs;

plot(Fs*t(1:3000),y(1:3000))
title('Signal Corrupted with Zero-Mean Random Noise')
xlabel('time (milliseconds)')

NFFT = 2^nextpow2(L); % Next power of 2 from length of y
Y = fft(y,NFFT)/L;
f = Fs/2*linspace(0,1,NFFT/2+1);

% Plot single-sided amplitude spectrum.
figure
plot(f,2*abs(Y(1:NFFT/2+1))) 
title('Single-Sided Amplitude Spectrum of y(t)')
xlabel('Frequency (Hz)')
ylabel('|Y(f)|')

