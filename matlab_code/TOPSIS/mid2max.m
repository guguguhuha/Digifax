function [new_val] = mid2max(val)
    mid_val = input('�������м�ֵ >> ');
    max_val = max(abs(val - mid_val));
    new_val = 1 - abs(val - mid_val)/max_val;
end