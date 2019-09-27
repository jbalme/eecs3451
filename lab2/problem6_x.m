%M file for the function x(t) as defined with the respective time ranges
% 't'
function y = problem6_x(t)
	% Calculate the functional variation for each range of time, t
	x1 = (-4*t) - 6; 
	x2 = -4 - (3*t); 
	x3 = 16 - (2*t);
	
	% Splice together the different functional variations in
	% their respective ranges of validity
	y = x1.*(-2<t & t<0) + x2.*(0<t & t<4) + x3.*(4<t & t<8);
end