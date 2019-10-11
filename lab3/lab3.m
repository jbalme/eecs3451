%% EECS 3451 Lab3


%% AUTHORS
% 
% * Jonathan Baldwin (212095691)
% * Mark Savin       (212921128)
% * Sarwat Shaheen   (214677322)
%

%% defs

nps   = 2;
notes   = {
    1/8, 'R';
    1/8, 'G';
    1/8, 'G';
    1/8, 'G';
    1/2, 'Eb';
    1/8, 'R';
    1/8, 'F';
    1/8, 'F';
    1/8, 'F';
    1/2, 'D'
    }';
save composition notes nps;

%% P1

disp('p1');

y = create_comp(220,8000,1);
plot(y);
playsound(y, 8000);

%% P2

disp('p2');

yhalf = half(y);
ydouble = double(y);

playsound(yhalf,8000);
playsound(ydouble,8000);

%% P3

disp('p3');

y = create_comp_exp(220,8000,1,0.05);
plot(y);

playsound(y, 8000);

%% P4

disp('p4');

ydblpitch = create_comp_exp(440,8000,1,0.1);
yhalfpitch = create_comp_exp(110,8000,1,0.1);

playsound(ydblpitch,8000);
playsound(yhalfpitch,8000);

%% P5

disp('p5');

yshiftup   = create_comp_exp(220*2^( 1/12),8000,1,0.1);
yshiftdown = create_comp_exp(220*2^(-1/12),8000,1,0.1);

playsound(yshiftup,8000);
playsound(yshiftdown,8000);

%% P6

disp('p6');

y = create_comp_overlap(220,8000,.7,0.2,0.1);
plot(y);
playsound(y,8000);

%% P7

disp('p7');
y = create_comp_harm(220,8000,.7,0.2,0.1,[2 4 6]);
plot(y);
playsound(y,8000);

%% P8

disp('p8');
y = create_comp_harm(220,8000,.7,0.2,0.1,[2 4 6]);
y_with_const_echo = add_constant_echo(y, 8000, 1, .5);
y_with_exp_echo = add_exp_echo(y, 8000, 1, .5, 2);
y_with_osc_echo = add_osc_echo(y, 8000, 1, 1, 10*pi);

playsound(y_with_osc_echo, 8000)

%% funcs

function y = create_comp(f,fs,a)
    load composition notes nps;
    
    y = [];
    for n = notes
        y = [y make_note(notefreq(f, n{2,1}), fs, nps*n{1,1},a)];
    end
end

function y = create_comp_exp(f,fs,a,tau)
    load composition notes nps;
    
    y = [];
    for n = notes
        y = [y make_note_exp(notefreq(f,n{2,1}),fs,nps*n{1,1},a,tau)];
    end
end

function y = create_comp_overlap(f,fs,a,tau,T)
    load composition notes nps;
    
    y = [];
    for n = notes
        y = vec_overlap(y, make_note_exp(notefreq(f,n{2,1}),fs,nps*n{1,1},a,tau),T*fs);
    end
end

function y = create_comp_harm(f,fs,a,tau,T,h)
    y = create_comp_overlap(f,fs,a,tau,T);
    for i = h
        y = y + create_comp_overlap(f*i,fs,a*4^(1-i),tau,T);
    end
end

function y = add_constant_echo(x, fs, T, a)
    echo = [zeros(1,fs*T) a.*x];
    y = [x zeros(1,fs*T)] + echo;
end

function y = add_exp_echo(x, fs, T, a, tau)
    t = 0:1/fs:(length(x)-1)/fs;
    echo = [zeros(1,fs*T) exp(-t/tau).*a.*x];
    y = [x zeros(1,fs*T)] + echo;
end

function y = add_osc_echo(x, fs, T, a, w)
    t = 0:1/fs:(length(x)-1)/fs;
    echo = [zeros(1,fs*T) cos(w.*t).*a.*x];
    y = [x zeros(1,fs*T)] + echo;
end

function y = make_note(f,fs,d,a)
    t = 0:1/fs:d-1/fs;
    y = [a.*sin(2*pi*f.*t) silence(fs,1/8)];
end

function y = make_note_exp(f,fs,d,a,tau)
    t = 0:1/fs:d-1/fs;
    y = [exp(-t/tau).*a.*sin(2*pi*f.*t) silence(fs,1/8)];
end

function y = silence(fs,d)
    y = zeros(1,fs*d);
end

function out = half(in)
	out = in(:,1:2:end);
end

function out = double(in)
	tmp = 1:.5:length(in);
	out = (in(floor(tmp)) + in(ceil(tmp)))/2;
end

function y = vec_overlap(v1,v2,t)
    if length(v1) < t || length(v2) < t
        y = [v1 v2];
    else
        y = [v1(1:length(v1)-t) v1(length(v1)-t+1:end)+v2(1:t) v2(t+1:end) ];
    end
end

function y = notefreq(f,n)
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
