function retval = findRoot()
  
  TOL = 0.0001;
  a = 1;
  b = 2;
  m = (a+b)/2;
  
  while abs(a-b)>TOL
    
    y = f1(m);
    
    if y == 0
      retval = m
      
    elseif f1(a) * y < 0
      a = a;
      b = m;
      m = (a+b)/2;
      retval = m
      
    elseif f1(b) * y < 0
      a = m;
      b = b;
      m = (a+b)/2;
      retval = m
      
    endif
    
  endwhile
  
endfunction
