function y = create_comp_overlap(f,fs,a,tau,T)
%CREATE_COMP_OVERLAP create a composition, with overlap
%   f   - base frequency (frequency of the A note)
%   fs  - sample rate
%   a   - amplitude
%   tau - exponential attenuation factor
%   T   - amount of overlap to introduce in seconds
    load composition notes nps;
    
    y = [];
    for n = notes
        y = vec_overlap(y, make_note_exp(notefreq(f,n{2,1}),fs,n{1,1}/nps,a,tau),T*fs);
    end
end
