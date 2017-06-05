%% 定义不同的函数
% sig_type取值范围是1,2,3,4,5,6,7,分别对应于7种不同的信号类型
% fs=5120;%采样率;
% f0=50;%电网基波频率;
function signal=sign_gen(sig_type,fs,f0)
N=10*fs/f0;%采样点数(总共10个周波);
N=87;
n=0:N-1;%时间序列;
% t=n/fs;%时间间隔;
switch(sig_type)
    case 1
        %% ----正常电压----
        signal=sin(2*pi*f0*n/fs);
    case 2
        %% ----电压骤升----
        a2=0.1+rand(1,1)*0.7;%骤升比例系数(0.1~0.8之间随机分布)
        t1=0;%起始时刻;
        t2=0;%结束时刻;
        while (t2-t1<0.02)||(t2-t1 > 0.18)%不满足约束条件:T<t2-t1<9T，则一直为真；
             t1=rand(1,1)*0.18;
             t2=0.02+rand(1,1)*0.18;
        end
        ntemp=0:N-1;%阶跃信号整个时间序列长度
        u1step=(ntemp-t1*fs)>=0;%求出t1的阶跃序列(阶跃点为t1/(1/fs));
        u2step=(ntemp-t2*fs)>=0;%求出t2的阶跃序列;
        signal=(1+a2*(u1step-u2step)).*sin(2*pi*f0*n/fs);
    case 3
        %% ----电压骤降----
        a3=0.1+rand(1,1)*0.8;%骤降电压比例系数(0.1~0.9之间的随机分布);
        t1=0;
        t2=0;
        while (t2-t1<0.02)||(t2-t1 > 0.18)
             t1=rand(1,1)*0.18;%0.02=<t2-t1=<0.18;
             t2=0.02+rand(1,1)*0.18;
        end
        a3=0.5;t1=0.15;t2=0.35;% 根据采样数据确定参数
        ntemp=0:N-1;
        u1step=(ntemp-t1*fs)>=0;
        u2step=(ntemp-t2*fs)>=0;
        signal=(1-a3*(u1step-u2step)).*sin(2*pi*f0*n/fs);%电压骤降信号;
    case 4
        %% ----电压中断----
        a4=0.9+rand(1,1)*0.1;%电压中断比例系数(在0.9~1.0之间随机变动);
        t1=0;
        t2=0;
        while (t2-t1<0.02)||(t2-t1 > 0.18)
             t1=rand(1,1)*0.18;
            t2=0.02+rand(1,1)*0.18;
        end
        ntemp=0:N-1;
        u1step=(ntemp-t1*fs)>=0;
        u2step=(ntemp-t2*fs)>=0;
        signal=(1-a4*(u1step-u2step)).*sin(2*pi*f0*n/fs);%电压中断的信号模型;
    case 5
         %% ----谐波信号----
        a5=0.05+rand(1,1)*0.25;%2次谐波含量在0.05~0.3之间;
        b5=0.05+rand(1,1)*0.25;%3次谐波含量在0.05~0.3之间;
        c5=0.05+rand(1,1)*0.25;%4次谐波含量在0.05~0.3之间;
        a51=0.05+rand(1,1)*0.25;%5次谐波含量在0.05~0.3之间;
        b51=0.05+rand(1,1)*0.25;%6次谐波含量在0.05~0.3之间;
        c51=0.05+rand(1,1)*0.25;%7次谐波含量在0.05~0.3之间; 
%         a5=0.1;b5=0.3;c5=0.2;a51=0.1;b51=0.1;c51=0.2;%谐波参数设置方法  基于改进S变换的电能质量扰动信息特征提取方法  吴禹
%         signal=sin(2*pi*f0*n/fs)+a5*sin(2*pi*2*f0*n/fs)+b5*sin(2*pi*3*f0*n/fs)+...
%             c5*sin(2*pi*4*f0*n/fs)+a51*sin(2*pi*5*f0*n/fs)+b51*sin(2*pi*6*f0*n/fs)+c51*sin(2*pi*7*f0*n/fs); 
%         b5=0.2;a51=0.1;c51=0.3;
        signal=sin(2*pi*f0*n/fs)+b5*sin(2*pi*3*f0*n/fs)+a51*sin(2*pi*5*f0*n/fs)+c51*sin(2*pi*7*f0*n/fs);  
