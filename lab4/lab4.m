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

n = -1:3; 
x = 1:5;                  
k = 0:500; 
w = (pi/500)*k;          

W = exp(-1i * pi * n' * w);

X = x * W ;

mag = abs(X); 
subplot(2, 2, 1);
plot(k/500,mag);
title('Magnitude Plot'); 
xlabel('Frequency'); 
ylabel('Magnitude');

angC = angle(X);
subplot(2, 2, 2);
plot(k/500,angC);
title('Angle Plot'); 
xlabel('Frequency'); 
ylabel('Angle');

real = real(X);
subplot(2, 2, 3);
plot(k/500,real);
title('Real Part'); 
xlabel('Frequency'); 
ylabel('Real');

img = imag(X);
subplot(2, 2, 4);
plot(k/500,img);
title('Imaginary Part'); 
xlabel('Frequency'); 
ylabel('Imaginary');


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
