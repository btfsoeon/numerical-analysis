function chaos(iter, initial)
  
  alpha = linspace(1.5, 4.0, 10);

  for(i = 1:10)
  
    a = alpha(i);
    r(i,1) = a;
    curr = initial;
    
    for(j = 1:iter)
      
      prev = curr;
      curr = a * prev * (1-prev);
      
      if (iter - j) < 25
        % 1000-(1000-24) -> 2
        % 1000-(1000-23) -> 3
        % 1000-(1000-22) -> 4
        % ...
        % 1000-(1000-0) -> 26
        r(i, 26-(iter-j)) = curr;
      endif
      
    endfor
    
    %{
    while(abs(p)>0.001 && j<=20)
    
      j=j+1
      r(i,j)=a*r(i,j-1)*(1-r(i,j-1))
      p=r(i,j)-r(i,j-1)
      
    endwhile
    %}
  
  endfor

  r
  plot(alpha, r(:,2))  

  %{
  X=1:size(r)(2)
  plot(X, r(1,:), "-", X, r(2,:), "-")
  %}
  
endfunction
