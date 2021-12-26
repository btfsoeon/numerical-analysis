function [a,b,c,d] = clamped_cubic_splines(m0,mn,x0,x,y0,y)
  
  n = length(x);
  h = abs(x(2)-x(1));

  % solve a
  a = y;
  
  % solve c
  f(1) = 3/(2*h)*(m0-3*(y(1)-y0)/h+2*(y(2)-y(1))/h);
  f(n) = 3/h*(mn-(y(n)-y(n-1))/h);
  for i = 2:n-1
    f(i) = 3*(y(i-1)-2*y(i)+y(i+1))/h^2;
  endfor
  [c,_] = clamped_triDiag(3.5,4,2,1,f);
  
  % solve b
  b(n) = mn;
  for i = n-1:-1:1
    b(i) = b(i+1)-(c(i+1)+c(i))*h;
  endfor
  
  % solve d
  d(1) = (c(1)*h-b(1)+(y(1)-y0)/h)/h^2;
  for i = 2:n
    d(i) = (c(i)*h-b(i)+(y(i)-y(i-1))/h)/h^2;
  endfor
  
  % print a,b,c,d
  for i = 1:n
    printf('%7f,%7f,%7f,%7f\n',a(i),b(i),c(i),d(i))
  endfor
  
  % plot splines
  for i = 1:n
    [t,s] = generateSpline(x(i),a(i),b(i),c(i),d(i),h);
    plot(t,s);
    hold on
  endfor
  
endfunction
