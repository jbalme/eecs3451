%% Q1

T = 5;
Fs = 400;
Ts = 1/Fs;
Fc = 100;
t = 0:Ts:1-Ts;
x = cos(10*pi.*t);

[xm,tm] = modulate(x,Fc,Fs);

subplot(2,2,1);
plot(t, x);

[F, X] = do_fft(x, Fs);

subplot(2,2,2);
plot(F, abs(X));

subplot(2,2,3);
plot(tm,xm);

[Fm, Xm] = do_fft(xm, Fc);

subplot(2,2,4);
plot(F, abs(Xm));

save q1.mat t tm x xm Fs Fc


%% Q2

% Read original signal
[x, Fs] = audioread('test.wav');
x = x';
t = (0:length(x)-1)/Fs; % time domain of original signal

% Generate FFT and plot
subplot(4,2,1);
plot(t,x);

fp1 = subplot(4,2,2);
[F, X] = do_fft(x, Fs);
plot(F, abs(X));
% Downsample to 8kHz
Fc = 8000;
Fs2 = Fc; % Effective bandwidth = 4000 Hz

td = 0:1/Fs2:max(t);
xd = interp1(t,x,td,'linear');

% generate FFT and plot
subplot(4,2,3);
plot(td, xd);

fp2 = subplot(4,2,4);
[F, X] = do_fft(xd, Fs2);
plot(F, abs(X));

% Upsample to 24kHz
Fs3 = 2*Fc+Fs2;

Fsu = Fs3;

tu = 0:1/Fsu:max(td);
xu = interp1(td,xd,tu,'linear');

% generate FFT and plot
subplot(4,2,5);
plot(tu, xu);

fp3 = subplot(4,2,6);
[F, X] = do_fft(xu, Fsu);
plot(F, abs(X));

% modulate
xm = modulate(xu, tu, Fc);

% generate FFT and plot
subplot(4,2,7);
plot(tu, xm);

fp4 = subplot(4,2,8);
[F, X] = do_fft(xm, Fsu);
plot(F, abs(X));

linkaxes([fp1, fp2, fp3, fp4], 'x')

%% Q3

load q1.mat t x xm Fs Fc

x2 = xm.*cos(2*pi*Fc*t);            % demodulate the signal
x2f = low_pass_filter(x2,Fs,Fc/2);  % low pass with cutoff Fc/2
[F2, X2] = do_fft(x2, Fs);
[F2f, X2f] = do_fft(x2f, Fs);
[F, X] = do_fft(x, Fs);

subplot(3,2,1);
plot(t,x2);
title('demodulated signal');
xlabel('time');
ylabel('value');

subplot(3,2,2);
plot(F2, abs(X2));
title('demodulated signal')

subplot(3,2,3);
plot(t,x2f);

subplot(3,2,4);
plot(F2f, abs(X2f));
title('low-pass filtered demodulated signal');

subplot(3,2,5);
plot(t,x);

subplot(3,2,6);
plot(F, abs(X));
title('original signal');

%% foo

t = linspace(1,10,1024);
x = -(t-5).^2  + 2;
y = awgn(x,0.5);
z = low_pass_filter(y, 1024, 20);

function playsound(y, Fs)
%PLAYSOUND blocking version of sound()
    % On Linux, refuses to play at anything other than 44100 Hz
    if isunix()
        y = resample(y,44100,Fs);
        Fs = 44100;
    end
    playblocking(audioplayer(y,Fs));
end

function [F, X] = do_fft(x,Fs)
    NFFT = length(x);
    F = Fs*(-NFFT/2:NFFT/2-1)/NFFT;
    X = fftshift(fft(x,NFFT));
end

function y = low_pass_filter(x,Fs,cutoff)
    NFFT = length(x);
    X = fftshift(fft(x, NFFT));
    F = Fs*(-NFFT/2:NFFT/2-1)/NFFT;
    R = rectpuls(F,2*cutoff);
    X = X.*R;
    y = real(ifft(fftshift(X)));
end
