function [x0,y0,x,y] = generateXY(start,stop,n)
  
  x = linspace(start, stop, n);
  [_,y] = generateMyLine(x);
  
  x0 = x(1);
  y0 = y(1);
  
  x = x(2:n);
  y = y(2:n);
  
endfunction
