%% 定义计算的函数
% sign:待输入的信号
% sig_type：信号的类型
% samp_num：样本的次序
% fs:采样率
function calu_result=simul_calu(sign,sig_type,samp_num,fs)
[sign_sig,st_t,st_f] = st(hilbert(sign'));%S变换
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Power Quality Disturbance Classification Based on S Transform and
% Fourier Transform:
% 基于S变换与傅里叶变换的的电能质量多扰动分类识别;
%
% DESCRIPTION: 提取特征值算法
% modification history: see git log
% --------------------
% 01a, 07/08/2015, 李建闽 written
% 01a,05/30/2016， 吴言   rewritten
% --------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 时域分析，共得到 骤升时间、骤降时间、中断时间、时域均值、时域标准差
sign_real=abs(sign_sig);%将复数域矩阵转化为实数域矩阵
sign_t=max(sign_real);%找出各个列向量的最大值;
% 求得Tup,Tdown,Tinter
Tupindex=find(sign_t>1.1);%查找电压骤升的点;时域幅值超过标准值10%;
if(isempty(Tupindex))%有可能为空;
    Tup=0;
else
    Tup=(Tupindex(end)-Tupindex(1))/fs;
end
Tdownindex=find((sign_t<0.9)&(sign_t>=0.1));%查找电压骤降的点;
if(isempty(Tdownindex))
    Tdown=0;
else
    Tdown=(Tdownindex(end)-Tdownindex(1))/fs;
end
Tinterindex=find(sign_t<0.1);%查找电压中断的点;
if(isempty(Tinterindex))
    Tinter=0;
else
    Tinter=(Tinterindex(end)-Tinterindex(1))/fs;
    Tdown=0;
end

% 求均值和标准差;
signtmean=mean(sign_t);
signtstd=std(sign_t);
%% 频域分析，前3次谐波的含量、频域均值、频域标准差
sign_f=max(abs(sign_sig),[],2);%找出各个行向量的最大值，后面的[],2是固定的用法
%求峰值
pks=findpeaks(sign_f(10:end));% 前面是基波，所以从10开始
pks(pks<0.05)=0;% 谐波幅值小于0.05均置为零;
if length(pks)==1 % 在唐老师的论文中，谐波最多只涉及到3次，所以这里谐波检测只涉及到3次谐波的检测
    p1=pks(1);
    p2=0;
    p3=0;
elseif length(pks)==2
    p1=pks(1);
    p2=pks(2);
    p3=0;
else
    p1=pks(1);
    p2=pks(2);
    p3=pks(3);
end
% 求均值和标准差;
signfmean=mean(sign_f);
signfstd=std(sign_f);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 基于S变换和电压凹陷分类专家系统;
%作者：杨洪耕
%单位：四川大学电气信息学院
% DESCRIPTION: 提取特征值算法
% modification history: see git log
% --------------------
% 01a,05/30/2016， 吴言   rewritten
% --------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 生成标准信号并进行S变换
fs_standard=5120;%采样率;
f0_standard=50;%电网基波频率;
N_standard=10*fs_standard/f0_standard;%采样点数(总共10个周波);
n_standard=0:N_standard-1;%时间序列;
sig_standard=sin(2*pi*f0_standard*n_standard/fs_standard);
%对标准信号求S变换
[sign_sig_standard,st_t_standard,st_f_standard] = st(hilbert(sig_standard'));
sign_real_standard=abs(sign_sig_standard);%将复数域矩阵转化为实数域矩阵
%%幅度因子

%实际信号各列的标准差
for col=1:size(sign_real,2)
    signstd_col(col)=std(sign_real(:,col));
end

%参考电压各列的标准差
for col=1:size(sign_real_standard,2)
    signstd_col_standard(col)=std(sign_real_standard(:,col));
end
%幅度因子，beta_Ampli>1信号上凸；beta_Ampli<1信号下陷；
beta_Ampli=sum(signstd_col./signstd_col_standard)/size(sign_real_standard,2);
if(abs(beta_Ampli)<0.01)%如果幅度因子过小，就默认为没有上凸或者下陷；0.01阈值这里是瞎猜的
    beta_Ampli=0;
end
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 电能质量相关信号的S变换检测算法及应用研究;
%作者：全惠敏
%单位：湖南大学电气与信息学院
% DESCRIPTION: 提取特征值算法
% modification history: see git log
% --------------------
% 01a,05/30/2016， 吴言 written
% --------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
A1_t=(sum(sign_real,2))/size(sign_real,1);%时间均值
A2_f=(sum(sign_real))/size(sign_real,2);%频率均值
A3_t=sign_real(50,:);%基频时间信号
%% NF 确定信号中主要频率信号的数目
NF_pks=findpeaks(A2_f);
%对信号进行归一化

%将赋值小于0.05，认为是噪声
NF_pks(NF_pks<0.05)=0;
NF=length(NF_pks);

%% N0 基频曲线穿越幅值1的次数
%将归一化后的基频信号与1差的绝对值小于0.005，认为是噪声

N0=-1;%首先初始化为一个不可能的数据
A3_t(abs(A3_t-1)<0.005)=0;
N0_pks=findpeaks(A3_t);
if length(N0_pks)==0
    N0=0;
    disp('基频信号没有峰值');
else
    for i=1:1:length(N0_pks)%找出基频中幅值大于1的个数
        if N0_pks(i)>1
            N0=N0+1;
        end
    end
end
%% Em模矩阵频率均值的最大峰值
Em=max(NF_pks);
%% P 脉冲特征量
P_pks=findpeaks(A1_t);
P=3;%预设P为3，是一个无效的数
%对信号进行归一化

%将赋值小于0.05，认为是噪声
P_pks(P_pks<0.05)=0;
P_len=length(find(P_pks>(max(A1_t)-min(A1_t))/2));
if P_len==0
    P=0;
elseif P_len==1
    P=1;
elseif P_len>1
    P=2;
else
    disp('P值长度小于0出错');
    P=3;
end
%% E0基频曲线的最小值
E0=min(A3_t);
%% 返回计算的结果
%返回数组
calu_result(sig_type,1,samp_num)=Tup;
calu_result(sig_type,2,samp_num)=Tdown;
calu_result(sig_type,3,samp_num)=Tinter;
calu_result(sig_type,4,samp_num)=signtmean;
calu_result(sig_type,5,samp_num)=signtstd;
calu_result(sig_type,6,samp_num)=p1;
calu_result(sig_type,7,samp_num)=p2;
calu_result(sig_type,8,samp_num)=p3;
calu_result(sig_type,9,samp_num)=signfmean;
calu_result(sig_type,10,samp_num)=signfstd;
end




