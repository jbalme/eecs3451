%% Q1

T = 5;
Fs = 400;
Ts = 1/Fs;
t = 0:Ts:1-Ts;
x = cos(10*pi.*t);
N = length(x);

NFFT = N;

F = Fs*(0:NFFT-1)/NFFT;
F = Fs*(-NFFT/2:NFFT/2-1)/NFFT;

X = fftshift(fft(x,NFFT));

xm = modulate(x,100,Fs);

playsound(xm, 100);

subplot(2,2,1);
plot(t, x);

subplot(2,2,2);
plot(F, abs(X));

subplot(2,2,3);
plot(t,xm);

subplot(2,2,4);
plot(F, abs(fftshift(fft(fm, NFFT))));

save q1.mat t x xm Fs


%% Q2

[x, Fs] = audioread('P_12_1.wav');

% playsound(x, Fs);

N = length(x);
NFFT = N;
F = Fs*(-NFFT/2:NFFT/2-1)/NFFT;
X = fftshift(fft(x,NFFT));
plot(F, X);



Fc = 8000;
t = (0:length(x)-1)/Fs;
Td = 0:1/Fc:max(t);
xd = interp1(t,x,td,'linear');


%% Q3

load q1.mat t x xm Fs

x2 = demod(xm,100,Fs);

plot(t,x2);
hold
plot(t,x);

function playsound(y, Fs)
%PLAYSOUND blocking version of sound()
    % On Linux, refuses to play at anything other than 44100 Hz
    if isunix()
        y = resample(y,44100,Fs);
        Fs = 44100;
    end
    playblocking(audioplayer(y,Fs));
end

function [F, X] = fancyfft(x,Fs)
    NFFT = length(x);
    F = Fs*(-NFFT/2:NFFT/2-1)/NFFT;
    X = fftshift(fft(x,NFFT));
end

