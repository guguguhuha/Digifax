% stand_mat --- 标准化后的矩阵
% forward_mat --- 正向化后的矩阵
function [result_weight] = weight(stand_mat,forward_mat)
    choice = input('请输入你要添加权重的方法：1.层次分析法 2.熵权法 3.用户自行输入 >> ');
    while 1
        if choice >= 1 && choice <= 3
            break;
        else
            choice = input('请重新输入 >> ');
        end
    end
    if choice == 1 % 层次分析法
        result_weight = AHP_weight;  
    elseif choice == 2 % 熵权法
        result_weight = ent_met_weight(stand_mat,forward_mat);  
    elseif choice == 3 % 用户自行输入
        result_weight = user_enter_weight(stand_mat);
    end
end 