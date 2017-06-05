%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 调节因子a与两项参数之间的关系
% --------------------
% V1.0, 04/27/2017, 吴言 written
% --------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 初始化环境及变量
clc;
clear;
close all;
%设定的谐波幅值
p3=0.2;p5=0.1;p7=0.3;
signal1=sign_gen(5,5120,50);
[signal,~]=noisegen(signal1,30);
M=length(signal);
N=M;
count=1;
%% MST
for factor1=0.05:0.1:1
ST=st_gaijin(signal,factor1);
sign_f=max(abs(ST),[],2);
%谐波幅值
p0_ce=sign_f(11,1);
p3_ce=sign_f(31,1);
p5_ce=sign_f(51,1);
p7_ce=sign_f(71,1);
%整理
result(count,1)=factor1;
result(count,2)=p0_ce;
result(count,3)=p3_ce;
result(count,4)=p5_ce;
result(count,5)=p7_ce;
p0_ce=0;p3_ce=0;p5_ce=0;p7_ce=0;
count=count+1;
end
%% 分析
for i=1:1:size(result,1)
    wucha_3(1,i)=abs(result(i,3)-p3);
    wucha_5(1,i)=abs(result(i,4)-p5);
    wucha_7(1,i)=abs(result(i,5)-p7);
    wucha_zong(1,i)=wucha_3(1,i)+wucha_5(1,i)+wucha_7(1,i);
end
figure(1);
plot(result(:,1),wucha_3,'o-b',result(:,1),wucha_5,'x-g',result(:,1),wucha_7,'*-y',result(:,1),wucha_zong,'d-r');