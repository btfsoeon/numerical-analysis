function cubic_splines()
  
  start = 0;
  stop = 3*pi;
  n_interval = 7;
  
  [x0,y0,x,y] = generateXY(start, stop, n_interval);
  
  n = length(x);
  h = abs(x(2)-x(1));

  % solve a
  a = y;
  
  % solve c
  f(1) = 3*(y0-2*y(1)+y(2))/h^2;
  for i = 2:n-1
    f(i) = 3*(y(i-1)-2*y(i)+y(i+1))/h^2;
  endfor
  [c,_] = triDiag(4,1,f');
  c(n) = 0;
  
  % solve d
  d(1) = c(1)/(3*h);
  for i = 2:n
    d(i) = (c(i)-c(i-1))/(3*h);
  endfor
  
  % solve b
  b(1) = (y(1)-y0)/h + c(1)*h - d(1)*h^2;
  for i = 2:n
    b(i) = (y(i)-y(i-1))/h + c(i)*h - d(i)*h^2;
  endfor
  
  % print a,b,c,d
  for i = 1:n
    printf('%7f,%7f,%7f,%7f\n',a(i),b(i),c(i),d(i))
  endfor
  
  % plot splines
  for i=1:n
    [t,s] = generateSpline(x(i),a(i),b(i),c(i),d(i),h);
    plot(t,s,'*r');
    hold on;
  endfor
  
  % plot real graph
  v = linspace(start, stop, 100);
  [_,w] = generateMyLine(v);
  plot(v,w);
  
endfunction