%         signal=sin(2*pi*f0*n/fs)+b5*sin(2*pi*3*f0*n/fs)+a51*sin(2*pi*5*f0*n/fs)+c51*sin(2*pi*7*f0*n/fs);  
%         a1=0.2;
%         Max_f=20;
%         signal=sin(2*pi*f0*n/fs);
%         for i=2:1:Max_f
%             signal=signal+a1*sin(2*pi*i*f0*n/fs);
%         end
    case 6
        %% ----骤升+谐波信号----
        a2=0.1+rand(1,1)*0.7;%骤升比例系数;
        t1=0;
        t2=0;
        while (t2-t1<0.02)||(t2-t1 > 0.18)%不满足约束条件:T<t2-t1<9T，则一直为真；
              t1=rand(1,1)*0.18;%0.02=<t2-t1=<0.18;
              t2=0.02+rand(1,1)*0.18;
        end
        ntemp=0:N-1;
        u1step=(ntemp-t1*fs)>=0;%求出t1的阶跃点;
        u2step=(ntemp-t2*fs)>=0;%求出t2的阶跃点;
        a6=0.05+rand(1,1)*0.25;%3次谐波含量在0.05~0.3之间;
        b6=0.05+rand(1,1)*0.25;%5次谐波含量在0.05~0.3之间;
        c6=0.05+rand(1,1)*0.25;%7次谐波含量在0.05~0.3之间;
         signal=(1+a2*(u1step-u2step)).*(sin(2*pi*f0*n/fs)+a6*sin(2*pi*3*f0*n/fs)+b6*sin(2*pi*5*f0*n/fs)+c6*sin(2*pi*7*f0*n/fs));
%             signal=(1+a2*(u1step-u2step)).*(sin(2*pi*f0*n/fs)+...
%             0.09*sin(2*pi*2*f0*n/fs)+0.11*sin(2*pi*3*f0*n/fs)+...%含有间谐波
%             0.13*sin(2*pi*4*f0*n/fs)+0.05*sin(2*pi*5*f0*n/fs)+0.08*sin(2*pi*6*f0*n/fs)+0.26*sin(2*pi*7*f0*n/fs)+...
%             0.07*sin(2*pi*1.5*f0*n/fs)+0.21*sin(2*pi*3.5*f0*n/fs)+0.24*sin(2*pi*6.2*f0*n/fs));
    case 7
        %% ----电压骤降+谐波信号----
        a2=0.1+rand(1,1)*0.8;%骤降比例系数;
        t1=0;
        t2=0;
        while (t2-t1<0.02)||(t2-t1 > 0.18)%不满足约束条件:T<t2-t1<9T，则一直为真；
                t1=rand(1,1)*0.18;%0.02=<t2-t1=<0.18;
                t2=0.02+rand(1,1)*0.18;
        end
        a2=0.5;t1=0.05;t2=0.15;%根据实际情况确定
        ntemp=0:N-1;
        u1step=(ntemp-t1*fs)>=0;%求出t1的阶跃时刻;
        u2step=(ntemp-t2*fs)>=0;%求出t2的阶跃时刻;
        a7=0.05+rand(1,1)*0.25;%3次谐波含量在0.05~0.3之间;
        b7=0.05+rand(1,1)*0.25;%5次谐波含量在0.05~0.3之间;
        c7=0.05+rand(1,1)*0.25;%7次谐波含量在0.05~0.3之间;
        a7=0.3;b7=0.1;c7=0.2;%谐波参数设置方法  基于改进S变换的电能质量扰动信息特征提取方法  吴禹 
%         signal=(1-a2*(u1step-u2step)).*(sin(2*pi*f0*n/fs)+a7*sin(2*pi*3*f0*n/fs)+b7*sin(2*pi*5*f0*n/fs)+c7*sin(2*pi*7*f0*n/fs));
        signal=(1-a2*(u1step-u2step)).*(sin(2*pi*f0*n/fs)+a7*sin(2*pi*3*f0*n/fs)+b7*sin(2*pi*5*f0*n/fs)+c7*sin(2*pi*7*f0*n/fs));
    case 8
        %% ----电压闪变----
        a8=0.01+rand(1,1)*0.19;
        b8=0.1+rand(1,1)*0.4;
        a8=0.1;b8=0.5;%仿真用 数据来源 optimal feature selection for power quality disturbances classification  
        signal=(1+a8*sin(b8*2*pi*f0*n/fs)).*sin(2*pi*f0*n/fs);   
    case 9
        %% ----高频振荡----  在参数选定上仍然存在问题
        %参数来源于   optimal feature selection for power quality disturbances classification  
        %模型来源于   optimal feature selection for power quality disturbances classification  
        a9=0.008+rand(1,1)*0.032;
        b9=0.1+rand(1,1)*0.7;
        w1=0;%高频振荡的频率,300 Hz ~ 900 Hz
        while (w1<0.3||w1>0.9)
                w1=rand(1,1);
        end
        w1=ceil(w1*1000);
        ntemp=0:N-1;
        t1=0;
        t2=0;
         while (t2-t1<0.01)||(t2-t1 > 0.06)
                t1=0.01+rand(1,1)*0.18;
                t2=0.01+rand(1,1)*0.18;
         end
%          a9=0.02;%用于测试用
%          b9=0.5;%用于测试用
         w1=350;%用于测试用
