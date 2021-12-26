function crank_nicolson_method(delta_x,delta_t,step_t)
  
  left_x = 0;
  right_x = 1;
  alpha = delta_t/(delta_x)^2
  r = 2*(delta_x)^2/delta_t
  step_x = (right_x-left_x)/delta_x;
  xs = linspace(left_x,right_x,step_x);
  
  % initial temps
  u(1,:) = initial_temps(xs);
  u_x_initial = 0;
  u_x_final = 0;
  ts(1) = 0;
  
  for i = 2:step_t  %t
    
    ts(i) = ts(i-1) + delta_t;
    for j = 2:step_x-1  %x
      k = j-1;
      c(k) = u(i-1,j-1) + (r-2)*u(i-1,j) + u(i-1,j+1);
    endfor
    [v,_] = triDiag(2+r,-1,c);
    u(i,:) = [[u_x_initial],v,[u_x_final]];
    
  endfor

  % plot by t step
  figure(1);
  for i = 1:step_t
    plot(xs,u(i,:));
    hold on
  endfor
  xlabel('x');
  ylabel('u');
  
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
