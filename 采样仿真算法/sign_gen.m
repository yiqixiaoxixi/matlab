%% ���岻ͬ�ĺ���
% sig_typeȡֵ��Χ��1,2,3,4,5,6,7,�ֱ��Ӧ��7�ֲ�ͬ���ź�����
% fs=5120;%������;
% f0=50;%��������Ƶ��;
function signal=sign_gen(sig_type,fs,f0)
N=10*fs/f0;%��������(�ܹ�10���ܲ�);
N=87;
n=0:N-1;%ʱ������;
% t=n/fs;%ʱ����;
switch(sig_type)
    case 1
        %% ----������ѹ----
        signal=sin(2*pi*f0*n/fs);
    case 2
        %% ----��ѹ����----
        a2=0.1+rand(1,1)*0.7;%��������ϵ��(0.1~0.8֮������ֲ�)
        t1=0;%��ʼʱ��;
        t2=0;%����ʱ��;
        while (t2-t1<0.02)||(t2-t1 > 0.18)%������Լ������:T<t2-t1<9T����һֱΪ�棻
             t1=rand(1,1)*0.18;
             t2=0.02+rand(1,1)*0.18;
        end
        ntemp=0:N-1;%��Ծ�ź�����ʱ�����г���
        u1step=(ntemp-t1*fs)>=0;%���t1�Ľ�Ծ����(��Ծ��Ϊt1/(1/fs));
        u2step=(ntemp-t2*fs)>=0;%���t2�Ľ�Ծ����;
        signal=(1+a2*(u1step-u2step)).*sin(2*pi*f0*n/fs);
    case 3
        %% ----��ѹ�轵----
        a3=0.1+rand(1,1)*0.8;%�轵��ѹ����ϵ��(0.1~0.9֮�������ֲ�);
        t1=0;
        t2=0;
        while (t2-t1<0.02)||(t2-t1 > 0.18)
             t1=rand(1,1)*0.18;%0.02=<t2-t1=<0.18;
             t2=0.02+rand(1,1)*0.18;
        end
        a3=0.5;t1=0.15;t2=0.35;% ���ݲ�������ȷ������
        ntemp=0:N-1;
        u1step=(ntemp-t1*fs)>=0;
        u2step=(ntemp-t2*fs)>=0;
        signal=(1-a3*(u1step-u2step)).*sin(2*pi*f0*n/fs);%��ѹ�轵�ź�;
    case 4
        %% ----��ѹ�ж�----
        a4=0.9+rand(1,1)*0.1;%��ѹ�жϱ���ϵ��(��0.9~1.0֮������䶯);
        t1=0;
        t2=0;
        while (t2-t1<0.02)||(t2-t1 > 0.18)
             t1=rand(1,1)*0.18;
            t2=0.02+rand(1,1)*0.18;
        end
        ntemp=0:N-1;
        u1step=(ntemp-t1*fs)>=0;
        u2step=(ntemp-t2*fs)>=0;
        signal=(1-a4*(u1step-u2step)).*sin(2*pi*f0*n/fs);%��ѹ�жϵ��ź�ģ��;
    case 5
         %% ----г���ź�----
        a5=0.05+rand(1,1)*0.25;%2��г��������0.05~0.3֮��;
        b5=0.05+rand(1,1)*0.25;%3��г��������0.05~0.3֮��;
        c5=0.05+rand(1,1)*0.25;%4��г��������0.05~0.3֮��;
        a51=0.05+rand(1,1)*0.25;%5��г��������0.05~0.3֮��;
        b51=0.05+rand(1,1)*0.25;%6��г��������0.05~0.3֮��;
        c51=0.05+rand(1,1)*0.25;%7��г��������0.05~0.3֮��; 
%         a5=0.1;b5=0.3;c5=0.2;a51=0.1;b51=0.1;c51=0.2;%г���������÷���  ���ڸĽ�S�任�ĵ��������Ŷ���Ϣ������ȡ����  ����
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
        %% ----����+г���ź�----
        a2=0.1+rand(1,1)*0.7;%��������ϵ��;
        t1=0;
        t2=0;
        while (t2-t1<0.02)||(t2-t1 > 0.18)%������Լ������:T<t2-t1<9T����һֱΪ�棻
              t1=rand(1,1)*0.18;%0.02=<t2-t1=<0.18;
              t2=0.02+rand(1,1)*0.18;
        end
        ntemp=0:N-1;
        u1step=(ntemp-t1*fs)>=0;%���t1�Ľ�Ծ��;
        u2step=(ntemp-t2*fs)>=0;%���t2�Ľ�Ծ��;
        a6=0.05+rand(1,1)*0.25;%3��г��������0.05~0.3֮��;
        b6=0.05+rand(1,1)*0.25;%5��г��������0.05~0.3֮��;
        c6=0.05+rand(1,1)*0.25;%7��г��������0.05~0.3֮��;
         signal=(1+a2*(u1step-u2step)).*(sin(2*pi*f0*n/fs)+a6*sin(2*pi*3*f0*n/fs)+b6*sin(2*pi*5*f0*n/fs)+c6*sin(2*pi*7*f0*n/fs));
