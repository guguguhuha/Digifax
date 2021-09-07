% ����
clear,clc;
% ��������
data_flag = input('�뽫���ݵ���Ϊinit_data�����ѵ��������� 1 >> ');
if data_flag == 1
    load init_data.mat
    [row,col] = size(init_data);
    disp(['������������ݹ���',num2str(row),'�����ݣ�����',num2str(col),'������ָ��']);
    dispose_choice = input('�Ƿ���Ҫ���򻯴��� 1.�� 0.�� ');
    if dispose_choice == 1
        dispose_col = input('������Ҫ�����ļ��� >> ');
        dispose_type = input('��������ѡ�� 1.��С�� 2.�м��� 3.������ >> ');
        for i = 1:size(dispose_col,2)
            change_col_num = dispose_col(i);
            change_col_type = dispose_type(i);
            change_col_val = init_data(:,change_col_num);
            init_data(:,change_col_num) = forward_change(change_col_val, change_col_type);
        end
    end
    forward_mat = init_data;
    average_data = mean(forward_mat);
    stand_data = forward_mat ./ average_data;
    % ÿһ���е����ֵ��Ϊĸ����
    x0 = max(stand_data,[],2);
    x = stand_data;
    diference_of_x_xi = abs(x - x0);
%     diference_of_x_xi2 = abs(x - repmat(x0,1,size(x0,2))); % % ���Ͼ�Ч����ʵ��ͬ
    max_val = max(diference_of_x_xi(:));
    min_val = min(diference_of_x_xi(:));
    rho = 0.5;
    grey_analy = (min_val + rho .* max_val) ./ (diference_of_x_xi + rho .* max_val);
    grey_analy_result = mean(grey_analy);
    weight = grey_analy_result./sum(grey_analy_result,2);
    score = sum(x .* weight, 2);
    final_score = score ./ sum(score, 1);
    [score, index] = sort(final_score)
    
end
