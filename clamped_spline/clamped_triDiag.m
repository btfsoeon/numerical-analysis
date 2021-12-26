function [x,y] = clamped_triDiag(a0,a,an,b,f)

  n = length(f);
  [d,e] = m_cholesky(a0,a,an,b,n);
  
  % forward substitution
  y(1) = f(1)/d(1);
  for i = 2:n
    y(i) = (f(i)-e(i)*y(i-1))/d(i);
  endfor
  
  % backward substitution
  x(n) = y(n)/d(n);
  for i = n-1:-1:1
    x(i) = (y(i)-e(i+1)*x(i+1))/d(i);
  endfor
  
endfunction
