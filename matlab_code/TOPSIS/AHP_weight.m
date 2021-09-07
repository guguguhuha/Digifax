function [weight] = AHP_weight
    disp("������һ���жϾ���");
    while 1
        ori_mat=input('ori_mat = ');
        % ����������
        % ��������ľ���û�д���
        errno = 0;
        % 1 �Ƿ�Ϊ����
        [ahp_row ,ahp_col]=size(ori_mat);
        if ahp_row ~= ahp_col
            errno = 1;
        end

        % 2 ����������Ƿ��и����������
        if errno == 0 % ����Ѿ��д�����־Ͳ��ٽ����ж�
            check_mat = (ori_mat <= 0);
            no_zero_sum = sum(sum(check_mat));
            if no_zero_sum > 0
                errno = 2;
            end
        end

        % 3 ����������ľ����Ƿ�Ϊ����������
        if errno == 0 % ����Ѿ��д�����־Ͳ��ٽ����ж�
            % aij*aji = 1
            check_mat = ori_mat .* ori_mat';
            result_mat = check_mat ~= ones(ahp_row,ahp_col);
            result = sum(result_mat(:)) ~= 0;
            if result ~= 0
                errno = 3;
            end
        end

        % 4 ������������Ƿ񳬹���15 --- ��Ϊ����Ҫ���� RI ���ж�
        if errno == 0 % ����Ѿ��д�����־Ͳ��ٽ����ж�
            if ahp_col >= 15
                errno = 4;
            end
        end

        % 5 Ҫ�Ǿ���ֻ��һ��Ԫ�أ��ǽ���������
        if errno == 0 % ����Ѿ��д�����־Ͳ��ٽ����ж�
           if ahp_row == 1
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
            CI = (max_eig - ahp_row)/(ahp_row - 1);% ���һ����ָ��
            CR = CI/RI(ahp_row);% һ���Ա���
            disp(['һ����ָ�� CI = ',num2str(CI)]);
            disp(['һ���Ա��� CR = ',num2str(CR)]);
            if CR < 0.1
                disp('ͨ��һ���Լ���');
            else
                disp('δͨ��һ���Լ���,��Ҫ��һ�����жϾ�������޸ģ�')
                flag = 0;
            end
            if flag
                % 3 ����ֵ����Ȩ��
                [~ ,Col] = find(D == max_eig ,1);% �ҵ��������ֵ���ڵ��к���
                eig_result = V(:,Col)./sum(V(:,Col));% ���й�һ������
            break;
            end
        else
            if errno == 1
                disp('������ľ����Ƿ���')
            elseif errno == 2
                disp('������ľ����г����˸�������')
            elseif errno == 3
                disp('������ľ������������������Ҫ��')
            elseif errno == 4
                disp('������ľ�������������������15�����ַ����жϻ���ִ���')
            elseif errno == 5
                disp('������ľ�����ֻ��һ��Ԫ��')
            end
            disp('�������룡');
        end
    end
    weight = eig_result';
end


        
        