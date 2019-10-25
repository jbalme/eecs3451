function y = add_const_echo(x, fs, T, a)
    echo = [zeros(1,fs*T) a.*x];
    y = [x zeros(1,fs*T)] + echo;
end