%% EECS 3451 Lab1
% *AUTHORS*
% * Jonathan Baldwin 212095691
% * Mark Savin 212921128
% * Sarwat Shaheen 214677322

%% Problem 1
% As the frequency varies, so does the pitch proportionally. Doubling the
% frequency results in a similar sound but with a higher pitch.
% When we lower the frequency below about 70Hz, it becomes difficult to 
% hear without also increasing the amplitude. Below around 18Hz, it becomes
% inaudible even with a high amplitude. Likewise, above around 20000Hz, it 
% becomes inaudible.
%
% As the amplitude varies, the perceived loudness varies significantly. 
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
plot([1:size(y)]./Fs,y);

fprintf('Playing at input frequency (%d)\n', Fs);
playsound(y,Fs);

for Fs2=[2000,4000,6000,12000]
   y2=resample(y,Fs2,Fs);   
   fprintf('Playing resampled to %d Hz\n', Fs2);
   playsound(y2,Fs2);
end

%%-----ANSWER TO PROBLEM 2 -------
% The hihger the sampling frequency the input audio file is more clear and
% the lower the smalping frequency the more muffled the noise becomes


%% Problem 3

[y,Fs] = audioread('P_3_1.wav');
plot([1:size(y)]./Fs,y);

fprintf('Playing at input frequency (%d)\n', Fs);
playsound(y,Fs);

for Fs2=[2000,4000,6000,12000]
   y2=resample(y,Fs2,Fs);   
   fprintf('Playing resampled to %d Hz\n', Fs2);
   playsound(y2,Fs2);
end

[y,Fs] = audioread('P_3_2.wav');
plot([1:size(y)]./Fs,y);

fprintf('Playing at input frequency (%d)\n', Fs);
playsound(y,Fs);

for Fs2=[2000,4000,6000,12000]
   y2=resample(y,Fs2,Fs);   
   fprintf('Playing resampled to %d Hz\n', Fs2);
   playsound(y2,Fs2);
end

%% Problem 4



%% Function Definitions

function playsound(y, Fs)
    player = audioplayer(y,Fs);
    playblocking(player);
end

function out = double(in)
	tmp = 1:.5:length(in);
	out = (in(floor(tmp)) + in(ceil(tmp)))/2;
end
