function result = make_num(list)
    result = 0;
    for i = 1: size(list,2)
        result = result.*10+list(i);
    end
end