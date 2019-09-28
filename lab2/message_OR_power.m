function answer = message_OR_power(t)
  N = length(t);
  time_avg = sum(t) / N;
  squared_avg = sum(t.^2) / N;

  if (squared_avg ~= 0 && abs(time_avg) < 0.01)
      answer = 0; %power
  else
      answer = 1;  %message
  end
end