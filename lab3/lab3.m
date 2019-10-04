%% EECS 3451 Lab3


%% AUTHORS
% 
% * Jonathan Baldwin (212095691)
% * Mark Savin       (212921128)
% * Sarwat Shaheen   (214677322)
%

%% Problem 1


nps = 2;
nf = containers.Map();
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
 
y = create_comp(220,8000,1);
playsound(y, 8000);

y = create_comp_exp(220,8000,1,0.1);
playsound(y, 8000);

function y = create_comp(f,fs,a)
    global nps
    global nf
    y = [   
        rest(fs,nps*1/4) ...
        make_note(f*nf('G'), fs,nps*1/8,a) ...
        make_note(f*nf('G'), fs,nps*1/8,a) ...
        make_note(f*nf('G'), fs,nps*1/8,a) ...
        make_note(f*nf('Eb'),fs,nps*1/2,a) ...
        rest(fs,nps*1/4) ...
        make_note(f*nf('F'), fs,nps*1/8,a) ...
        make_note(f*nf('F'), fs,nps*1/8,a) ...
        make_note(f*nf('F'), fs,nps*1/8,a) ...
        make_note(f*nf('D'), fs,nps*1/2,a) ...
    ];
end

function y = create_comp_exp(f,fs,a,tau)
    global nps
    global nf
    y = [   
        rest(fs,nps*1/4) ...
        make_note_exp(f*nf('G'), fs,nps*1/8,a,tau) ...
        make_note_exp(f*nf('G'), fs,nps*1/8,a,tau) ...
        make_note_exp(f*nf('G'), fs,nps*1/8,a,tau) ...
        make_note_exp(f*nf('Eb'),fs,nps*1/2,a,tau) ...
        rest(fs,nps*1/4) ...
        make_note_exp(f*nf('F'), fs,nps*1/8,a,tau) ...
        make_note_exp(f*nf('F'), fs,nps*1/8,a,tau) ...
        make_note_exp(f*nf('F'), fs,nps*1/8,a,tau) ...
        make_note_exp(f*nf('D'), fs,nps*1/2,a,tau) ...
    ];
end

function y = make_note(f,fs,d,a)
    t = 0:1/fs:d-1/fs;
    y = [a.*sin(2*pi*f.*t) silence(fs,1/8)];
end

function y = make_note_exp(f,fs,d,a,tau)
    t = 0:1/fs:d-1/fs;
    y = [a.*sin(2*pi*f.*t).*exp(-t/tau) silence(fs,1/8)];
end

function y = rest(fs,d)
    y = [silence(fs,d) silence(fs,1/8)];
end

function y = silence(fs,d)
    t = 0:1/fs:d-1/fs;
    y = t-t;
end


