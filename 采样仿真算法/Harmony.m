%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Power Quality Disturbance Classification Based on S Transform and
% Fourier Transform:
% ����S�任�븵��Ҷ�任�ĵĵ����������Ŷ�����ʶ��;
%
% DESCRIPTION: ���㷨����������ʦ���ı�д;
% modification history: see git log
% --------------------
% 01a, 07/08/2015, ���� written
% --------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ��ʼ��������л���;
% Initialize the software environment;
% Tips:
% clear removes all variables from the workspace.
% clear VARIABLES does the same thing.
% clear GLOBAL removes all global variables.
% clear FUNCTIONS removes all compiled MATLAB and MEX-functions.
% clear ALL removes all variables, globals, functions and MEX links.

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
%��������������(samp_num)
sig_type=7;
flag_val=10;
samp_num=3;
%���������ݷ�����Ľ��
simul_result=zeros(sig_type,flag_val,samp_num);
%������ԭʼ����
simul_data=zeros(samp_num*sig_type,N);

%% ���ݽ��в���������
k=1;
for i=1:samp_num
    for j=1:sig_type
        sign=sign_gen(j,fs,f0);
        if addnoise
            sign=noisegen(sign,snr);
        end
        simul_data(k,:)=sign;
        k=k+1;
        calu_result=simul_calu(sign,j,i,fs);%%���� calu_result �����н����Ժ�ֻ��ĩβ������ֵ��������ȫ��Ϊ�㡣����ʲôԭ���أ�����
        simul_result(j,:,i)=calu_result(j,:,i);
    end
end
adjust_result = adjust_position(simul_result,sig_type,samp_num,1);







