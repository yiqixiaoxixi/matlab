%% �������ĺ���
% sign:��������ź�
% sig_type���źŵ�����
% samp_num�������Ĵ���
% fs:������
function calu_result=simul_calu(sign,sig_type,samp_num,fs)
[sign_sig,st_t,st_f] = st(hilbert(sign'));%S�任
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Power Quality Disturbance Classification Based on S Transform and
% Fourier Transform:
% ����S�任�븵��Ҷ�任�ĵĵ����������Ŷ�����ʶ��;
%
% DESCRIPTION: ��ȡ����ֵ�㷨
% modification history: see git log
% --------------------
% 01a, 07/08/2015, ��� written
% 01a,05/30/2016�� ����   rewritten
% --------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ʱ����������õ� ����ʱ�䡢�轵ʱ�䡢�ж�ʱ�䡢ʱ���ֵ��ʱ���׼��
sign_real=abs(sign_sig);%�����������ת��Ϊʵ�������
sign_t=max(sign_real);%�ҳ����������������ֵ;
% ���Tup,Tdown,Tinter
Tupindex=find(sign_t>1.1);%���ҵ�ѹ�����ĵ�;ʱ���ֵ������׼ֵ10%;
if(isempty(Tupindex))%�п���Ϊ��;
    Tup=0;
else
    Tup=(Tupindex(end)-Tupindex(1))/fs;
end
Tdownindex=find((sign_t<0.9)&(sign_t>=0.1));%���ҵ�ѹ�轵�ĵ�;
if(isempty(Tdownindex))
    Tdown=0;
else
    Tdown=(Tdownindex(end)-Tdownindex(1))/fs;
end
Tinterindex=find(sign_t<0.1);%���ҵ�ѹ�жϵĵ�;
if(isempty(Tinterindex))
    Tinter=0;
else
    Tinter=(Tinterindex(end)-Tinterindex(1))/fs;
    Tdown=0;
end

% ���ֵ�ͱ�׼��;
signtmean=mean(sign_t);
signtstd=std(sign_t);
%% Ƶ�������ǰ3��г���ĺ�����Ƶ���ֵ��Ƶ���׼��
sign_f=max(abs(sign_sig),[],2);%�ҳ����������������ֵ�������[],2�ǹ̶����÷�
%���ֵ
pks=findpeaks(sign_f(10:end));% ǰ���ǻ��������Դ�10��ʼ
pks(pks<0.05)=0;% г����ֵС��0.05����Ϊ��;
if length(pks)==1 % ������ʦ�������У�г�����ֻ�漰��3�Σ���������г�����ֻ�漰��3��г���ļ��
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
% ���ֵ�ͱ�׼��;
signfmean=mean(sign_f);
signfstd=std(sign_f);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ����S�任�͵�ѹ���ݷ���ר��ϵͳ;
%���ߣ�����
%��λ���Ĵ���ѧ������ϢѧԺ
% DESCRIPTION: ��ȡ����ֵ�㷨
% modification history: see git log
% --------------------
% 01a,05/30/2016�� ����   rewritten
% --------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ���ɱ�׼�źŲ�����S�任
fs_standard=5120;%������;
f0_standard=50;%��������Ƶ��;
N_standard=10*fs_standard/f0_standard;%��������(�ܹ�10���ܲ�);
n_standard=0:N_standard-1;%ʱ������;
sig_standard=sin(2*pi*f0_standard*n_standard/fs_standard);
%�Ա�׼�ź���S�任
[sign_sig_standard,st_t_standard,st_f_standard] = st(hilbert(sig_standard'));
sign_real_standard=abs(sign_sig_standard);%�����������ת��Ϊʵ�������
%%��������

%ʵ���źŸ��еı�׼��
for col=1:size(sign_real,2)
    signstd_col(col)=std(sign_real(:,col));
end

%�ο���ѹ���еı�׼��
for col=1:size(sign_real_standard,2)
    signstd_col_standard(col)=std(sign_real_standard(:,col));
end
%�������ӣ�beta_Ampli>1�ź���͹��beta_Ampli<1�ź����ݣ�
beta_Ampli=sum(signstd_col./signstd_col_standard)/size(sign_real_standard,2);
if(abs(beta_Ampli)<0.01)%����������ӹ�С����Ĭ��Ϊû����͹�������ݣ�0.01��ֵ������Ϲ�µ�
    beta_Ampli=0;
end
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ������������źŵ�S�任����㷨��Ӧ���о�;
%���ߣ�ȫ����
%��λ�����ϴ�ѧ��������ϢѧԺ
% DESCRIPTION: ��ȡ����ֵ�㷨
% modification history: see git log
% --------------------
% 01a,05/30/2016�� ���� written
% --------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
A1_t=(sum(sign_real,2))/size(sign_real,1);%ʱ���ֵ
A2_f=(sum(sign_real))/size(sign_real,2);%Ƶ�ʾ�ֵ
A3_t=sign_real(50,:);%��Ƶʱ���ź�
%% NF ȷ���ź�����ҪƵ���źŵ���Ŀ
NF_pks=findpeaks(A2_f);
%���źŽ��й�һ��

%����ֵС��0.05����Ϊ������
NF_pks(NF_pks<0.05)=0;
NF=length(NF_pks);

%% N0 ��Ƶ���ߴ�Խ��ֵ1�Ĵ���
%����һ����Ļ�Ƶ�ź���1��ľ���ֵС��0.005����Ϊ������

N0=-1;%���ȳ�ʼ��Ϊһ�������ܵ�����
A3_t(abs(A3_t-1)<0.005)=0;
N0_pks=findpeaks(A3_t);
if length(N0_pks)==0
    N0=0;
    disp('��Ƶ�ź�û�з�ֵ');
else
    for i=1:1:length(N0_pks)%�ҳ���Ƶ�з�ֵ����1�ĸ���
        if N0_pks(i)>1
            N0=N0+1;
        end
    end
end
%% Emģ����Ƶ�ʾ�ֵ������ֵ
Em=max(NF_pks);
%% P ����������
P_pks=findpeaks(A1_t);
P=3;%Ԥ��PΪ3����һ����Ч����
%���źŽ��й�һ��

%����ֵС��0.05����Ϊ������
P_pks(P_pks<0.05)=0;
P_len=length(find(P_pks>(max(A1_t)-min(A1_t))/2));
if P_len==0
    P=0;
elseif P_len==1
    P=1;
elseif P_len>1
    P=2;
else
    disp('Pֵ����С��0����');
    P=3;
end
%% E0��Ƶ���ߵ���Сֵ
E0=min(A3_t);
%% ���ؼ���Ľ��
%��������
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




