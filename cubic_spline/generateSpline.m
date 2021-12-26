function [x,y] = generateSpline(x_rh,a,b,c,d,h)
  
  x = [x_rh-h : h/10 : x_rh];
  y = a + b*(x-x_rh) + c*(x-x_rh).^2 + d*(x-x_rh).^3;
  
endfunction
