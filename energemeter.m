% the s-tranform test script
close all;clear all;clc
%----------���������趨----------%
len = 1280; 
f0 = 50;
fs = 6400;    
t = (0:len-1)/fs;
%----------��ѹ���������ź�----------%
[v_sig,i_sig] = sim_sig(fs,len,1);
figure,plot(t,v_sig);
xlabel('Time/s');ylabel('Amptitude/V');title('ԭ��ѹ����');
figure,plot(t,i_sig);
xlabel('Time/s');ylabel('Amptitude/A');title('ԭ��������');
%----------��ѹ�ź��ع�----------%
v_st = st(v_sig,0,fs,1/fs);
v1_st = zeros(len/2+1,len);
v1_st(50/fs*len+1,:) = v_st(50/fs*len+1,:);                                %��ȡ��������
vd_st = v_st - v1_st;                                                      
v1 = ist(v1_st);                                                           %�Ի������ֽ���S�任����任
figure,plot(t,v1);
xlabel('Time/s');ylabel('Amptitude/V');title('�ع�������ѹ����');
vd = ist(vd_st);
figure,plot(t,vd);
xlabel('Time/s');ylabel('Amptitude/V');title('�ع������ѹ����');
%----------�����ź��ع�----------%
i_st = st(i_sig,0,fs,1/fs);
i1_st = zeros(len/2+1,len);
i1_st(50/fs*len+1,:) = i_st(50/fs*len+1,:);
id_st = i_st - i1_st;
i1 = ist(i1_st);
figure,plot(t,i1);
xlabel('Time/s');ylabel('Amptitude/A');title('�ع�������������');
id = ist(id_st);
figure,plot(t,id);
xlabel('Time/s');ylabel('Amptitude/A');title('�ع������������');
%----------�����ֹ��ʼ���----------%
p1 = powercalc(v1,i1,len);
p1d = powercalc(v1,id,len);
pd1 = powercalc(vd,i1,len);
pd = powercalc(vd,id,len);

