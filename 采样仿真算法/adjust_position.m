%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Title:对S变换以后的数组进行排序，使相同的扰动类型放在一起
%
%
% DESCRIPTION:具体的调序方法根据S变换以后特征值的排序实际情况，进行实际选择
% modification history:see git log
% --------------------
% 
% --------------------
%01a,  06/14/2106，吴言  rewritten
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Initialize the vaires;
% calu_result（sig_type，特征值个数，samp_num） 用于调序的数组
% adjust_result（排序后的扰动行向量，特征值） 调序后的结果
% sig_type 一个周期中不同扰动信号的类型数
% samp_num 总共有 samp_num 个上面的周期
% position_kind 原始信号的排序类型（根据实际情况进行选择）
function [adjust_result]=adjust_position(to_adjust,sig_type,samp_num,position_kind)

switch (position_kind)
    %% 排序的类型 [[1,2,3,4,5,6,7,...];[1,2,3,4,5,6,7,...];[1,2,3,4,5,6,7,...];...]
    case 1
    for i=1:1:sig_type
        for j=1:1:samp_num
            adjust_result(j+(i-1)*samp_num,:)=to_adjust(i,:,j);
        end
    end
    %% 其他排序（用于扩展）
    case 2
       
    %% 其他排序（用于扩展）
    case 3
end
return
