function [x,y,s,t] = myDescent(initial_s, initial_t, initial_step)

  TOL = 10^(-20);
  s = initial_s;
  t = initial_t;
  
  d_old = d(s,t);
  d_new = d_old + 100;  % dummy value
  
  i = 1;
  trj_s(i) = s;
  trj_t(i) = t;
  trj_d(i) = d_old;
  
  % loop until abs(d_new - d_old)<tol (until stabilized)
  while abs(d_new - d_old)>TOL
  
    % calculate the gradient (theoretical gradient)
    %delta_s = -2*sin(s)*(cos(s)-cos(t)-1)+2*cos(s)*(sin(s)-sin(t));
    %delta_t = 2*sin(t)*(cos(s)-cos(t)-1)-2*cos(t)*(sin(s)-sin(t));
    % estimate the gradient (numerical gradient)
    [delta_s, delta_t] = myGradient(s,t,2*pi,2*pi);
    
    % normalize negative gradient (unit vector)
    size = sqrt(delta_s^2 + delta_t^2);
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
    d_old = d_new;
    
    % loop to check step size
    while (d(s+step_s, t+step_t) > d_old)
      alpha = alpha*0.5;   % tune learning rate
      step = alpha*step;
      step_s = step*delta_s;
      step_t = step*delta_t;
      d_new = d(s+step_s, t+step_t);
    endwhile
    
    % move s,t
    s = s+step_s;
    t = t+step_t;
    d_new = d(s,t);
    
    i = i+1;
    trj_s(i) = s;
    trj_t(i) = t;
    trj_d(i) = d_new;
    
  endwhile
  
  x = cos(s);
  y = sin(t);
  
  %plot surface
  % ' means transpose
  u = linspace(0, 2*pi, 100)'; %s
  v = linspace(0, 2*pi, 100)'; %t
  
  [uu,vv] = meshgrid(u,v);
  zz = d(uu,vv);
  mesh(uu,vv,zz);
  xlabel ("s");
  ylabel ("t");
  zlabel ("d");
  hold on
  
  %plot3(track_s, track_t, track_d, 'r*')
  plot3(trj_s, trj_t, trj_d, 'r*')
  hold off
  
endfunction
