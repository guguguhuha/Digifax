function [new_val] = mid2max(val)
    mid_val = input('请输入中间值 >> ');
    max_val = max(abs(val - mid_val));
    new_val = 1 - abs(val - mid_val)/max_val;
end