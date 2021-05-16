% % 设置输出格式
% format rat
% 运行前先清屏
clear ,clc;
% 层次分析法
disp("请输入一个方阵：");
ori_mat=input('ori_mat = ');
% 检查输入情况
% 假设输入的矩阵没有错误
errno = 0;
% 1 是否为方阵
[row ,col]=size(ori_mat);
if row ~= col
    errno = 1;
end

% 2 检验矩阵中是否有负数或零出现
if errno == 0 % 如果已经有错误出现就不再进行判断
    check_mat = ori_mat <= 0;
    no_zero_sum = sum(sum(check_mat));
    if no_zero_sum > 0
        errno = 2;
    end
end

% 3 检验所输入的矩阵是否为正互反矩阵
if errno == 0 % 如果已经有错误出现就不再进行判断
    % aij*aji = 1
    check_mat = ori_mat .* ori_mat';
    result_mat = check_mat ~= ones(row,col);
    result = sum(result_mat(:)) ~= 0;
    if result ~= 0
        errno = 3;
    end
end

% 4 检验矩阵行数是否超过了15 --- 因为后续要进行 RI 的判断
if errno == 0 % 如果已经有错误出现就不再进行判断
    if col >= 15
        errno = 4;
    end
end

% 5 要是矩阵只有一个元素，那将毫无意义
if errno == 0 % 如果已经有错误出现就不再进行判断
   if row == 1
       errno = 5;
   end
end

% 对错误码进行校验
if errno == 0 % 说明所输入的矩阵符合规则
    flag = 1;% 进行标志位的设置
    % 先进行一致性检验
    RI=[0 0.00001 0.52 0.89 1.12 1.26 1.36 1.41 1.46 1.49 1.52 1.54 1.56 1.58 1.59];
    % 由于一些原因所以把RI的第二个元素改为了一个接近与0的数 --- 防止分母为 0
    [V,D] = eig(ori_mat);
    % V --- 特征向量,
    % D --- 由特征值构成的对角矩阵
    max_eig = max(D(:));% 找到最大特征值
    CI = (max_eig - row)/(row - 1);% 求出一致性指标
    CR = CI/RI(row);% 一致性比例
    disp(['一致性指标 CI = ',num2str(CI)]);
    disp(['一致性比例 CR = ',num2str(CR)]);
    if CR < 0.1
        disp('通过一致性检验');
    else
        disp('未通过一致性检验,需要对一致性判断矩阵进行修改！')
        flag = 0;
    end
    
    if flag 
        % 三种方法计算权重
        
        % 1 算数平均法求权重
        col_sum = sum(ori_mat);% 求每一列的和
        check_mat = repmat(col_sum,row,1);% 构造以列和为扩展的新的矩阵
        ari_result = sum((ori_mat./check_mat),2)/row;% 进行归一化处理
        disp('算术平均法求权重的结果为：');
        disp(ari_result);
        
        % 2 几何平均法求权重
        temp_mat = prod(ori_mat,2);% 进行每一行元素的相乘
        check_mat = temp_mat.^(1/col);% 对所得到的数值进行开n次方
        geo_result = check_mat ./ sum(check_mat);% 归一化处理
        disp('几何平均法求权重的结果为：');
        disp(geo_result);
        
        % 3 特征值法求权重
        [Row ,Col] = find(D == max_eig ,1);% 找到最大特征值所在的行和列
        eig_result = V(:,Col)./sum(V(:,Col));% 进行归一化处理
        disp('特征值法求权重的结果为：');
        disp(eig_result);
    end
else
    if errno == 1
        disp('所输入的矩阵不是方阵')
    elseif errno == 2
        disp('所输入的矩阵中出现了负数')
    elseif errno == 3
        disp('所输入的矩阵不满足正互反矩阵的要求')
    elseif errno == 4
        disp('所输入的矩阵行数及列数超过了15，此种方法判断会出现错误')
    elseif errno == 5
        disp('所输入的矩阵中只有一个元素')
    end
    
    disp('请检查输入！');
end
% % 还原默认显示格式
% format short

        
        