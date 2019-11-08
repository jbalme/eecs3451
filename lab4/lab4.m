%% Q1 

Fs = 10e3;              % 10 kHz sampling rate
Ts = 1/Fs;              % sampling period

t=0:Ts:1-Ts;

d=0:1e-3:1;             % 1ms period
w=0.1e-3;               % .1 ms pulse width

X = pulstran(t,d,@rectpuls,w);

figure
plot(t,X);
xlim([0 .01]);
ylim([0 1]);

figure
stem(freqdomain(length(X),Fs),normfft(X));

%% Q2
% To get the result of the fft to be 501 equi-spaced frequencies between 0
% and $\pi$, we need 501 samples of [1 2 3 4 5] at $\pi$ sample rate.

in = [1 2 3 4 5];

Fs = pi;                            % sample rate = pi
Ts = 1/Fs;

t = 0:Ts:500*Ts;
x = interp1(in, t, 'nearest', 0);   % take samples of input
F = ((0:1/500:1)*Fs).';             % calculate the frequency domain
Y = fft(x, 501);

figure;

sgtitle("[1,2,3,4,5] in frequency domain");

plot1 = subplot(2,2,1);
plot(F, abs(Y));
xlabel("Frequency");
ylabel("Magnitude");

plot2 = subplot(2,2,3);
plot(F, angle(Y));
xlabel("Frequency");
ylabel("Angle");

plot3 = subplot(2,2,2);
plot(F, real(Y));
xlabel("Frequency");
ylabel("Real");

plot4 = subplot(2,2,4);
plot(F, imag(Y));
xlabel("Frequency");
ylabel("Imaginary");


linkaxes([plot1, plot2], 'x');
linkaxes([plot3, plot4], 'x');

%% Q3 Gaus Puls
t=0:1e-2:5;
d=2.5;

in = pulstran(t,d,@gauspuls,1,10);
out = fft(in,length(in));

figure

plot(t,in);
hold on
plot(t,out);
plot(t,imag(out));
hold off

%% Problem - 4
[audio_in, audio_freq_sampl] = audioread('audio.wav');

audio_fft = fft(audio_in);

%Magnitude and phase plots of the audio signal used from back in Lab 2

figure
plot(abs(audio_fft));
title('Magnitude plot of Input Audio in Frequency Spectrum');
xlabel('Frequency(Hz)');
ylabel('Magnitude component');

figure
plot(angle(audio_fft));
title('Phase plot of Input Audio in Frequency Spectrum');
xlabel('Frequency(Hz)');
ylabel('Phase component');


%% Problem - 5
Fs = 10000;
t = 0:1/Fs:1;
f1 = 1000;
x = sin(2*f1*t) + (1/3)*sin(2*3*f1*t) + (1/5)*sin(2*5*f1*t);
xlabel("Time");
ylabel("Signal");
title("Plot of signal in the time domain");
plot(t, x);

stem(freqdomain(length(x),Fs),normfft(x));
xlabel("Frequency")
ylabel("Signal")
title("Plot of signal in the frequency domain")

%% Problem - 6
Fs = 10000;
t = 0:1/Fs:1;
f1 = 1000;
x = sin(2*f1*t) + (1/3)*sin(2*3*f1*t) + (1/5)*sin(2*5*f1*t);
xlabel("Time");
ylabel("Signal");
title("Plot of signal in the time domain");
plot(t, x);
stem(freqdomain(length(x),Fs),normfft(x));
xlabel("Frequency")
ylabel("Signal")    
title("Plot of signal in the frequency domain")

xlabel("Time");
ylabel("Signal");
title("Plot of noisy signal in the time domain");
noisySignal = x + (randn(size(x)) + 5);
plot(t, noisySignal);

xlabel("Frequency")
ylabel("Signal")    
title("Plot of noisy signal in the frequency domain")
stem(freqdomain(length(noisySignal),Fs),normfft(noisySignal))

%% fns

function y = freqdomain(N, Fs)
    if mod(N,2)==0
        k=-N/2:N/2-1;
    else
        k=-(N/2):(N-1)/2;
    end
    T=N/Fs;
    y=k/T;
end

function y = normfft(x, varargin)
    if length(varargin) == 0
        y = fftshift(fft(x)/length(x));
    else
        y = fftshift(fft(x,varargin{0})/length(x));
    end
end
