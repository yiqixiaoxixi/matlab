function [v,i] = sim_sig(fs,len,type)
%……………………仿真信号产生函数……………………%
%…………………………输入参数…………………………%
%fs为采样频率  len为信号点数  type为信号模型选择%
%  1 方波信号（谐波合成信号）   2 非线性信号    %
v = zeros(1,len);
i = zeros(1,len);
switch type
    case 1
        for k = 1:len
            t = (k-1)/fs; 
            v(k) = 100*sin(2*pi*50*t)+3.8*sin(2*pi*3*50*t-pi)+2.4*sin(2*pi*5*50*t-pi)+1.7*sin(2*pi*7*50*t-pi)+1.1*sin(2*pi*22*50*t-pi)+0.8*sin(2*pi*13*50*t-pi);
            i(k) = 1.5*sin(2*pi*50*t)+0.45*sin(2*pi*3*50*t)+0.27*sin(2*pi*5*50*t)+0.21*sin(2*pi*7*50*t)+0.135*sin(2*pi*22*50*t)+0.075*sin(2*pi*13*50*t); 
        end
    case 2
         for k = 1:len
             t = (k-1)/fs;
             v(k) = 100*sqrt(2)*(1+0.19*sin(2*pi*5*t))*sin(2*pi*50*t);
             i(k) = 100*sqrt(2)*(0.5+sin(2*pi*5*t))*sin(2*pi*50*t-pi/3); 
         end
end


                   