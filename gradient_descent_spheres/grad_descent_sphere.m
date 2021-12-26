% Find the intersection of two circles by minimizing the distance using Gradient descent

%% Parameters
% initial_s : initial s value, initial location of 1st circle
% initial_t : initial t value, initial location of 2nd circle
% initial_step : initial step for gradient descent
% Ho,dec,GHA : measurments for circles

function [x,y,z,s,t] = grad_descent_sphere(initial_s,initial_t,initial_step,Ho,dec,GHA)
  
  % run gradient descent for 2 parameters
  sphere_params = [Ho;dec;GHA];
  [s,t,trj_s,trj_t,trj_f] = grad_descent_2p(initial_s,initial_t,2*pi,2*pi,initial_step,@d_sphere,sphere_params);
  
  % calculate x,y,z
  [c1_x,c1_y,c1_z,c2_x,c2_y,c2_z] = xyz_sphere(s,t,sphere_params);
  x = (c1_x+c2_x)/2;
  y = (c1_y+c2_y)/2;
  z = (c1_z+c2_z)/2;
  
  % plot surface
  u = linspace(0*pi, 2*pi, 100)'; %s
  v = linspace(0*pi, 2*pi, 100)'; %t
  
  [uu,vv] = meshgrid(u,v);
  zz = d_sphere(uu,vv,sphere_params);
  mesh(uu,vv,zz);
  xlabel ("s");
  ylabel ("t");
  
  % plot trajectory
  hold on
  plot3(trj_s, trj_t, trj_f, 'r*')
  hold off
  
endfunction
