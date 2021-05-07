% % ���������ʽ
% format rat
% ����ǰ������
clear ,clc;
% ��η�����
disp("������һ������");
ori_mat=input('ori_mat = ');
% ����������
% ��������ľ���û�д���
errno = 0;
% 1 �Ƿ�Ϊ����
[row ,col]=size(ori_mat);
if row ~= col
    errno = 1;
end

% 2 ����������Ƿ��и����������
if errno == 0 % ����Ѿ��д�����־Ͳ��ٽ����ж�
    check_mat = ori_mat <= 0;
    no_zero_sum = sum(sum(check_mat));
    if no_zero_sum > 0
        errno = 2;
    end
end

% 3 ����������ľ����Ƿ�Ϊ����������
if errno == 0 % ����Ѿ��д�����־Ͳ��ٽ����ж�
    % aij*aji = 1
    check_mat = ori_mat .* ori_mat';
    result_mat = check_mat ~= ones(row,col);
    result = sum(result_mat(:)) ~= 0;
    if result ~= 0
        errno = 3;
    end
end

% 4 ������������Ƿ񳬹���15 --- ��Ϊ����Ҫ���� RI ���ж�
if errno == 0 % ����Ѿ��д�����־Ͳ��ٽ����ж�
    if col >= 15
        errno = 4;
    end
end

% 5 Ҫ�Ǿ���ֻ��һ��Ԫ�أ��ǽ���������
if errno == 0 % ����Ѿ��д�����־Ͳ��ٽ����ж�
   if row == 1
       errno = 5;
   end
end

% �Դ��������У��
if errno == 0 % ˵��������ľ�����Ϲ���
    flag = 1;% ���б�־λ������
    % �Ƚ���һ���Լ���
    RI=[0 0.00001 0.52 0.89 1.12 1.26 1.36 1.41 1.46 1.49 1.52 1.54 1.56 1.58 1.59];
    % ����һЩԭ�����԰�RI�ĵڶ���Ԫ�ظ�Ϊ��һ���ӽ���0���� --- ��ֹ��ĸΪ 0
    [V,D] = eig(ori_mat);
    % V --- ��������,
    % D --- ������ֵ���ɵĶԽǾ���
    max_eig = max(D(:));% �ҵ��������ֵ
    CI = (max_eig - row)/(row - 1);% ���һ����ָ��
    CR = CI/RI(row);% һ���Ա���
    disp(['һ����ָ�� CI = ',num2str(CI)]);
    disp(['һ���Ա��� CR = ',num2str(CR)]);
    if CR < 0.1
        disp('ͨ��һ���Լ���');
    else
        disp('δͨ��һ���Լ���,��Ҫ��һ�����жϾ�������޸ģ�')
        flag = 0;
    end
    
    if flag 
        % ���ַ�������Ȩ��
        
        % 1 ����ƽ������Ȩ��
        col_sum = sum(ori_mat);% ��ÿһ�еĺ�
        check_mat = repmat(col_sum,row,1);% �������к�Ϊ��չ���µľ���
        ari_result = sum((ori_mat./check_mat),2)/row;% ���й�һ������
        disp('����ƽ������Ȩ�صĽ��Ϊ��');
        disp(ari_result);
        
        % 2 ����ƽ������Ȩ��
        temp_mat = prod(ori_mat,2);% ����ÿһ��Ԫ�ص����
        check_mat = temp_mat.^(1/col);% �����õ�����ֵ���п�n�η�
        geo_result = check_mat ./ sum(check_mat);% ��һ������
        disp('����ƽ������Ȩ�صĽ��Ϊ��');
        disp(geo_result);
        
        % 3 ����ֵ����Ȩ��
        [Row ,Col] = find(D == max_eig ,1);% �ҵ��������ֵ���ڵ��к���
        eig_result = V(:,Col)./sum(V(:,Col));% ���й�һ������
        disp('����ֵ����Ȩ�صĽ��Ϊ��');
        disp(eig_result);
    end
else
    if errno == 1
        disp('������ľ����Ƿ���')
    elseif errno == 2
        disp('������ľ����г����˸���')
    elseif errno == 3
        disp('������ľ������������������Ҫ��')
    elseif errno == 4
        disp('������ľ�������������������15�����ַ����жϻ���ִ���')
    elseif errno == 5
        disp('������ľ�����ֻ��һ��Ԫ��')
    end
    
    disp('�������룡');
end
% % ��ԭĬ����ʾ��ʽ
% format short

        
        