%          t1=0.15;t2=0.18;%用于仿真测试用
        u1step=(ntemp-t1*fs)>=0;
        u2step=(ntemp-t2*fs)>=0;
        signal=sin(2*pi*f0*n/fs)+b9*exp(-(ntemp-t1*fs)/(fs*a9)).*(u1step-u2step).*sin(2*pi*w1*n/fs);       
    case 10
        %% ---- 暂态脉冲 ----
        %参数来源于   电能质量问题剖析
        %模型来源于   电能质量相关信号的S变换检测算法及应用研究
%         t1=ceil(rand(1,1)*1024);%t1 脉冲出现的时间序列；毫秒级脉冲，持续时间大于 0.1ms
%         h1=2;% 脉冲的高度
%         pulse=zeros(1,N);
%         count=1;
%         for i=1:1:N-1
%             if i==t1
%                 pulse(1,count)=h1;
%                 if i==N %放置到了最后的一点
%                     break;
%                 else
%                 count=count+1;
%                 pulse(1,count)=h1; %脉冲持续时间大概为：1/5120*2 = 0.1953*2 ms= 0.39 ms
%                 end
%             else
%                 pulse(1,count)=0;
%             end
%             count=count+1;
%         end
%         signal=sin(2*pi*f0*n/fs)+pulse;  
        %% 待测试 基于决策树和支持向量机的电能质量扰动识别
        a10=1+rand(1,1)*2;
        ntemp=0:N-1;
        t1=0;
        t2=0;
         while (t2-t1<0.0005)||(t2-t1 > 0.0015)
                t1=rand(1,1)*0.18;
                t2=0.001+rand(1,1)*0.18;
         end
        u1step=(ntemp-t1*fs)>=0;
        u2step=(ntemp-t2*fs)>=0;
        signal=sin(2*pi*f0*n/fs)+a10*(u1step-u2step);     
        %% 以上测试通过，暂时使用0816/2016
% 		%% 待测试 基于小波变换的电能质量检测与仿真分析
%         t1=0;
%         t2=0;
%         while (t2-t1<0.001)||(t2-t1 > 0.002)%不满足约束条件:T/20<t2-t1<T/10，则一直为真；
%                 t1=rand(1,1)*0.002;
%                 t2=0.001+rand(1,1)*0.002;
%         end		
%         ntemp=0:N-1;
%         u1step=(ntemp-t1*fs)>=0;%求出t1的阶跃点;
%         u2step=(ntemp-t2*fs)>=0;%求出t2的阶跃点;
% 		signal=sin(2*pi*f0*n/fs)*(1-(u1step-u2step));  
% 		%% 以上待测试 （测试结果是，于向下的脉冲式正确的，向上的脉冲类似于切口，其实质与中断类似）
    case 11
        %% ---- 电压尖峰 ----  
        % 参数，模型来源于 optimal feature selection for power quality disturbances classification  
        a11=1;%电压尖峰
        b11=0;
        c11=zeros(1,N);
        while (b11<=0.1)%不满足约束条件:0.1<b11<0.4，则一直为真；
              b11=rand(1,1)*0.4;
        end        
        t1=0;
        t2=0;
        while (t2-t1<0.0001)||(t2-t1 > 0.001)%不满足约束条件:T/32<t2-t1<T/8，则一直为真；
              t1=rand(1,1)*0.01;
              t2=rand(1,1)*0.01;
        end
        ntemp=0:N-1;
        for i=1:1:9
        u1step=(ntemp-(t1+i*0.02)*fs)>=0;%求出t1的阶跃时刻;
        u2step=(ntemp-(t2+i*0.02)*fs)>=0;%求出t2的阶跃时刻;
            c11_temp=b11*(u1step-u2step);
            c11=c11+c11_temp;
        end
        temp=sign(sin(2*pi*f0*n/fs));
        signaltemp=temp.*c11;
        signal=sin(2*pi*f0*n/fs)+a11*signaltemp;
    case 12
        %% ---- 电压切口 ----  
        % 参数，模型来源于 optimal feature selection for power quality disturbances classification  
        a11=-1;%电压切口
        b11=0;
        c11=zeros(1,N);
        while (b11<=0.1)%不满足约束条件:0.1<b11<0.4，则一直为真；
              b11=rand(1,1)*0.4;
        end        
        t1=0;
        t2=0;
        while (t2-t1<0.0001)||(t2-t1 > 0.001)%不满足约束条件:T/32<t2-t1<T/8，则一直为真；
              t1=rand(1,1)*0.01;
              t2=rand(1,1)*0.01;
        end
        ntemp=0:N-1;
        for i=1:1:10
        u1step=(ntemp-(t1+i*0.02)*fs)>=0;%求出t1的阶跃时刻;
        u2step=(ntemp-(t2+i*0.02)*fs)>=0;%求出t2的阶跃时刻;
            c11_temp=b11*(u1step-u2step);
            c11=c11+c11_temp;
        end
        temp=sign(sin(2*pi*f0*n/fs));
        signaltemp=temp.*c11;
        signal=sin(2*pi*f0*n/fs)+a11*signaltemp;
        
    otherwise
        signal=zero(1,1024);
        disp('请输入正确的信号类型');
end
end