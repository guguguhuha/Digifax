clear, clc;
disp('使用前请将数据储存到init_data.mat文件中，并放置在当前文件夹下');
choice = input('完成请输入 1 来表示已完成 >> ');
if choice == 1
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
    disp('正向化矩阵');
    disp(forward_mat);
    temp_mat = sum(forward_mat.*forward_mat).^0.5;
    mod_mat = repmat(temp_mat,row,1);
    stand_mat = forward_mat ./ mod_mat;
    disp('标准化矩阵');
    disp(stand_mat);
    data_weight = ones(1,col);
    weight_choice = input('是否要进行权重的计算 1.是 2.否 ');
    if weight_choice == 1
        data_weight = weight(stand_mat, forward_mat);
    end
    disp(data_weight);
    D_max = sum((stand_mat - repmat(max(stand_mat),row,1)).^2 .*repmat(data_weight,row, 1), 2).^0.5;
    D_min = sum((stand_mat - repmat(min(stand_mat),row,1)).^2 .*repmat(data_weight,row, 1), 2).^0.5;
    grade = D_min./(D_max+D_min);
    stand_grade = grade/sum(grade);
    disp('最终得分：');
    disp(stand_grade);
    [gra_val,gra_index] = sort(stand_grade);

end
