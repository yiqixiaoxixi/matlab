%% ����һ�����������ڽ����m���зŵ�һ��
% data_changed  �����������
% data  ������������
% postion_step   �������
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