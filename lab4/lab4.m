%% Foo Bar

Fs=100;

t=0:1/Fs:10;
signal=cos(2*pi*4*t);
transform=normfft(signal);

figure
plot(t,signal);

figure
stem(freqdomain(length(t),Fs),abs(normfft(signal, 10)));

%hold on
%plot(t,real(transform));
%plot(t,imag(transform));


%% Q1 

Fs = 10e3;              % 10 kHz sampling rate
Ts = 1/Fs;              % sampling period

t=0:Ts:1-Ts;

d=0:1e-3:1;             % 1ms period
w=0.1e-3;               % .1 ms pulse width

signal = pulstran(t,d,@rectpuls,w);

figure
plot(t,signal);
xlim([0 .01]);
ylim([0 1]);

figure
stem(freqdomain(length(signal),Fs),normfft(signal));

%% 

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
