function cross_product = cross_product_sphere(s,t,r,params)
  
  [c1_x,c1_y,c1_z,c2_x,c2_y,c2_z,c3_x,c3_y,c3_z] = xyz_sphere_3p(s,t,r,params);
  
  u_x = c2_x-c1_x;
  u_y = c2_y-c1_y;
  u_z = c2_z-c1_z;
  v_x = c3_x-c1_x;
  v_y = c3_y-c1_y;
  v_z = c3_z-c1_z;
  
  cp_x = u_y.*v_z-u_z.*v_y;
  cp_y = u_z.*v_x-u_x.*v_z;
  cp_z = u_x.*v_y-u_y.*v_x;
  
  cross_product = cp_x.^2 + cp_y.^2 + cp_z.^2;
  
endfunction
