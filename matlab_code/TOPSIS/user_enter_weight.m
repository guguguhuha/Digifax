function [weight] = user_enter_weight(stand_mat)
    [~, col] = size(stand_mat);
    weight = input(['������',num2str(col),'������',' >> ']);
    while 1
        if (abs(sum(weight) - 1 ) < 1e-8) && (size(weight, 2) == col)
            break
        else
            weight = input('���������� >> ');
        end
    end
end