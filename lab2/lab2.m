%% EECS 3451 Lab1
%  Jonathan Baldwin 212095691
%  Mark Savin 212921128
%  Sarwat Shaheen 214677322

%% Problem 1
% As the frequency varies, so does the pitch proportionally. Doubling the
% frequency results in a similar sound but with a higher pitch.
% When we lower the frequency below about 70Hz, it becomes difficult to 
% hear without also increasing the amplitude. Below around 18Hz, it becomes
% inaudible even with a high amplitude. Likewise, above around 20000Hz, it 
% becomes inaudible.
%
% As the amplitude varies, the percieved loudness varies significantly. 
% At around 8V, it becomes painful to hear, and below around 80mV it
% becomes hard to discern.
%
% Varying offset and phase does not seem to affect the sound.
%
% Changing the shape of the waveform changes the "flavour" of the sound -
% sine waves give a sharp sound, square waves a sound reminicent of 8-bit
% chiptunes, ramp sounds similar to sine.
%
%% Problem 2

[y,Fs] = audioread('P_2_1.wav');
plot(y, Fs);
fprintf('The sampling rate of the input file is %d', Fs);
y2000 = resample(y,2000,Fs);
y4000 = resample(y,4000,Fs);
y6000 = resample(y,6000,Fs);
y12000 = resample(y,12000,Fs);
sound(y,Fs);
sound(y2000,2000);
%sound(y4000,4000);
%sound(y6000,6000);
%sound(y12000,12000);