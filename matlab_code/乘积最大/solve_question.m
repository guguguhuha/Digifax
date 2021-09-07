num_list = [1 3 4 5 7];
x = 1:1:10000;
y = zeros(1,10000);
max_mul = 0;
max_x =0;
max_y = 0;
for i = x
    j = 3;
    a =zeros(1,3);
    while j
       append_element_index = randi([1,5],1,1);
       append_element = num_list(append_element_index);
       if ~sum(append_element == a)
           a(j) = append_element;
           j = j -1;
       end
    end
    x_x = make_num(a);
    b = zeros(1,2);
    k = 2;
    while k
        append_element_index = randi([1,5],1,1);
       append_element = num_list(append_element_index);
       if ~sum(append_element == a) && ~sum(append_element == b)
           b(k) = append_element;
           k = k -1;
       end
    end
    y_y = make_num(b);
    y(i) = x_x.*y_y;
    if  (x_x*y_y >  max_mul)
        max_mul = x_x*y_y;
        max_x = x_x;
        max_y = y_y;
    end
end
figure(1)
disp([max_mul max_x max_y]);
plot(x,y,'*');
title('Test');
ylabel('value');
xlabel('time');
saveas(gcf,'Result Test.jpg');

