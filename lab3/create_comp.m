function y = create_comp(f,fs,a)
%CREATE_COMP create a composition
%   f   - base frequency (frequency of the A note)
%   fs  - sample rate
%   a   - amplitude
    load composition notes nps;
    
    y = [];
    for n = notes
        y = [y make_note(notefreq(f, n{2,1}), fs, n{1,1}/nps,a)];
    end
end