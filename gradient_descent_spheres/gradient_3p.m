function [grad_s,grad_t,grad_r] = gradient_3p(s,t,r,scale_s,scale_t,scale_r,target_f,f_params)
  
  TOL = 10^(-6);  % goes inaccurate as value gets small like 10^-10
  d_iscaler_s = 0.1;  % initial scaler
  d_iscaler_t = 0.1;  % initial scaler
  d_iscaler_r = 0.1;  % initial scaler
  d_reducer = 0.5;
  
  ds = d_iscaler_s*scale_s;
  dt = d_iscaler_t*scale_t;
  dr = d_iscaler_r*scale_r;
  
  diff_s = 10*TOL;   % dummy initial value
  diff_t = 10*TOL;   % dummy initial value
  diff_r = 10*TOL;   % dummy initial value
  
  % compute derivative wrt s
  grad_s = (target_f(s+ds,t,r,f_params)-target_f(s,t,r,f_params))/ds;
  while diff_s>TOL
    grad_s_old = grad_s;
    ds = d_reducer*ds;    % exponentially reduce ds
    grad_s = (target_f(s+ds,t,r,f_params)-target_f(s,t,r,f_params))/ds;
    diff_s = abs(grad_s-grad_s_old);
  endwhile
  
  % compute derivative wrt t
  grad_t = (target_f(s,t+dt,r,f_params)-target_f(s,t,r,f_params))/dt;
  while diff_t>TOL
    grad_t_old = grad_t;
    dt = d_reducer*dt;    % exponentially reduce dt
    grad_t = (target_f(s,t+dt,r,f_params)-target_f(s,t,r,f_params))/dt;
    diff_t = abs(grad_t-grad_t_old);
  endwhile
  
  % compute derivative wrt r
  grad_r = (target_f(s,t,r+dr,f_params)-target_f(s,t,r,f_params))/dr;
  while diff_r>TOL
    grad_r_old = grad_r;
    dr = d_reducer*dr;    % exponentially reduce dr
    grad_r = (target_f(s,t,r+dr,f_params)-target_f(s,t,r,f_params))/dr;
    diff_r = abs(grad_r-grad_r_old);
  endwhile

endfunction
