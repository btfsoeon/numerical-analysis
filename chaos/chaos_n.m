function chaos_n(iter, initialV, numAlphas)
  
  alphas=linspace(1.0,4.0,numAlphas);
  
  for k=1:numAlphas
    
    x(1,k)=initialV;
    a=alphas(k);
    
    for i=1:iter
      
      x(i+1,k) = a * x(i,k) * (1-x(i,k));
      
    endfor
    
  endfor
  
  %plot(x(:,[2,4]),'*');
  %xlabel('iteration');
  %ylabel('value');
  %xlim([0,iter]);
  %legend('alpha=2','alpha=4');
  %hold on
  
  % plot the solution vs. alpha
  for j=1:numAlphas
    
    a=alphas(j)*ones(25);
    y=x(iter-24:iter,j);
    plot(a,y,'+');
    hold on
    
  endfor
  
  x(:,5)
  
  %size(x)
  #hold on
  #figure(2)
  #plot(x(:,2));
  
  #figure(3)
  #plot(x(:,numAlphas));

endfunction