%             signal=(1+a2*(u1step-u2step)).*(sin(2*pi*f0*n/fs)+...
%             0.09*sin(2*pi*2*f0*n/fs)+0.11*sin(2*pi*3*f0*n/fs)+...%���м�г��
%             0.13*sin(2*pi*4*f0*n/fs)+0.05*sin(2*pi*5*f0*n/fs)+0.08*sin(2*pi*6*f0*n/fs)+0.26*sin(2*pi*7*f0*n/fs)+...
%             0.07*sin(2*pi*1.5*f0*n/fs)+0.21*sin(2*pi*3.5*f0*n/fs)+0.24*sin(2*pi*6.2*f0*n/fs));
    case 7
        %% ----��ѹ�轵+г���ź�----
        a2=0.1+rand(1,1)*0.8;%�轵����ϵ��;
        t1=0;
        t2=0;
        while (t2-t1<0.02)||(t2-t1 > 0.18)%������Լ������:T<t2-t1<9T����һֱΪ�棻
                t1=rand(1,1)*0.18;%0.02=<t2-t1=<0.18;
                t2=0.02+rand(1,1)*0.18;
        end
        a2=0.5;t1=0.05;t2=0.15;%����ʵ�����ȷ��
        ntemp=0:N-1;
        u1step=(ntemp-t1*fs)>=0;%���t1�Ľ�Ծʱ��;
        u2step=(ntemp-t2*fs)>=0;%���t2�Ľ�Ծʱ��;
        a7=0.05+rand(1,1)*0.25;%3��г��������0.05~0.3֮��;
        b7=0.05+rand(1,1)*0.25;%5��г��������0.05~0.3֮��;
        c7=0.05+rand(1,1)*0.25;%7��г��������0.05~0.3֮��;
        a7=0.3;b7=0.1;c7=0.2;%г���������÷���  ���ڸĽ�S�任�ĵ��������Ŷ���Ϣ������ȡ����  ���� 
%         signal=(1-a2*(u1step-u2step)).*(sin(2*pi*f0*n/fs)+a7*sin(2*pi*3*f0*n/fs)+b7*sin(2*pi*5*f0*n/fs)+c7*sin(2*pi*7*f0*n/fs));
        signal=(1-a2*(u1step-u2step)).*(sin(2*pi*f0*n/fs)+a7*sin(2*pi*3*f0*n/fs)+b7*sin(2*pi*5*f0*n/fs)+c7*sin(2*pi*7*f0*n/fs));
    case 8
        %% ----��ѹ����----
        a8=0.01+rand(1,1)*0.19;
        b8=0.1+rand(1,1)*0.4;
        a8=0.1;b8=0.5;%������ ������Դ optimal feature selection for power quality disturbances classification  
        signal=(1+a8*sin(b8*2*pi*f0*n/fs)).*sin(2*pi*f0*n/fs);   
    case 9
        %% ----��Ƶ��----  �ڲ���ѡ������Ȼ��������
        %������Դ��   optimal feature selection for power quality disturbances classification  
        %ģ����Դ��   optimal feature selection for power quality disturbances classification  
        a9=0.008+rand(1,1)*0.032;
        b9=0.1+rand(1,1)*0.7;
        w1=0;%��Ƶ�񵴵�Ƶ��,300 Hz ~ 900 Hz
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
%          a9=0.02;%���ڲ�����
%          b9=0.5;%���ڲ�����
         w1=350;%���ڲ�����
%          t1=0.15;t2=0.18;%���ڷ��������
        u1step=(ntemp-t1*fs)>=0;
        u2step=(ntemp-t2*fs)>=0;
        signal=sin(2*pi*f0*n/fs)+b9*exp(-(ntemp-t1*fs)/(fs*a9)).*(u1step-u2step).*sin(2*pi*w1*n/fs);       
    case 10
        %% ---- ��̬���� ----
        %������Դ��   ����������������
        %ģ����Դ��   ������������źŵ�S�任����㷨��Ӧ���о�
