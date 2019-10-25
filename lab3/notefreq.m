function y = notefreq(f,n)
%NOTEFREQ get the frequency of a note from it's musical notation
%   f   - base frequency
%   n   - note in musical notation (eg, 'A#')
    nf = containers.Map();
    nf('R')      = 0;
    nf('A')      = 2^(0/12);
    nf('A#')     = 2^(1/12);
    nf('Bb')     = 2^(1/12);
    nf('B')      = 2^(2/12);
    nf('C')      = 2^(3/12);
    nf('C#')     = 2^(4/12);
    nf('Db')     = 2^(4/12);
    nf('D')      = 2^(5/12);
    nf('D#')     = 2^(6/12);
    nf('Eb')     = 2^(6/12);
    nf('E')      = 2^(7/12);
    nf('F')      = 2^(8/12);
    nf('F#')     = 2^(9/12);
    nf('Gb')     = 2^(9/12);
    nf('G')      = 2^(10/12);
    nf('G#')     = 2^(11/12);
    nf('Ab')     = 2^(11/12);
    y = f*nf(n);
end

