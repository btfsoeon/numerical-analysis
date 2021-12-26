function [grad_s, grad_t] = gradient_2p(s,t,scale_s,scale_t,f,f_params)
  
  TOL = 10^(-6);  % goes inaccurate as value gets small like 10^-10
  d_iscaler_s = 0.1;  % initial scaler
  d_iscaler_t = 0.1;  % initial scaler
  d_reducer = 0.5;
  
  ds = d_iscaler_s*scale_s;
  dt = d_iscaler_t*scale_t;
  
  diff_s = 10*TOL;   % dummy initial value
  diff_t = 10*TOL;   % dummy initial value
  
  % compute derivative wrt s
  grad_s = (f(s+ds,t,f_params)-f(s,t,f_params))/ds;
  while diff_s>TOL
    grad_s_old = grad_s;
    ds = d_reducer*ds;    % exponentially reduce ds
    grad_s = (f(s+ds,t,f_params)-f(s,t,f_params))/ds;
    diff_s = abs(grad_s-grad_s_old);
  endwhile
  
  % compute derivative wrt t
  grad_t = (f(s,t+dt,f_params)-f(s,t,f_params))/dt;
  while diff_t>TOL
    grad_t_old = grad_t;
    dt = d_reducer*dt;    % exponentially reduce dt
    grad_t = (f(s,t+dt,f_params)-f(s,t,f_params))/dt;
    diff_t = abs(grad_t-grad_t_old);
  endwhile

endfunction
