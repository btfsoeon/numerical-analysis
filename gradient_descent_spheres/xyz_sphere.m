function [c1_x,c1_y,c1_z,c2_x,c2_y,c2_z] = xyz_sphere(s,t,params)
  
  Ho = params(1,:);
  dec = params(2,:);
  GHA = params(3,:);
  
  gamma = (90-Ho)*pi/180;
  theta = (90+dec)*pi/180;
  phi = (360-GHA)*pi/180;
  
  [c1_x, c1_y, c1_z] = to_xyz(s,gamma(1),theta(1),phi(1));
  [c2_x, c2_y, c2_z] = to_xyz(t,gamma(2),theta(2),phi(2));

endfunction
