function [t,y] = runga_kutta(t0,y0,h,n)  
  
    k1 = f(t0,y0);
    k2 = f(t0+h/2,y0+k1*h/2);
    k3 = f(t0+h/2,y0+k2*h/2);
    k4 = f(t0+h,y0+k3*h);     
    k = (k1+2*k2+2*k3+k4)/6;
    
    t(1) = t0+h;
    y(1) = y0+k*h;
    
    for i = 2:n
      
      k1 = f(t(i-1),y(i-1));
      k2 = f(t(i-1)+h/2,y(i-1)+k1*h/2);
      k3 = f(t(i-1)+h/2,y(i-1)+k2*h/2);
      k4 = f(t(i-1)+h,y(i-1)+k3*h);
      k = (k1+2*k2+2*k3+k4)/6;
      
      t(i) = t(i-1)+h;
      y(i) = y(i-1)+k*h;
      
    endfor

endfunction

function ret = f(t,y)
  ret = -y;
endfunction

