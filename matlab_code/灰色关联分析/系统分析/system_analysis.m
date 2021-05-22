% 清屏
clear,clc;
% 导入数据
data_flag = input('请将数据导入为analy_data，若已导入请输入 1 >> ');
if data_flag == 1
    load analy_data.mat;
    average_data = mean(analy_data);
    stand_data = analy_data ./ average_data;
%     stand_data2 = analy_data ./
%     repmat(average_data,size(analy_data,1),1); % 与上句效果其实相同
    x0 = stand_data(:,1);
    x = stand_data(:,2:end);
    diference_of_x_xi = abs(x - x0);
%     diference_of_x_xi2 = abs(x - repmat(x0,1,size(x0,2))); % % 与上句效果其实相同
    max_val = max(diference_of_x_xi(:));
    min_val = min(diference_of_x_xi(:));
    rho = 0.5;
    grey_analy = (min_val + rho .* max_val) ./ (diference_of_x_xi + rho .* max_val);
    grey_analy_result = mean(grey_analy);
    disp('结果为: ');
    disp(grey_analy_result);
end