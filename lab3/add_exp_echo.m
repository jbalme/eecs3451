function y = add_exp_echo(x, fs, T, a, mu)
    t = 0:1/fs:(length(x)-1)/fs;
    echo = [zeros(1,fs*T) exp(-t/mu).*a.*x];
    y = [x zeros(1,fs*T)] + echo;
end