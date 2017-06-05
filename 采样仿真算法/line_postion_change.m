%% 定义一个函数，用于将间隔m的行放到一起
% data_changed  调整后的数组
% data  待调整的数组
% postion_step   间隔步长
function data_changed=line_postion_change(data,postion_step)
changed_postion=1;
for count=1:postion_step
    while(count<=size(data,1))
    data_changed(changed_postion,:)=data(count,:);
    count=count+postion_step;
    changed_postion=changed_postion+1;
    end
end
end