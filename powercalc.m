function p = powercalc(v,i,len)
%�����������ʼ��㺯��������%
p = 0;
for t = 1:len
    p = p+v(t)*i(t);
end
p = p/len;