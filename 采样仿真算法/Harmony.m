%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Power Quality Disturbance Classification Based on S Transform and
% Fourier Transform:
% 基于S变换与傅里叶变换的的电能质量多扰动分类识别;
%
% DESCRIPTION: 该算法根据唐求老师论文编写;
% modification history: see git log
% --------------------
% 01a, 07/08/2015, 吴言 written
% --------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 初始化软件运行环境;
% Initialize the software environment;
% Tips:
% clear removes all variables from the workspace.
% clear VARIABLES does the same thing.
% clear GLOBAL removes all global variables.
% clear FUNCTIONS removes all compiled MATLAB and MEX-functions.
% clear ALL removes all variables, globals, functions and MEX links.

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
%采样的样本次数(samp_num)
sig_type=7;
flag_val=10;
samp_num=3;
%采样的数据分析后的结果
simul_result=zeros(sig_type,flag_val,samp_num);
%采样的原始数据
simul_data=zeros(samp_num*sig_type,N);

%% 数据进行采样和运算
k=1;
for i=1:samp_num
    for j=1:sig_type
        sign=sign_gen(j,fs,f0);
        if addnoise
            sign=noisegen(sign,snr);
        end
        simul_data(k,:)=sign;
        k=k+1;
        calu_result=simul_calu(sign,j,i,fs);%%这里 calu_result 在运行结束以后只有末尾是有数值，其他行全部为零。这是什么原因呢？？？
        simul_result(j,:,i)=calu_result(j,:,i);
    end
end
adjust_result = adjust_position(simul_result,sig_type,samp_num,1);







