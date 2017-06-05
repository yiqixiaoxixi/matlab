%% 初始化软件运行环境;
% Initialize the software environment;
% Tips:
% clear removes all variables from the workspace.
% clear VARIABLES does the same thing.
% clear GLOBAL removes all global variables.
% clear FUNCTIONS removes all compiled MATLAB and MEX-functions.
% clear ALL removes all variables, globals, functions and MEX links.
clear all;%清除工作空间;
clc;%清除命令窗口显示;
%% 设置仿真基本参数
fs=5120;%采样率;
f0=50;%电网基波频率;
N=10*fs/f0;%采样点数(总共10个周波);
n=0:N-1;%时间序列;
t=n/fs;%时间间隔;
TRUE=1;
FALSE=0;
addnoise=TRUE;%加不加白噪声;
snr=30;%设置信噪比(dB);分别用40,30,20作为信噪比（dB）
%% S变换后的特征值矩阵
%扰动信号类型(sig_type)编号：
%     1-正常电压
%     2-骤升
%     3-骤降
%     4-中断
%     5-谐波
%     6-骤升+谐波
%     7-骤降+谐波
%提取的特征信号(flag_val)编号：
%     1-骤升时间
%     2-骤降时间
%     3-中断时间
%     4-时域特征曲线的均值
%     5-时域特征曲线的标准差
%     6-p1
%     7-p2
%     8-p3
%     9-频域特征曲线的均值
%     10-频域特征曲线的标准差
%采样的样本次数(samp_num)
sig_type=7;
flag_val=10;
samp_num=5;
%采样的数据分析后的结果
simul_result=zeros(sig_type,flag_val,samp_num);
%% 数据进行采样和运算

sign=sign_gen(3,N,fs,f0,n);
if addnoise
   sign=noisegen(sign,snr);
end

%基本S变换
[sign_sig]=func_simplyST(sign,1/fs,1,0,0,0);
sign_real=abs(sign_sig);%将复数域矩阵转化为实数域矩阵
sign_t=max(abs(sign_real));%找出各个行向量的最大值;
figure(1);
subplot(131);
plot(sign_t);

%广义S变换
[sign_sig_sup]=func_simplyST(sign,1/fs,2,20,0,0);
sign_real_sup=abs(sign_sig_sup);%将复数域矩阵转化为实数域矩阵
sign_t_sup=max(abs(sign_real_sup));%找出各个列向量的最大值;
subplot(132);
plot(sign_t_sup);
