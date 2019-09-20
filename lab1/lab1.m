%% EECS 3451 Lab1
% Jonathan Baldwin 212095691
% Mark Savin 212921128
% Sarwat Shaheen 214677322

%% Problem 1

z = ((2+j*10)*(1-j*5))/((1+j*7)*(5+j*2));
r=abs(z);
theta=angle(z);
fprintf("The rectangular form is %s and the polar form is %f*exp(j*%f)\n", num2str(z), r, theta);

%% Problem 2

theta = 0:0.01:2*pi;
r=1-cos(theta);
z=r.*exp(j.*theta);
x=real(z);
y=imag(z);
plot(x,y);

%%

r=5-cos(5*theta);
z=r.*exp(j.*theta);
x=real(z);
y=imag(z);
plot(x,y);

%% Problem 3
% The real part of the function $\exp(j(t+2)3\pi)$ can be described as a cosine function with appropriate transformations.
% The period is $\frac{2\pi}{3\pi}=\frac{2}{3}$.
% Listening to the function with sound(), it is inaudible.

t=0:0.001:5;
z=exp(j.*(t+2).*3.*pi);
plot(t,real(z),t,imag(z));
legend('real part', 'imaginary part');
xlabel('t');
ylabel('z(t)');
sound(real(z));

%%
% Period of $\cos(6t\pi)$ is $\frac{2\pi}{6\pi} = \frac{1}{3}$
% Period of $10\cos(90\pi t)$ is $\frac{2\pi}{90\pi} = \frac{1}{45}$
% The ratio of the periods is rational, therefore the function is periodic.
% Listening to the function with sound(), we can hear a harsh, low-sounding tone.

t = 0:0.001:20;
z = cos(6.*t.*pi) + 10.*cos(90.*pi.*t);
plot(t, z);
xlabel('t');
ylabel('z(t)');
sound(z);

%% Problem 4
% $\cos(6\pi)\mathrm{Tri}(t-1)$ is neither even or odd.

t=-10:0.01:10;

y=cos(6*pi)*unittri(t-1);
plot(t,y);
xlabel('t');
ylabel('y(t)');

%%
% $\sin(2t\pi)\mathrm{rect}(t/5)$ is odd (it is the sin function, which is odd, truncated to the domain [-2.5,2.5]).

y=sin(2.*t.*pi).*unitrect(t/5);
plot(t,y);
xlabel('t');
ylabel('y(t)');

%%
% $(t-1)\mathrm{ramp}(t)$ is neither even or odd.

y=(t-1).*unitramp(t);
plot(t,y);
xlabel('t');
ylabel('y(t)');

%%
% $(t-1)(t+1)$ is even - it is a quadratic with y-intercept at 0.

y=(t-1).*(t+1);
plot(t,y);
xlabel('t');
ylabel('y(t)');

%% Problem 5

c1=0:0.001:0.999;
c2=exp(j.*(c1+2).*3.*pi);
A=[c1;c2]';
t=A(:,1); % Store the time column values into t
x=A(:,2); % Store the samples into x
A(1:100:end,:); % Take every hundredth sample.

%% Problem 6
% When we half() then double() vec, we are able to retrieve the original vector back through linear interpolation, which works because the vec resembles a simple linear piecewise function.
% When we double() then half() vec, we get the original vec back, because we simply throw away the extra information.


vec = [1 2 3 4 5 6 7 6 5 4 3 2 1];
double(half(vec))
half(double(vec))


%% Problem 7

t=-6:.001:6;
y=-6.*sign(t).*exp((1i.*t.*pi)-(t/6));

plot(real(y), imag(y));
title('CT Signal');
xlabel('real component of y(t)');
ylabel('imaginary component of y(t)');

%%

w=y.*unitrect(t/5);
	
plot(real(w),imag(w));
title('CT Signal Multiplied By Rectangular Pulse');
xlabel('real component of w(t)');
ylabel('imaginary component of w(t)');

%%

w=y.*unittri(5.*t-1);

plot(real(w),imag(w));
title('CT Signal Multiplied By Triangular Pulse');
xlabel('real component of w(t)');
ylabel('imaginary component of w(t)');

%%

w=y.*unitramp(2.*t);

plot(real(w),imag(w));
title('CT Signal Multiplied By Ramp');
xlabel('real component of w(t)');
ylabel('imaginary component of w(t)');

%% Function Definitions

function y = unitstep(x)
	y = (sign(x)+1)/2;
end
function y = unitramp(x)
	y = max(x,0);
end
function y = unitrect(x)
	y = unitstep(x+0.5) - unitstep(x-0.5);
end
function y = unittri(x)
	y = max(1-abs(x),0);
end

function out = half(in)
	out = in(:,1:2:end);
end

function out = double(in)
	tmp = 1:.5:length(in);
	out = (in(floor(tmp)) + in(ceil(tmp)))/2;
end

%% Conclusion
% In this lab, we learned the basics of MATLAB, how to create a report with the PUBLISH() function, and how to work with vectors, matrices, and functions in MATLAB.
