%% 将二维的数组画成三维的立体图形
function dimo_3Dshow(st1_sig)
  st1_sig_x = 0:1023;
  st1_sig_y = 0:512;
  [st1_sig_X,st1_sig_Y] = meshgrid(st1_sig_x,st1_sig_y);
  mesh(st1_sig_X,st1_sig_Y,abs(st1_sig));%这里st1_sig是复数域的数组 
end