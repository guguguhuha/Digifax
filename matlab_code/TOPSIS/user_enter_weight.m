function [weight] = user_enter_weight(stand_mat)
    [~, col] = size(stand_mat);
    weight = input(['请输入',num2str(col),'个数据',' >> ']);
    while 1
        if (abs(sum(weight) - 1 ) < 1e-8) && (size(weight, 2) == col)
            break
        else
            weight = input('请重新输入 >> ');
        end
    end
end