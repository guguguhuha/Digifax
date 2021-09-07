% 清屏
clear,clc;
% 导入数据
data_flag = input('请将数据导入为init_data，若已导入请输入 1 >> ');
if data_flag == 1
    load init_data.mat
    [row,col] = size(init_data);
    disp(['你所输入的数据共有',num2str(row),'组数据，共有',num2str(col),'个评价指标']);
    dispose_choice = input('是否需要正向化处理 1.是 0.否 ');
    if dispose_choice == 1
        dispose_col = input('请输入要处理哪几列 >> ');
        dispose_type = input('按序类型选择 1.极小型 2.中间型 3.区间型 >> ');
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
    % 每一行中的最大值作为母序列
    x0 = max(stand_data,[],2);
    x = stand_data;
    diference_of_x_xi = abs(x - x0);
%     diference_of_x_xi2 = abs(x - repmat(x0,1,size(x0,2))); % % 与上句效果其实相同
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
