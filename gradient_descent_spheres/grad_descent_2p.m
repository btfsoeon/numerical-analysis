
%TODO add comments about parameters
function [s,t,trj_s,trj_t,trj_f] = grad_descent_2p(initial_s,initial_t,scale_s,scale_t,initial_step,target_f,f_params)
  
  TOL = 10^(-10);
  STEP_REDUCER = 0.5;
  
  s = initial_s;
  t = initial_t;
  
  f_old = target_f(s,t,f_params);
  f_new = f_old+100;  % dummy initial value
  
  i = 1;
  trj_s(i) = s;
  trj_t(i) = t;
  trj_f(i) = f_old;
  
  % loop until diff<tol (until stabilized)
  while abs(f_new-f_old)>TOL
    
    % estimate the gradient (numerical gradient)
    [delta_s, delta_t] = gradient_2p(s,t,scale_s,scale_t,target_f,f_params);
    
    % normalize negative gradient (unit vector)
    size = sqrt(delta_s^2+delta_t^2);
    if size == 0
      break;
    endif
    delta_s = -delta_s/size;
    delta_t = -delta_t/size;
    
    % calculate step size
    alpha = 1.0;
    step = alpha*initial_step;
    step_s = step*delta_s;
    step_t = step*delta_t;
    f_old = f_new;
    
    % loop to check step size
    while (target_f(s+step_s,t+step_t,f_params) > f_old)
      alpha = alpha*STEP_REDUCER;   % tune learning rate
      step = alpha*step;
      step_s = step*delta_s;
      step_t = step*delta_t;
      f_new = target_f(s+step_s,t+step_t,f_params);
    endwhile
    
    % move s,t by step size
    s = s+step_s;
    t = t+step_t;
    f_new = target_f(s,t,f_params);
    
    i = i+1;
    trj_s(i) = s;
    trj_t(i) = t;
    trj_f(i) = f_new;
    
  endwhile

endfunction
  