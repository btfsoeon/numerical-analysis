function [d,e] = m_cholesky(a1,a,an,b,n)
  
  d(1) = sqrt(a1);
  e(1) = 0; % dummy value
  
  for i = 2:n-1
    e(i) = b/d(i-1);
    d(i) = sqrt(a-e(i)^2);
  endfor
  
  e(n) = b/d(n-1);
  d(n) = sqrt(an-e(n)^2);
  
endfunction
