%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Title:��S�任�Ժ�������������ʹ��ͬ���Ŷ����ͷ���һ��
%
%
% DESCRIPTION:����ĵ��򷽷�����S�任�Ժ�����ֵ������ʵ�����������ʵ��ѡ��
% modification history:see git log
% --------------------
% 
% --------------------
%01a,  06/14/2106������  rewritten
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Initialize the vaires;
% calu_result��sig_type������ֵ������samp_num�� ���ڵ��������
% adjust_result���������Ŷ�������������ֵ�� �����Ľ��
% sig_type һ�������в�ͬ�Ŷ��źŵ�������
% samp_num �ܹ��� samp_num �����������
% position_kind ԭʼ�źŵ��������ͣ�����ʵ���������ѡ��
function [adjust_result]=adjust_position(to_adjust,sig_type,samp_num,position_kind)

switch (position_kind)
    %% ��������� [[1,2,3,4,5,6,7,...];[1,2,3,4,5,6,7,...];[1,2,3,4,5,6,7,...];...]
    case 1
    for i=1:1:sig_type
        for j=1:1:samp_num
            adjust_result(j+(i-1)*samp_num,:)=to_adjust(i,:,j);
        end
    end
    %% ��������������չ��
    case 2
       
    %% ��������������չ��
    case 3
end
return
