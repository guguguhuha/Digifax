function [weight] = ent_met_weight(stand_mat,forward_mat)
    [row, col] = size(stand_mat);
    check_minuz_mat = stand_mat < 0;% ��׼�������ܳ��ָ���
    if sum(check_minuz_mat(:)) > 0 % ������ָ����������¶�X���б�׼���Ĺ���
        for i = 1:row
            for j = 1:col
                stand_mat(i,j) = (forward_mat(i,j) - min(forward_mat(:,j))) / (max(forward_mat(:,j)) - min(forward_mat(:,j)));
            end
        end
    end
    temp_mat = zeros(1,col);  % ��ʼ��������ϢЧ��ֵ��������
    for j = 1:col
        row_target = stand_mat(:,j);  % ȡ����i�е�ָ��
        pro_mat = row_target / sum(row_target);
        ln_pro_mat = zeros(row,1); % ȥ�����Ӱ��
        for i = 1:row
           if pro_mat(i) == 0
               ln_pro_mat(i) = 0;
           else
               ln_pro_mat(i) = log(pro_mat(i));
           end
        end
        entropy_mat = -(sum(pro_mat.*ln_pro_mat)) / log(row);
        temp_mat(j) = 1 - entropy_mat; % ������ϢЧ��ֵ
    end
    weight = temp_mat ./ sum(temp_mat);  % ����ϢЧ��ֵ��һ�����õ�Ȩ��    
end