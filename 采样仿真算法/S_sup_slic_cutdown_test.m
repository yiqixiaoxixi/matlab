%% ��ʼ��������л���;
% Initialize the software environment;
% Tips:
% clear removes all variables from the workspace.
% clear VARIABLES does the same thing.
% clear GLOBAL removes all global variables.
% clear FUNCTIONS removes all compiled MATLAB and MEX-functions.
% clear ALL removes all variables, globals, functions and MEX links.
clear all;%��������ռ�;
clc;%����������ʾ;
%% ���÷����������
fs=5120;%������;
f0=50;%��������Ƶ��;
N=10*fs/f0;%��������(�ܹ�10���ܲ�);
n=0:N-1;%ʱ������;
t=n/fs;%ʱ����;
TRUE=1;
FALSE=0;
addnoise=TRUE;%�Ӳ��Ӱ�����;
snr=30;%���������(dB);�ֱ���40,30,20��Ϊ����ȣ�dB��
%% S�任�������ֵ����
%�Ŷ��ź�����(sig_type)��ţ�
%     1-������ѹ
%     2-����
%     3-�轵
%     4-�ж�
%     5-г��
%     6-����+г��
%     7-�轵+г��
%��ȡ�������ź�(flag_val)��ţ�
%     1-����ʱ��
%     2-�轵ʱ��
%     3-�ж�ʱ��
%     4-ʱ���������ߵľ�ֵ
%     5-ʱ���������ߵı�׼��
%     6-p1
%     7-p2
%     8-p3
%     9-Ƶ���������ߵľ�ֵ
%     10-Ƶ���������ߵı�׼��
%��������������(samp_num)
sig_type=7;
flag_val=10;
samp_num=5;
%���������ݷ�����Ľ��
simul_result=zeros(sig_type,flag_val,samp_num);
%% ���ݽ��в���������

sign=sign_gen(3,N,fs,f0,n);
if addnoise
   sign=noisegen(sign,snr);
end

%����S�任
[sign_sig]=func_simplyST(sign,1/fs,1,0,0,0);
sign_real=abs(sign_sig);%�����������ת��Ϊʵ�������
sign_t=max(abs(sign_real));%�ҳ����������������ֵ;
figure(1);
subplot(131);
plot(sign_t);

%����S�任
[sign_sig_sup]=func_simplyST(sign,1/fs,2,20,0,0);
sign_real_sup=abs(sign_sig_sup);%�����������ת��Ϊʵ�������
sign_t_sup=max(abs(sign_real_sup));%�ҳ����������������ֵ;
subplot(132);
plot(sign_t_sup);
