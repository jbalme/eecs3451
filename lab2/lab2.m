%% EECS 3451 Lab1
% *AUTHORS*
% 
% 
% * Jonathan Baldwin
% * Mark Savin
% * Sarwat Shaheen

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
%
% * The lower the sampling frequency of the signal, the more muffled it
% sounds.
% * The higher the sampling frequency of the signal, the more clear it
% sounds. Oversampling beyond that of the input signal has no effect,
% however.

[y,Fs] = audioread('P_2_1.wav');
plot([1:size(y)]./Fs,y);

fprintf('Playing at input frequency (%d)\n', Fs);
playsound(y,Fs);

for Fs2=[2000,4000,6000,12000]
   y2=resample(y,Fs2,Fs);   
   fprintf('Playing resampled to %d Hz\n', Fs2);
   playsound(y2,Fs2);
end



%% Problem 3a - 100 Hz triangle wave
% Unlike in Problem 2, changing the sampling rate doesn't seem to affect
% the quality of the sound.


[y,Fs] = audioread('P_3_1.wav');
plot([1:size(y)]./Fs,y);

fprintf('Playing at input frequency (%d)\n', Fs);
playsound(y,Fs);

for Fs2=[2000,4000,6000,12000]
   y2=resample(y,Fs2,Fs);   
   fprintf('Playing resampled to %d Hz\n', Fs2);
   playsound(y2,Fs2);
end

%% Problem 3b - voice sample
% This time, much like in Problem 2, the sampling rate affects the quality
% of the sound greatly.

[y,Fs] = audioread('P_3_2.wav');
plot([1:size(y)]./Fs,y);

fprintf('Playing at input frequency (%d)\n', Fs);
playsound(y,Fs);

for Fs2=[2000,4000,6000,12000]
   y2=resample(y,Fs2,Fs);   
   fprintf('Playing resampled to %d Hz\n', Fs2);
   playsound(y2,Fs2);
end

%% Problem 4a - double
% Running the signal through double doesn't seem to affect the sound at
% all.

[y,Fs] = audioread('P_3_2.wav');
plot([1:size(y)]./Fs,y);

y2=double(y);
fprintf('Playing at input frequency %d Hz, doubled to %d\n', Fs, Fs*2);
playsound(y2,Fs*2);

for Fs2=[2000,4000,6000,12000]
   y2=resample(y,Fs2,Fs);
   y3=double(y2);
   fprintf('Playing resampled to %d Hz, then doubled to %d\n', Fs2, Fs2*2);
   playsound(y3,Fs2*2);
end

%% Problem 4b - fliplr
% Running the signal through fliplr flips the left and right channels. As
% our voice sample is centered, the sound output doesn't perceptibly
% change.

[y,Fs] = audioread('P_3_2.wav');
plot([1:size(y)]./Fs,y);

y2=fliplr(y);
fprintf('Playing at input frequency %d Hz\n', Fs);
playsound(y2,Fs);

%% Problem 4b - flipud
% Running the signal through flipud reverses the sound. It sounds like
% something out of the Exorcist.

[y,Fs] = audioread('P_3_2.wav');
plot([1:size(y)]./Fs,y);

y2=flipud(y);
fprintf('Playing at input frequency %d Hz\n', Fs);
playsound(y2,Fs);

%% Function Definitions

function playsound(y, Fs)
    % On Linux, refuses to play at anything other than 44100 Hz
    if isunix()
        y = resample(y,44100,Fs);
        Fs = 44100;
    end
    player = audioplayer(y,Fs);
    playblocking(player);
end

function out = double(in)
	tmp = 1:.5:length(in);
	out = (in(floor(tmp)) + in(ceil(tmp)))/2;
end
