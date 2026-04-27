function c = cost(a, b)
if abs(a(1)-b(1)) == 1 && abs(a(2)-b(2)) == 1
    c = 14;
else
    c = 10;
end
end