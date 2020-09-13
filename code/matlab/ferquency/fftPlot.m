function [fre,mag] = fftPlot( fs,t,x )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


[m,N]=size(t);

n=0:N-1;
y=fft(x,N);   %???????Fourier??
mag=abs(y);   %??Fourier?????
fre=n*fs/N;
figure
subplot(2,1,1),plot(t,x); %??????????
xlabel('T');
ylabel('R');title('BR');grid on;
subplot(2,1,2)
plot(fre(2:N/2),mag(2:N/2)); %??Nyquist????????????
xlabel('f/Hz');
ylabel('a');title('fft');grid on;

end

