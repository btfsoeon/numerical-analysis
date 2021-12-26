function design_rudder()
  
  x0 = 0;
  y0 = 1.0;
  x = [2.5,5,7.5,10,12.5,15,17.5,20,22.5,25,27.5,30];
  y = [1.75,1.95,2.10,2.23,2.35,2.43,2.48,2.51,2.52,2.53,2.54,2.54];
  ref_y0 = -y0;
  ref_y = -y;
  
  m0 = sqrt((1.27)^2-(1.0)^2);
  m30 = 0;
  ref_m0 = -m0;
  ref_m30 = m30;
  
  [a,b,c,d] = clamped_cubic_splines(m0,m30,x0,x,y0,y);
  [ref_a,ref_b,ref_c,ref_d] = clamped_cubic_splines(ref_m0,ref_m30,x0,x,ref_y0,ref_y);
  
  n = length(x);
  h = abs(x(2)-x(1));
  
  % plot splines
  for i=1:n
    [t,s] = generateSpline(x(i),a(i),b(i),c(i),d(i),h);
    plot(t,s);
    hold on;
  endfor
  
  % plot splines (reflected part)
  for i=1:n
    [t,s] = generateSpline(x(i),ref_a(i),ref_b(i),ref_c(i),ref_d(i),h);
    plot(t,s);
    hold on;
  endfor
  
  x0 = 30;
  y0 = 2.54;
  x = [40,50,60,70,80,90];
  y = [2.50,2.25,2.0,1.5,1.0,0.0];
  ref_y0 = -y0;
  ref_y = -y;
  
  m30 = 0;
  m90 = -tan(5/180*pi);
  ref_m30 = m30;
  ref_m90 = -m90;
  
  [a,b,c,d] = clamped_cubic_splines(m30,m90,x0,x,y0,y);
  [ref_a,ref_b,ref_c,ref_d] = clamped_cubic_splines(ref_m30,ref_m90,x0,x,ref_y0,ref_y);
  
  n = length(x);
  h = abs(x(2)-x(1));
  
  % plot splines
  for i=1:n
    [t,s] = generateSpline(x(i),a(i),b(i),c(i),d(i),h);
    plot(t,s);
    hold on;
  endfor
  
  % plot splines (reflected part)
  for i=1:n
    [t,s] = generateSpline(x(i),ref_a(i),ref_b(i),ref_c(i),ref_d(i),h);
    plot(t,s);
    hold on;
  endfor
  
  % plot shaft
  t = linspace(0,2*pi,30);
  v = 1.27.*cos(t) + sqrt(1.27^2-1);
  w = 1.27.*sin(t);
  plot(v,w);
  
endfunction
