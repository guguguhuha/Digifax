% stand_mat --- ��׼����ľ���
% forward_mat --- ���򻯺�ľ���
function [result_weight] = weight(stand_mat,forward_mat)
    choice = input('��������Ҫ���Ȩ�صķ�����1.��η����� 2.��Ȩ�� 3.�û��������� >> ');
    while 1
        if choice >= 1 && choice <= 3
            break;
        else
            choice = input('���������� >> ');
        end
    end
    if choice == 1 % ��η�����
        result_weight = AHP_weight;  
    elseif choice == 2 % ��Ȩ��
        result_weight = ent_met_weight(stand_mat,forward_mat);  
    elseif choice == 3 % �û���������
        result_weight = user_enter_weight(stand_mat);
    end
end 