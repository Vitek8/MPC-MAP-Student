function new_nodes = check_neighbours(index, map)

neighbors = [
    0 1;
    1 0;
    0 -1;
    -1 0;
    1 1;
    -1 -1;
    1 -1;
    -1 1;
];

new_nodes = [];

for i = 1:size(neighbors,1)

    nx = index(1) + neighbors(i,1);
    ny = index(2) + neighbors(i,2);

    if nx < 1 || ny < 1 || nx > size(map,1) || ny > size(map,2)
        continue;
    end

    if map(nx, ny) == 1
        continue;
    end

    % corner fix
    if abs(neighbors(i,1)) == 1 && abs(neighbors(i,2)) == 1
        if map(index(1), ny) == 1 || map(nx, index(2)) == 1
            continue;
        end
    end

    new_nodes = [new_nodes; nx ny];
end

end