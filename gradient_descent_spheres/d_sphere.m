function dist = d_sphere(s,t,params)
  
  [c1_x,c1_y,c1_z,c2_x,c2_y,c2_z] = xyz_sphere(s,t,params);
  dist = (c1_x-c2_x).^2+(c1_y-c2_y).^2+(c1_z-c2_z).^2;  % do not use sqrt

endfunction
