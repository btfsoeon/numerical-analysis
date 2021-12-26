% Bisection Method

function retval = squareRoot(num)
   
   TOLERANCE = 10^(-12);
   
   a = 0;
   b = max(1, num);
   m = (a+b)/2;
   
   % validation check
   if f3(a, num) * f3(b, num) >= 0
     
     error("unvalid endpoints")
     
   endif
   
   i = 1
   
   % actual calculation
   while abs(a-b) > TOLERANCE
     
     y = f3(m, num);
     
     if y == 0
       retval = m;
       return
       
     elseif f3(a, num) * y < 0
       a = a;
       b = m;
       m = (a+b)/2;
       retval = m;
     
     elseif f3(b, num) * y < 0
       a = m;
       b = b;
       m = (a+b)/2;
       retval = m;
     
    else
     
      "not gonna happen"
     
    endif
   
   d(i) = - log10(abs(m-sqrt(num))/sqrt(num))
   i = i+1
   
 endwhile
 
 plot(d)
 
 #plot(log(d))
 
 lnalpha = (d(40)-d(20))/(40-20)
 alpha = e^lnalpha
 
endfunction
