%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%这段程序进行S变换
%输入信号，得到一个复数二维矩阵
% 根据需要可以画出图形
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 参数说明
% timeseries 待进行S变换的信号行向量
% fs 采样频率
% S_kind S变换的类型
    % 1 基本的S变换
    % 2 不完全S变换
    % 3 改进S变换
% paint 是否要画图
% k 广义S变换的转化因子
% p q 改进S变换的转化因子
function [ST]=func_simplyST(timeseries,fs,S_kind,paint,k,p,q)
disp('_______________  START:func_simplyST  ________________');  
M=length(timeseries);
n=0:M-1;
%% S-transform
H=[fft(timeseries) fft(timeseries)];% 先对信号做FFT,之所以要两个是充分利用了其周期性;[128个数 128个数]
%%%因为我们做FFT,高斯窗也是周期重复,信号从0开始取值%%%
%%%所以我们的取值实际上将负半轴的值移位(M/2)个点到了正半轴%%%
switch (S_kind)
    %% 基本的S变换
    case 1
        disp('基本的S变换.....');
t=[0:floor(M/2)-1 -floor(M/2):-1]/fs;% 高斯窗取的时间序列;
W=[1 zeros(1,M-1)];% 窗函数的FFT初始化,因为零频就是对信号做均值,所以单独列为1;
ST=zeros(M/2,M);
% ST(1,:)=mean(h)*(1&(1:N));% 第一个零频点也可以这么求;
for m=0:floor(M/2)-1 % 频率的取值范围为[0:floor(M/2)-1]
    ST(m+1,:) = ifft(H(m+1:m+M).*W); % 根据论文定义,其应该是信号的傅里叶变换点乘高斯窗的傅里叶变换然后再进行反变换就可以得到S变换时频域
    w = abs(m+1)/sqrt(2.*pi)*exp(-(m+1)^2*t.^2/2); % 窗函数表达式,注意时间t所在位置的取值;
    W = fft(w/sum(w));% 对窗函数进行归一化,确保其可逆
end
    %% 广义S变换
    case 2
        disp('广义S变换.....');
t=[0:floor(M/2)-1 -floor(M/2):-1]/fs;% 高斯窗取的时间序列;
W=[1 zeros(1,M-1)];% 窗函数的FFT初始化,因为零频就是对信号做均值,所以单独列为1;
ST=zeros(M/2,M);
% ST(1,:)=mean(h)*(1&(1:N));% 第一个零频点也可以这么求;
for m=0:floor(M/2)-1 % 频率的取值范围为[0:floor(M/2)-1]
    ST(m+1,:) = ifft(H(m+1:m+M).*W);
    w = abs(m+1)/(k*sqrt(2.*pi))*exp(-(m+1)^2*t.^2/(2*k*k)); % k>1时，频域特性增强；<0k<1时域特性增强
    W = fft(w/sum(w));% 对窗函数进行归一化,确保其可逆
end
    %% 改进型S变换
    case 3
        disp('改进型S变换.....');
t=[0:floor(M/2)-1 -floor(M/2):-1]/fs;% 高斯窗取的时间序列;
W=[1 zeros(1,M-1)];% 窗函数的FFT初始化,因为零频就是对信号做均值,所以单独列为1;
ST=zeros(M/2,M);
% ST(1,:)=mean(h)*(1&(1:N));% 第一个零频点也可以这么求;
for m=0:floor(M/2)-1 % 频率的取值范围为[0:floor(M/2)-1]
    ST(m+1,:) = ifft(H(m+1:m+M).*W);
    w = (p+(m+1)^q)/(sqrt(2.*pi))*exp(-(p+(m+1)^q)^2*t.^2/2); % p,q增大，时域分辨率增强；p,q减小，频域分辨率增强
    W = fft(w/sum(w));% 对窗函数进行归一化,确保其可逆
end
    otherwise
        disp('请输入正确的S转换的类型');
end
%% S变换矩阵展示
if paint==1
disp('S变换正在画图 figure10  ....');
sign_real=abs(ST);%将复数域矩阵转化为实数域矩阵
sign_t=max(sign_real);%找出各个列向量的最大值;
sign_f=max(abs(ST),[],2);%找出各个行向量的最大值，后面的[],2是固定的用法

figure(10)

subplot(3,1,1)
t=(0:M-1)/fs;%时间间隔为1/fs
plot(t,timeseries)
axis([0,0.2,-inf,inf])
title('信号','fontsize',12)
xlabel('时间（s）')
ylabel('幅值（p.u.）')

subplot(3,1,2)
t=(0:length(sign_t)-1)/fs;%时间间隔为1/fs
plot(t,sign_t)
%axis([0,0.2,0,1.5])%论文中统一分辨率
axis([0,0.2,-inf,inf])
title('时域包络线','fontsize',12)
xlabel('时间（s）')
ylabel('幅值（p.u.）')

subplot(3,1,3)
t=(0:length(sign_f)-1)*(fs/M);%频率间隔为fs/N
plot(t,sign_f)
axis([0,2560,-inf,inf])
title('频域包络线','fontsize',12)
xlabel('频率（Hz）')
ylabel('幅值（p.u.）')
else
disp('S变换没有选择画图 ...');  
end
disp('_______________  END:func_simplyST  ________________'); 
end