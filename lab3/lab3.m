%% EECS 3451 Lab3


%% AUTHORS
% 
% * Jonathan Baldwin (212095691)
% * Mark Savin       (212921128)
% * Sarwat Shaheen   (214677322)
%

%% Some utility variables and functions
%
% <include>notefreq.m</include>
%
% We store the notes and tempo in a .mat file instead of repeating them in
% every function.
nps   = .5;
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
%
% <include>make_note.m</include>
%
% <include>create_comp.m</include>

y = create_comp(220,8000,1);
plot(y);
playsound(y, 8000);
audiowrite('composition.wav',y,8000);

%% P2
%
% Running the composition through half doubles the pitch but also doubles
% the tempo.
%
% Running the composition through dbl halves the pitch, but also halves the
% tempo.
%
% <include>half.m</include>
%
% <include>dbl.m</include>

yhalf = half(y);
ydouble = dbl(y);

playsound(yhalf,8000);
playsound(ydouble,8000);

%% P3
% Doubling the amplitude appears to quadruple the volume.
% The exponential dropoff effect is more noticeable on longer notes.
% The exponential dropoff effect seems to be more noticeable with a smaller
% tau/attenuation factor.
%
% <include>make_note_exp.m</include>
%
% <include>create_comp_exp.m</include>

y = create_comp_exp(220,8000,1,0.05);
plot(y);

playsound(y, 8000);

%% P4
%
% We double and half the pitch by doubling and halving the f value passed
% to create_comp_exp, respectively.

ydblpitch = create_comp_exp(440,8000,1,0.1);
yhalfpitch = create_comp_exp(110,8000,1,0.1);

playsound(ydblpitch,8000);
playsound(yhalfpitch,8000);

%% P5
%
% We can shift the pitch up or down a half step by multiplying or dividing
% f by a factor of $2^{1/12}$, respectively.

yshiftup   = create_comp_exp(220*2^( 1/12),8000,1,0.1);
yshiftdown = create_comp_exp(220*2^(-1/12),8000,1,0.1);

playsound(yshiftup,8000);
playsound(yshiftdown,8000);

%% P6
% Introducing overlap causes the composition to play smoother and faster,
% but too much overlap causes notes to bleed together.
%
% <include>vec_overlap.m</include>
%
% <include>create_comp_overlap.m</include>

y = create_comp_overlap(220,8000,.7,0.2,0.1);
plot(y);
playsound(y,8000);

%% P7
% Introducing harmonics causes the composition to have a richer sound, with
% different harmonics adding different character to the sound.
%
% <include>create_comp_harm.m</include>

y = create_comp_harm(220,8000,.7,0.2,0.1,[2 4 6]);
plot(y);
playsound(y,8000);

%% P8
% The delay $T$ controls the delay of the echo.
% The attenuation factor $a$ controls the volume of the echo added.
% $mu$ controls how fast the exponentially decaying echo decays; small
% positive values yield faster decays. $w$ controls the rate at which
% oscillating echo oscillates, higher values oscillate faster.
%
% <include>add_const_echo.m</include>
%
% <include>add_exp_echo.m</include>
%
% <include>add_osc_echo.m</include>

y = create_comp_harm(220,8000,1,0.2,0.1,[2 4 6]);

playsound(y,8000); 

playsound(add_const_echo(y, 8000, 0.5, 0.35),8000); 
playsound(add_exp_echo(y, 8000, 0.5, 0.35, 1),8000); 
playsound(add_osc_echo(y, 8000, 0.1, 1, 5),8000); 

%% What we learned
%
% In this lab, we learned how to transform a harsh sinusoidal tone into
% pleasant sounding notes and compositions through the use of exponential
% decay and the introduction of harmonics.
%
% We also learned how to apply the DRY (don't repeat yourself) principle to
% MATLAB code, how MATLAB's save and load functions work, and how to use
% cell arrays and loops effectively.

