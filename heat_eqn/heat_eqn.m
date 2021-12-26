function heat_eqn(delta_x,delta_t,step_t)

  left_x = 0;
  right_x = 1;
  alpha = delta_t/(delta_x)^2
  if alpha >= 1/2
    disp('unstable')
  endif
  
  step_x = (right_x-left_x)/delta_x;
  xs = linspace(left_x,right_x,step_x);
  
  % initial temps
  u(1,:) = initial_temps(xs);
  ts(1) = 0;
  
  for i = 2:step_t  %t
    u(i,1) = 0;
    ts(i) = ts(i-1) + delta_t;
    for j = 2:step_x-1  %x
      u(i,j) = u(i-1,j)+alpha*(u(i-1,j-1)-2*u(i-1,j)+u(i-1,j+1));
    endfor
    u(i,step_x) = 0;
  endfor

  % plot by t step
  %figure(1);
  %for i = 1:step_t
  %  plot(xs,u(i,:));
  %  hold on
  %endfor
  
  % plot surface
  figure(2);
  surf(xs,ts,u);
  xlabel('x');
  ylabel('t');
  zlabel('u');
  
endfunction

function res = initial_temps(x)
  res = x.*(1-x);
endfunction
