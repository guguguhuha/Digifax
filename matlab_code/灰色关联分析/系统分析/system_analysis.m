% ����
clear,clc;
% ��������
data_flag = input('�뽫���ݵ���Ϊanaly_data�����ѵ��������� 1 >> ');
if data_flag == 1
    load analy_data.mat;
    average_data = mean(analy_data);
    stand_data = analy_data ./ average_data;
%     stand_data2 = analy_data ./
%     repmat(average_data,size(analy_data,1),1); % ���Ͼ�Ч����ʵ��ͬ
    x0 = stand_data(:,1);
    x = stand_data(:,2:end);
    diference_of_x_xi = abs(x - x0);
%     diference_of_x_xi2 = abs(x - repmat(x0,1,size(x0,2))); % % ���Ͼ�Ч����ʵ��ͬ
    max_val = max(diference_of_x_xi(:));
    min_val = min(diference_of_x_xi(:));
    rho = 0.5;
    grey_analy = (min_val + rho .* max_val) ./ (diference_of_x_xi + rho .* max_val);
    grey_analy_result = mean(grey_analy);
    disp('���Ϊ: ');
    disp(grey_analy_result);
end