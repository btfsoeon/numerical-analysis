function v_errors = euler_method()
  
  bm_ratio = 0.2;
  g = 9.8;
  delta_ts = [1.0,0.5,0.25,0.125]
  t_start = 0;
  t_end = 10;
  v0 = 0;
  
  v_approxs = [];
  v_exacts = [];
  v_errors = [];
  
  for i = 1:length(delta_ts)
      
    n_pts = (t_end-t_start)/delta_ts(i);
    ts = linspace(t_start,t_end,n_pts);
    v_approxs(i,1) = v0;
    err = 0;
    
    for j = 2:length(ts)
       
       # compute approx
       v_approxs(i,j) = v_approxs(i,j-1) + delta_ts(i)*f(v_approxs(i,j-1),ts(j),bm_ratio,g);
       
       # compute exacts
       v_exacts(i,j) = F(ts(j),bm_ratio,g);
       
       # compute errors
       err = err + abs(v_approxs(i,j)-v_exacts(i,j));

    endfor
  
    v_errors(i) = err;
  
  endfor

  #plot errors
  plot(delta_ts,v_errors);

endfunction


function dv = f(v,t,bm_ratio,g)
  
  dv = -bm_ratio*v-g;
  
endfunction


function v = F(t,bm_ratio,g)
  
  v = g/bm_ratio*(exp(-bm_ratio*t)-1);
  
endfunction

