%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ��ֵ����
% --------------------
% V1.0, 04/27/2017, ���� written
% --------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ��ʼ������������
clear all;%��������ռ�;
clc;%����������ʾ;
signal=sign_gen(8,5120,50);
signal=noisegen(signal,30);
signalfft=fft(signal);
signalampl=abs(signalfft)/(length(signal)/2);
N=length(signal);

%% �õ�����ֵ������
[pks,pks_index]=findpeaks(signalampl);
yi(1,1)=0;%��������ͼ
for i=1:1:pks_index(1)-2
    yi(1,i+1)=i*(pks(1)-0)/pks_index(1);
end
yi(1,pks_index(1))=pks(1);
for i=2:1:ceil(length(pks)/2)
    for j=1:1:pks_index(i)-pks_index(i-1)-1
        yi(1,pks_index(i-1)+j)=pks(i-1)+j*(pks(i)-pks(i-1))/(pks_index(i)-pks_index(i-1));
    end
    yi(1,pks_index(i))=pks(i);
end
yi(1,ceil(length(signal)/2))=0;
for i=1:1:ceil(length(signal)/2)-pks_index(end)-1;
    yi(1,pks_index(end)+i)=pks(end)+i*(0-pks(end))/(ceil(length(signal)/2)-pks_index(end));
end

%% ��ͼ��ʾ
xi=linspace(1,length(yi),length(yi));
figure(1);
plot(signal);
figure(2);
plot(xi,yi,'.-',xi,signalampl(1,1:length(yi)),'--');
