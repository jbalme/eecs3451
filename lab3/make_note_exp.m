function y = make_note_exp(f,fs,d,a,tau)
%MAKE_NOTE_EXP make a note with exponential dropoff
%   f   - frequency of the note
%   fs  - sample rate
%   d   - length of the note, in seconds
%   a   - amplitude
%   tau - exponential attenuation factor
    t = 0:1/fs:d-1/fs;
    y = [exp(-t/tau).*a.*sin(2*pi*f.*t) zeros(1,fs/8)];
end