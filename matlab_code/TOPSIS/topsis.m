clear, clc;
disp('ʹ��ǰ�뽫���ݴ��浽init_data.mat�ļ��У��������ڵ�ǰ�ļ�����');
choice = input('��������� 1 ����ʾ����� >> ');
if choice == 1
    load init_data.mat
    [row,col] = size(init_data);
    disp(['������������ݹ���',num2str(row),'�����ݣ�����',num2str(col),'������ָ��']);
    dispose_choice = input('�Ƿ���Ҫ���򻯴��� 1.�� 0.�� ');
    if dispose_choice == 1
        dispose_col = input('������Ҫ�����ļ��� >> ');
        dispose_type = input('��������ѡ�� 1.��С�� 2.�м��� 3.������ >> ');
        for i = 1:size(dispose_col,2)
            change_col_num = dispose_col(i);
            change_col_type = dispose_type(i);
            change_col_val = init_data(:,change_col_num);
            init_data(:,change_col_num) = forward_change(change_col_val, change_col_type);
        end
    end
    forward_mat = init_data;
    disp('���򻯾���');
    disp(forward_mat);
    temp_mat = sum(forward_mat.*forward_mat).^0.5;
    mod_mat = repmat(temp_mat,row,1);
    stand_mat = forward_mat ./ mod_mat;
    disp('��׼������');
    disp(stand_mat);
    data_weight = ones(1,col);
    weight_choice = input('�Ƿ�Ҫ����Ȩ�صļ��� 1.�� 2.�� ');
    if weight_choice == 1
        data_weight = weight(stand_mat, forward_mat);
    end
    disp(data_weight);
    D_max = sum((stand_mat - repmat(max(stand_mat),row,1)).^2 .*repmat(data_weight,row, 1), 2).^0.5;
    D_min = sum((stand_mat - repmat(min(stand_mat),row,1)).^2 .*repmat(data_weight,row, 1), 2).^0.5;
    grade = D_min./(D_max+D_min);
    stand_grade = grade/sum(grade);
    disp('���յ÷֣�');
    disp(stand_grade);
    [gra_val,gra_index] = sort(stand_grade);

end
