%% Foo Bar

Fs=100;

t=0:1/Fs:10;
signal=cos(2*pi*4*t);
transform=normfft(signal);

figure
plot(t,signal);

figure
stem(freqdomain(length(t),Fs),abs(normfft(signal)));

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

function y = normfft(x)
    y = fftshift(fft(x)/length(x));
end