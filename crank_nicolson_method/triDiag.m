function [x,y] = triDiag(a,b,c)
  
  n = length(c);
  [d,f] = cholesky(a,b,n);
  
  % forward substitution
  y(1) = c(1)/d(1);
  for i = 2:n
    y(i) = (c(i)-f(i)*y(i-1))/d(i);
  endfor
  
  % backward substitution
  x(n) = y(n)/d(n);
  for i = 2:n
    j = n+1-i;
    x(j) = (y(j)-f(j+1)*x(j+1))/d(j);
  endfor
  
endfunction
