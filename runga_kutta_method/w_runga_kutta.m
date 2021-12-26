function y_ests = w_runga_kutta(min_step,step_increment,max_step,t_final)  

  # settings
  t0 = 0;
  y0 = 1;
  
  steps = [min_step:step_increment:max_step];
  y_ests = [];
  errs = [];
  y_exact = exact_sln(y0,t_final);
  
  for j = 1:length(steps)
    h = steps(j);
    n = ceil((t_final-t0)/h);
    
    # calculate by runga_kutta 
    [t,y] = runga_kutta(t0,y0,h,n);
    
    # interpolate
    y_ests(j) = interpolate(t(n-1),t(n),y(n-1),y(n),t_final);
    
    # calculate error
    errs(j) = abs(y_exact-y_ests(j));
    
    # plot estimates
    figure(1);
    plot(t,y);
    hold on;
    plot(t_final,y_ests);
    #title('Plot of approximations');
    xlabel('t');
    ylabel('y');
    hold on;
  endfor

  log_t = log(steps);
  log_err = log(errs);
  avg_log_t = mean(log_t);
  avg_log_err = mean(log_err);
  
  convergence_rate = sum((log_t-avg_log_t).*(log_err-avg_log_err))/sum((log_t-avg_log_t).^2)
  
  figure(2);
  plot(log_t,avg_log_err+convergence_rate*(log_t-avg_log_t));
  hold on;
  plot(avg_log_t,avg_log_err,"markersize", 10);
  hold on;
  plot(log_t,log_err,'b*');
  xlabel('log(h)');
  ylabel('log(error)');
  
endfunction

function ret = interpolate(x1,x2,y1,y2,x)
  ret = (y2-y1)/(x2-x1)*(x-x1)+y1;
endfunction

function ret = exact_sln(y0,t)
  ret = y0*exp(-t);
endfunction
