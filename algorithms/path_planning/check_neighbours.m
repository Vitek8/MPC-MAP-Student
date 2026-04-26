function [new_g, new_nodes] = check_neighbours(g, index, map, visited)
    new_g = g;

    neighbors = [
        0 1;
        1 0;
        0 -1;
        -1 0;
    ];
    new_nodes = [];
    count = 1;
    for i = 1:size(neighbors,1)

        ny = index(1) + neighbors(i,1);
        nx = index(2) + neighbors(i,2);
        
        if ny < 1 || nx < 1 || ny > size(g,1) || nx > size(g,2)
            continue;
        end

        if map(ny,nx) == 1
            continue;
        end

        if visited(ny,nx)
            continue;
        end
        
        new_g(ny,nx) = g(index(1), index(2)) + 1;
        new_nodes(count, :) = [ny, nx]; 
        count = count + 1;
    end
end