function y = vec_overlap(v1,v2,t)
%VEC_OVERLAP concatenate two vectors, summing an overlapping area
    if length(v1) < t || length(v2) < t
        y = [v1 v2];
    else
        y = [v1(1:length(v1)-t) v1(length(v1)-t+1:end)+v2(1:t) v2(t+1:end) ];
    end
end
