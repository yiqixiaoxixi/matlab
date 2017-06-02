% the s-tranform test script
close all;clear all;clc
%----------基本参数设定----------%
len = 1280; 
f0 = 50;
fs = 6400;    
t = (0:len-1)/fs;
%----------电压电流仿真信号----------%
[v_sig,i_sig] = sim_sig(fs,len,1);
figure,plot(t,v_sig);
xlabel('Time/s');ylabel('Amptitude/V');title('原电压波形');
figure,plot(t,i_sig);
xlabel('Time/s');ylabel('Amptitude/A');title('原电流波形');
%----------电压信号重构----------%
v_st = st(v_sig,0,fs,1/fs);
v1_st = zeros(len/2+1,len);
v1_st(50/fs*len+1,:) = v_st(50/fs*len+1,:);                                %提取基波部分
vd_st = v_st - v1_st;                                                      
v1 = ist(v1_st);                                                           %对基波部分进行S变换的逆变换
figure,plot(t,v1);
xlabel('Time/s');ylabel('Amptitude/V');title('重构基波电压波形');
vd = ist(vd_st);
figure,plot(t,vd);
xlabel('Time/s');ylabel('Amptitude/V');title('重构畸变电压波形');
%----------电流信号重构----------%
i_st = st(i_sig,0,fs,1/fs);
i1_st = zeros(len/2+1,len);
i1_st(50/fs*len+1,:) = i_st(50/fs*len+1,:);
id_st = i_st - i1_st;
i1 = ist(i1_st);
figure,plot(t,i1);
xlabel('Time/s');ylabel('Amptitude/A');title('重构基波电流波形');
id = ist(id_st);
figure,plot(t,id);
xlabel('Time/s');ylabel('Amptitude/A');title('重构畸变电流波形');
%----------各部分功率计算----------%
p1 = powercalc(v1,i1,len);
p1d = powercalc(v1,id,len);
pd1 = powercalc(vd,i1,len);
pd = powercalc(vd,id,len);