%         t1=ceil(rand(1,1)*1024);%t1 ������ֵ�ʱ�����У����뼶���壬����ʱ����� 0.1ms
%         h1=2;% ����ĸ߶�
%         pulse=zeros(1,N);
%         count=1;
%         for i=1:1:N-1
%             if i==t1
%                 pulse(1,count)=h1;
%                 if i==N %���õ�������һ��
%                     break;
%                 else
%                 count=count+1;
%                 pulse(1,count)=h1; %�������ʱ����Ϊ��1/5120*2 = 0.1953*2 ms= 0.39 ms
%                 end
%             else
%                 pulse(1,count)=0;
%             end
%             count=count+1;
%         end
%         signal=sin(2*pi*f0*n/fs)+pulse;  
        %% ������ ���ھ�������֧���������ĵ��������Ŷ�ʶ��
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
        %% ���ϲ���ͨ������ʱʹ��0816/2016
% 		%% ������ ����С���任�ĵ������������������
%         t1=0;
%         t2=0;
%         while (t2-t1<0.001)||(t2-t1 > 0.002)%������Լ������:T/20<t2-t1<T/10����һֱΪ�棻
%                 t1=rand(1,1)*0.002;
%                 t2=0.001+rand(1,1)*0.002;
%         end		
%         ntemp=0:N-1;
%         u1step=(ntemp-t1*fs)>=0;%���t1�Ľ�Ծ��;
%         u2step=(ntemp-t2*fs)>=0;%���t2�Ľ�Ծ��;
% 		signal=sin(2*pi*f0*n/fs)*(1-(u1step-u2step));  
% 		%% ���ϴ����� �����Խ���ǣ������µ�����ʽ��ȷ�ģ����ϵ������������пڣ���ʵ�����ж����ƣ�
    case 11
        %% ---- ��ѹ��� ----  
        % ������ģ����Դ�� optimal feature selection for power quality disturbances classification  
        a11=1;%��ѹ���
        b11=0;
        c11=zeros(1,N);
        while (b11<=0.1)%������Լ������:0.1<b11<0.4����һֱΪ�棻
              b11=rand(1,1)*0.4;
        end        
        t1=0;
        t2=0;
        while (t2-t1<0.0001)||(t2-t1 > 0.001)%������Լ������:T/32<t2-t1<T/8����һֱΪ�棻
              t1=rand(1,1)*0.01;
              t2=rand(1,1)*0.01;
        end
        ntemp=0:N-1;
        for i=1:1:9
        u1step=(ntemp-(t1+i*0.02)*fs)>=0;%���t1�Ľ�Ծʱ��;
        u2step=(ntemp-(t2+i*0.02)*fs)>=0;%���t2�Ľ�Ծʱ��;
            c11_temp=b11*(u1step-u2step);
            c11=c11+c11_temp;
        end
        temp=sign(sin(2*pi*f0*n/fs));
        signaltemp=temp.*c11;
        signal=sin(2*pi*f0*n/fs)+a11*signaltemp;
    case 12
        %% ---- ��ѹ�п� ----  
        % ������ģ����Դ�� optimal feature selection for power quality disturbances classification  
        a11=-1;%��ѹ�п�
        b11=0;
        c11=zeros(1,N);
        while (b11<=0.1)%������Լ������:0.1<b11<0.4����һֱΪ�棻
              b11=rand(1,1)*0.4;
        end        
        t1=0;
        t2=0;
        while (t2-t1<0.0001)||(t2-t1 > 0.001)%������Լ������:T/32<t2-t1<T/8����һֱΪ�棻
              t1=rand(1,1)*0.01;
              t2=rand(1,1)*0.01;
        end
        ntemp=0:N-1;
        for i=1:1:10
        u1step=(ntemp-(t1+i*0.02)*fs)>=0;%���t1�Ľ�Ծʱ��;
        u2step=(ntemp-(t2+i*0.02)*fs)>=0;%���t2�Ľ�Ծʱ��;
            c11_temp=b11*(u1step-u2step);
            c11=c11+c11_temp;
        end
        temp=sign(sin(2*pi*f0*n/fs));
        signaltemp=temp.*c11;
        signal=sin(2*pi*f0*n/fs)+a11*signaltemp;
        
    otherwise
        signal=zero(1,1024);
        disp('��������ȷ���ź�����');
end
end