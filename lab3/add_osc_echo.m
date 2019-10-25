function y = add_osc_echo(x, fs, T, a, w)
    t = 0:1/fs:(length(x)-1)/fs;
    echo = [zeros(1,fs*T) cos(w.*t).*a.*x];
    y = [x zeros(1,fs*T)] + echo;
end