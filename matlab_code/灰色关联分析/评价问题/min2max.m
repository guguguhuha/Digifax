function [new_val] = min2max(val)
    max_val = max(val);
    new_val = max_val - val;
end