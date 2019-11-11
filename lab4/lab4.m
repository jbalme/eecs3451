%% EECS 3451 Lab 4


%% AUTHORS
% 
% * Jonathan Baldwin (212095691)
% * Mark Savin       (212921128)
% * Sarwat Shaheen   (214677322)
%

%% Q1 - Fourier Coefficients of a Rectangular Pulse

Fs = 100e3;             % 100 kHz sampling rate
Ts = 1/Fs;              % sampling period

T=1e-3;

t=-T/2:Ts:T/2;

d=-1:T:1;                % 1ms period
w=0.1e-3;                % .1 ms pulse width

x = rectpuls(t,w);

N = length(x);
k=-(N-1)/2:(N-1)/2;
C=zeros(1,length(k));
n=t/Ts;

for i1=1:length(k)
    for i2=1:length(x)
        C(i1)=C(i1)+1/N*x(i2)*exp(-1i*2*pi*k(i1)*n(i2)/N);
    end
end

figure;
sgtitle('Fourier Coefficients of a 0.1ms Rectangular Pulse');

plot1 = subplot(3,1,1);
plot(t,x);
title('0.1ms Rectangular Pulse');
xlabel('Time');
ylabel('Value');

plot2 = subplot(3,1,2);
stem(k, abs(C));
title('Magnitude of the `k`-th Fourier Coefficient');
xlabel('k');
ylabel('Magnitude');

plot3 = subplot(3,1,3);
stem(k, angle(C)*130/pi);
title('Phase of the `k`-th Fourier Coefficient');
xlabel('k');
ylabel('Phase');

%% Q2 - DTFT of x(n)={1,2,3,4,5} from 0 to \pi

n = -1:3; 
x = 1:5;                  
k = 0:500; 
w = (pi/500)*k;          

