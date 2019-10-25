function y = create_comp_harm(f,fs,a,tau,T,h)
%CREATE_COMP_HARM create a composition, with harmonics
%CREATE_COMP_EXP create a composition with exponential dropoff on notes
%   f   - base frequency (frequency of the A note)
%   fs  - sample rate
%   a   - amplitude
%   tau - exponential attenuation factor
%   T   - amount of overlap to introduce in seconds
%   h   - vector of harmonics to introduce (eg. [3 5 7])
    y = create_comp_overlap(f,fs,a,tau,T);
    for i = h
        y = y + create_comp_overlap(f*i,fs,a*4^(1-i),tau,T);
    end
end