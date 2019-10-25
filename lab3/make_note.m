function y = make_note(f,fs,d,a)
%MAKE_NOTE make a note
%   f - frequency of the note
%   fs - sample rate
%   d  - length of the note, in seconds
%   a  - amplitude
    t = 0:1/fs:d-1/fs;
    y = [a.*sin(2*pi*f.*t) zeros(1,fs/8)];
end