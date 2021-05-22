function [new_val] = section2max(val)
    len = size(val,1);
    new_val = zeros(len, 1);
    up_val = input('请输入上界 >> ');
    down_val = input('请输入下界 >> ');
    max_val = max([down_val-min(val),max(val)-up_val]);
    for i = 1 : len
        if val(i) < down_val
            new_val(i) = 1 - abs(down_val - val(i))/max_val;
        elseif val(i) > up_val
            new_val(i) = 1 - abs(up_val - val(i))/max_val;
        else
            new_val(i) = 1;
        end
    end
end