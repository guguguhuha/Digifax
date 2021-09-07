function [weight] = ent_met_weight(stand_mat,forward_mat)
    [row, col] = size(stand_mat);
    check_minuz_mat = stand_mat < 0;% 标准化矩阵不能出现负数
    if sum(check_minuz_mat(:)) > 0 % 如果出现负数，则重新对X进行标准化的构造
        for i = 1:row
            for j = 1:col
                stand_mat(i,j) = (forward_mat(i,j) - min(forward_mat(:,j))) / (max(forward_mat(:,j)) - min(forward_mat(:,j)));
            end
        end
    end
    temp_mat = zeros(1,col);  % 初始化保存信息效用值的行向量
    for j = 1:col
        row_target = stand_mat(:,j);  % 取出第i列的指标
        pro_mat = row_target / sum(row_target);
        ln_pro_mat = zeros(row,1); % 去除零的影响
        for i = 1:row
           if pro_mat(i) == 0
               ln_pro_mat(i) = 0;
           else
               ln_pro_mat(i) = log(pro_mat(i));
           end
        end
        entropy_mat = -(sum(pro_mat.*ln_pro_mat)) / log(row);
        temp_mat(j) = 1 - entropy_mat; % 计算信息效用值
    end
    weight = temp_mat ./ sum(temp_mat);  % 将信息效用值归一化，得到权重    
end