function dist = d(s,t)
  dist = sqrt((cos(s)-cos(t)-1).^2+(sin(s)-sin(t)).^2);
endfunction
