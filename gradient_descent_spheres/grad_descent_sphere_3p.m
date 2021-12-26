% Find the intersection of three circles by minimizing the cross product using Gradient descent

%% Parameters
% initial_s : initial s value, initial location of 1st circle
% initial_t : initial t value, initial location of 2nd circle
% initial_r : initial r value, initial location of 3rd circle
% initial_step : initial step for gradient descent
% Ho,dec,GHA : measurments for circles

function [x,y,z,s,t,r] = grad_descent_sphere_3p(initial_s,initial_t,initial_r,initial_step,Ho,dec,GHA)
  
  TOL = 10^(-12);
  STEP_REDUCER = 0.5;
  
  s = initial_s;
  t = initial_t;
  r = initial_r;
  
  sphere_params = [Ho;dec;GHA];
  cp_old = cross_product_sphere(s,t,r,sphere_params);
  cp_new = cp_old + 100;  % dummy value
  
  i = 1;
  trj_s(i) = s;
  trj_t(i) = t;
  trj_r(i) = r;
  trj_d(i) = cp_old;
  
  % loop until abs(d_new - d_old)<tol (until stabilized)
  while abs(cp_new - cp_old)>TOL
  
    % estimate the gradient (numerical gradient)
    [delta_s, delta_t, delta_r] = gradient_3p(s,t,r,2*pi,2*pi,2*pi,@cross_product_sphere,sphere_params);
    
    % normalize negative gradient (unit vector)
    size = sqrt(delta_s^2 + delta_t^2 + delta_r^2);
    if size == 0
      break;
    endif
    delta_s = -delta_s/size;
    delta_t = -delta_t/size;
    delta_r = -delta_r/size;
    
    % calculate step size
    alpha = 1.0;
    step = alpha*initial_step;
    step_s = step*delta_s;
    step_t = step*delta_t;
    step_r = step*delta_r;
    cp_old = cp_new;
    
    % loop to check step size
    while (cross_product_sphere(s+step_s,t+step_t,r+step_r,sphere_params) > cp_old)
      alpha = alpha*STEP_REDUCER;   % tune learning rate
      step = alpha*step;
      step_s = step*delta_s;
      step_t = step*delta_t;
      step_r = step*delta_r;
      cp_new = cross_product_sphere(s+step_s,t+step_t,r+step_r,sphere_params);
    endwhile
    
    % move a step
    s = s+step_s;
    t = t+step_t;
    r = r+step_r;
    cp_new = cross_product_sphere(s,t,r,sphere_params);
    
    i = i+1;
    trj_s(i) = s;
    trj_t(i) = t;
    trj_r(i) = r;
    trj_d(i) = cp_new;
    
  endwhile
  
  % calculate x,y,z
  [c1_x,c1_y,c1_z,c2_x,c2_y,c2_z,c3_x,c3_y,c3_z] = xyz_sphere_3p(s,t,r,sphere_params);
  x = (c1_x+c2_x+c3_x)/3;
  y = (c1_y+c2_y+c3_y)/3;
  z = (c1_z+c2_z+c3_z)/3;
  
  % draw trajectories
  %[c1_xs,c1_ys,c1_zs,c2_xs,c2_ys,c2_zs,c3_xs,c3_ys,c3_zs] = xyz_sphere_3p(trj_s,trj_t,trj_r,sphere_params);
  
  %figure
  %plot3(c1_xs,c1_ys,c1_zs);
  %hold on
  %plot3(c2_xs,c2_ys,c2_zs);
  %hold on
  %plot3(c3_xs,c3_ys,c3_zs);
  %hold on
  %xlabel("x");
  %ylabel("y");
  %zlabel("z");
  %hold off
  
  % draw circles
  %ss = linspace(0, 3*pi, 150)'; %x
  %ts = linspace(0, 3*pi, 150)'; %y
  %rs = linspace(0, 3*pi, 150)'; %z
  %[c1_xs,c1_ys,c1_zs,c2_xs,c2_ys,c2_zs,c3_xs,c3_ys,c3_zs] = xyz_sphere_3p(ss,ts,rs,sphere_params);
  
  %figure
  %plot3(c1_xs,c1_ys,c1_zs);
  %hold on
  %plot3(c2_xs,c2_ys,c2_zs);
  %hold on
  %plot3(c3_xs,c3_ys,c3_zs);
  %hold on
  %xlabel("x");
  %ylabel("y");
  %zlabel("z");
  %hold off
  %xlim ([-2, 2]);
  %ylim ([-2, 2]);
  %zlim ([-2, 2]);
  
  % plot heatmap
  u = linspace(0, 4*pi, 30)'; %s
  v = linspace(0, 4*pi, 30)'; %t
  w = linspace(0, 4*pi, 30)'; %r
  [uu,vv,ww] = meshgrid(u,v,w);
  zz = cross_product_sphere(uu,vv,ww,sphere_params);
  
  figure
  scatter3(uu(:),vv(:),ww(:),5,zz(:),'filled')
  xlabel("s");
  ylabel("t");
  zlabel("r");
  
  % plot trajectory
  hold on
  plot3(trj_s, trj_t, trj_r, 'r*')
  hold off
  
endfunction
