%% ����ά�����黭����ά������ͼ��
function dimo_3Dshow(st1_sig)
  st1_sig_x = 0:1023;
  st1_sig_y = 0:512;
  [st1_sig_X,st1_sig_Y] = meshgrid(st1_sig_x,st1_sig_y);
  mesh(st1_sig_X,st1_sig_Y,abs(st1_sig));%����st1_sig�Ǹ���������� 
end