%% Q1

T = 5;
Fs = 400;
Ts = 1/Fs;
Fc = 100;
t = 0:Ts:1-Ts;
x = cos(10*pi.*t);

[xm,tm] = modulate(x,Fc,Fs);
[F, X] = do_fft(x, Fs);
[Fm, Xm] = do_fft(xm, Fc);

subplot(2,2,1);
plot(t, x);
title(["Original signal", "(Time domain)"]);
xlabel("Time (s)");
ylabel("value");

subplot(2,2,2);
plot(F, abs(X));
title(["Original signal", "(Frequency domain)"]);
xlabel("Frequency (Hz)");
ylabel("Magnitude");

subplot(2,2,3);
plot(tm,xm);
title(["Modulated signal", "(Time domain)"]);
xlabel("Time (s)");
ylabel("Value");

subplot(2,2,4);
plot(F, abs(Xm));
title(["Modulated signal", "(Frequency domain)"]);
xlabel("Frequency (Hz)");
ylabel("Magnitude");

save q1.mat t tm x xm Fs Fc


%% Q2

% Read original signal
[x, Fs] = audioread('P_12_1.wav');
x = x';
t = (0:length(x)-1)/Fs; % time domain of original signal

% Generate FFT and plot
subplot(4,2,1);
plot(t,x);
title('input file');

fp1 = subplot(4,2,2);
[F, X] = do_fft(x, Fs);
plot(F, abs(X));

title('input file');

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
title('downsampled');

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


%% Q3

load q1.mat t x xm Fs Fc

x2 = xm.*cos(2*pi*Fc*t);            % demodulate the signal
x2f = low_pass_filter(x2,Fs,Fc/2);  % low pass with cutoff Fc/2
[F2, X2] = do_fft(x2, Fs);
[F2f, X2f] = do_fft(x2f, Fs);
[F, X] = do_fft(x, Fs);

subplot(3,2,1);
plot(t,x2);
title(["Demodulated signal", "(Time domain)"]);
xlabel('Time (s)');
ylabel('Value');

subplot(3,2,2);
plot(F2, abs(X2));
title(["Demodulated signal", "(Frequency domain)"]);
xlabel('Frequency (Hz)');
ylabel('Magnitude');


subplot(3,2,3);
plot(t,x2f);
title(["Filtered signal", "(Time domain)"]);
xlabel('Time (s)');
ylabel('Value');

subplot(3,2,4);
plot(F2f, abs(X2f));
title(["Filtered signal", "(Frequency domain)"]);
xlabel('Frequency (Hz)');
ylabel('Magnitude');

subplot(3,2,5);
plot(t,x);
title(["Original signal", "(Time domain)"]);
xlabel('Time (s)');
ylabel('Value');


subplot(3,2,6);
plot(F, abs(X));
title(['Original signal', '(Frequency domain)']);
xlabel('Frequency (Hz)');
ylabel('Magnitude');

%% Q4

[xm, Fs] = audioread("P_12_2.WAV");  %  Reading the input audio file provided in Moodle
t = (0:length(xm)-1)/Fs;
xm = xm';

Fc = 16000; % Carrier frequency of 16000, determined by plotting the FFT of xm
x2 = xm .* cos(2*pi*Fc*t);
x2f = low_pass_filter(x2, Fs, Fc/2);

[Fm,Xm] = do_fft(xm, Fs);
[F2f,X2f] = do_fft(x2f, Fs);

subplot(2,2,1);
plot(t,xm);
subplot(2,2,3);
plot(t,x2f);
subplot(2,2,2);
plot(Fm,abs(Xm));
subplot(2,2,4);
plot(F2f,abs(X2f));

playsound(x2f, Fs);


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
    y = real(ifft(ifftshift(X)));
end
