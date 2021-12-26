function [x,y,z] = to_xyz(t,gamma,theta,phi)
  
  x = cos(gamma)*sin(theta)*cos(phi)+sin(gamma)*(cos(t)*cos(theta)*cos(phi)-sin(t)*sin(phi));
  y = cos(gamma)*sin(theta)*sin(phi)+sin(gamma)*(cos(t)*cos(theta)*sin(phi)+sin(t)*cos(phi));
  z = cos(gamma)*cos(theta)-sin(gamma)*cos(t)*sin(theta);
  
endfunction
