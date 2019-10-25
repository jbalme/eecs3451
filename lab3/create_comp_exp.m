function y = create_comp_exp(f,fs,a,tau)
%CREATE_COMP_EXP create a composition with exponential dropoff on notes
%   f   - base frequency (frequency of the A note)
%   fs  - sample rate
%   a   - amplitude
%   tau - exponential attenuation factor
    load composition notes nps;
    
    y = [];
    for n = notes
        y = [y make_note_exp(notefreq(f,n{2,1}),fs,n{1,1}/nps,a,tau)];
    end
end