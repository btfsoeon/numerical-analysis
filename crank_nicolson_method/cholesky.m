function [d,f] = cholesky(a,b,n)
  
  d(1) = sqrt(a);
  f(1) = 0; % dummy value
  
  for i = 2:n
    f(i) = b/d(i-1);
    d(i) = sqrt(a-f(i)^2);
  endfor
  
endfunction
