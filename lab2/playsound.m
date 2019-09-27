function playsound(y, Fs)
    % On Linux, refuses to play at anything other than 44100 Hz
    if isunix()
        y = resample(y,44100,Fs);
        Fs = 44100;
    end
    player = audioplayer(y,Fs);
    playblocking(player);
end