function [new_col_val] = forward_change(val,type)
    if type == 1
        new_col_val = min2max(val);
    elseif type == 2
        new_col_val = mid2max(val);
    elseif type == 3
        new_col_val = section2max(val);
    end
end