W = exp(-1i * pi * n' * w);

X = x * W ;

figure;
sgtitle('Discrete Time Fourier Transform of x(t)={1,2,3,4,5}');

subplot(2, 2, 1);
plot(w,abs(X));
title('Magnitude Plot'); 
xlabel('Frequency'); 
ylabel('Magnitude');

subplot(2, 2, 2);
plot(w,angle(X));
title('Angle Plot'); 
xlabel('Frequency'); 
ylabel('Angle');

subplot(2, 2, 3);
plot(w,real(X));
title('Real Part'); 
xlabel('Frequency'); 
ylabel('Real');

subplot(2, 2, 4);
plot(w,imag(X));
title('Imaginary Part'); 
xlabel('Frequency'); 
ylabel('Imaginary');

%% Q3 Gaussian Pulse
% When we take the zero-centered FFT of a gaussian pulse, the magnitude of
% the FFT is shaped like a gaussian pulse.

Fs = 50;
Ts = 1/Fs;
sigma = 0.05;

t=-1:Ts:1;

x = 1/sqrt(2*pi*sigma^2)*exp(-t.^2/(2*sigma^2));

N = length(x);
NFFT = N;

F = Fs*(-NFFT/2:NFFT/2-1)/NFFT;
Y = fftshift(fft(x, NFFT));     % Use fftshift to zero-center the fft

figure;
sgtitle("Gaussian Pulse: Time Domain vs Frequency Domain");

plot1 = subplot(3,1,1);
plot(t,x);
title("Gaussian Pulse (\sigma=" + num2str(sigma) + ")");
xlabel("Time");
ylabel("Value");

plot2 = subplot(3,1,2);
plot(F, abs(Y)/N, 'r');
title("FFT of Gaussian Pulse")
xlabel("Frequency");
ylabel("Magnitude");

%% Problem - 4
% Here we do frequency analysis on the Blues Brothers clip from Lab 2.
% When we look at the magnitude response of the audio signal, we can see
% the largest peaks in the 400-600 Hz range.

[x, Fs] = audioread('audio.wav');

N = length(x);
NFFT = 2^12;

X = fft(x, NFFT);
F = Fs*(0:NFFT-1)/NFFT;

figure;
sgtitle('Frequency Analysis of "Blues Brothers" Audio Sample');

plot1 = subplot(2,1,1);
plot(F(1:NFFT/2),abs(X(1:NFFT/2)));
title('Magnitude response of the audio signal');
xlabel('Frequency (Hz)');
ylabel('Magnitude response');

plot2 = subplot(2,1,2);
plot(F(1:NFFT/2),angle(X(1:NFFT/2)));
title('Phase response of the audio signal');
xlabel('Frequency (Hz)');
ylabel('Phase response (radians)');


%% Problem - 5
% To increase the frequency resolution, we can either increase the number
% of samples while keeping sample rate constant (which has the downside of 
% needing to capture and process more samples), or decrease the sampling
% rate while keeping number of samples constant (which has the downside of 
% lowering the maximum frequency we can resolve.) The former is preferable
% here.

Ts = 0.999e-3;
Fs = 1/Ts;
t = 0:Ts:1;
f1 = 1000;
x = sin(2*f1*t) + (1/3)*sin(2*3*f1*t) + (1/5)*sin(2*5*f1*t);

N = length(X);
NFFT = N;
F = Fs*(0:NFFT-1)/NFFT;
X = fft(x, NFFT);

figure;
sgtitle("FFT of a deterministic periodic signal");

subplot(3,2,1);
plot(t, x);
xlabel("Time");
ylabel("Signal");
title("x(t) in time domain");

subplot(3,2,3);
stem(F,abs(X));
xlabel("Frequency");
ylabel("Magnitude");
title("|X(t)| in frequency domain");

subplot(3,2,5);
stem(F,angle(X));
xlabel("Frequency");
ylabel("Phase");
title("\theta(X(t)) in frequency domain");

Ts = 0.999e-3;
Fs = 1/Ts;
t = 0:Ts:2;
f1 = 1000;
x = sin(2*f1*t) + (1/3)*sin(2*3*f1*t) + (1/5)*sin(2*5*f1*t);

N = length(X);
NFFT = N;
F = Fs*(0:NFFT-1)/NFFT;
X = fft(x, NFFT);

subplot(3,2,2);
plot(t, x);
xlabel("Time");
ylabel("Signal");
title("x(t) (2x samples)");

subplot(3,2,4);
stem(F,abs(X));
xlabel("Frequency");
ylabel("Magnitude");
title("|X(t)| (2x samples)");

subplot(3,2,6);
stem(F,angle(X));
xlabel("Frequency");
ylabel("Phase");
title("\theta(X(t)) (2x samples)");

%% Problem - 6
% When we plot the noisy signal against the original, we can see that the
% noise is a lot more noticeable in the time domain, compared to the
% frequency domain.

Ts = 0.999e-3;
Fs = 1/Ts;
t = 0:Ts:1;
f1 = 1000;
x = sin(2*f1*t) + (1/3)*sin(2*3*f1*t) + (1/5)*sin(2*5*f1*t);
xNoisy = x + randn(size(x));

N = length(X);
NFFT = N;
F = Fs*(0:NFFT-1)/NFFT;
X = fft(x, NFFT);
XNoisy = fft(xNoisy, NFFT);

figure;
sgtitle("Time vs Frequency of Original vs Noisy Signal");

subplot(3,2,1);
plot(t,x);
xlabel("Time");
ylabel("Signal");
title("Original, time domain");

subplot(3,2,3);
stem(F,abs(X));
xlabel("Frequency")
ylabel("Signal")    
title("Original, magnitude response");

subplot(3,2,5);
stem(F,(angle(X)));
xlabel("Frequency")
ylabel("Signal")    
title("Original, phase response");

subplot(3,2,2);
plot(t,xNoisy);
xlabel("Time");
ylabel("Signal");
title("Noisy, time");

subplot(3,2,4);
stem(F,abs(XNoisy));
xlabel("Frequency")
ylabel("Signal")    
title("Noisy, magnitude response");

subplot(3,2,6);
stem(F,(angle(XNoisy)));
xlabel("Frequency")
ylabel("Signal")    
title("Noisy, phase response");

%% What we learned
% In this lab we learned how to calculate Fourier coefficients in MATLAB,
% how to use the Fast-Fourier Transform to convert from the time domain to
% the frequency domain, how to increase the frequency resolution of the
% FFT, and how noise is less perceptible in the frequency domain.