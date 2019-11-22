%%  Question -4

%%  Specifying time interval
t = 0:1:100;

%%  Reading the input audio file provided in Moodle
[x, Fs] = audioread("P_12_2.WAV");

%%  Input audio file demodulated

%%  We decided that a Carrier Frequency of 10 
%%  is suitable for the demodulation technique used
xd = x * cos(2*pi*10*t);

%% Demodulated signal is now passed through a low-pass-filter
%% to only allow for singled-out frequencies
xd = lowpass(xd, 1, Fs);

%% We then take an inverse fourier transform of the demodulated signal
xf = real(ifft(xd));

%% We then play the demodulated signal back 
sound(xf, Fs);
