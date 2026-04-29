function [path] = astar(read_only_vars, public_vars, map)
map = map';
map_step = read_only_vars.map.discretization_step;

start = [2, 2];                     
goal  = read_only_vars.map.goal;   

start_idx = floor(start / map_step) + 1; 
goal_idx  = floor(goal  / map_step) + 1;

g = inf(size(map));
g(start_idx(1), start_idx(2)) = 0;

visited = false(size(map));
parent = zeros([size(map), 2]);

open_list = start_idx;

while ~isempty(open_list)

    f_values = zeros(size(open_list,1),1);
    for i = 1:size(open_list,1)
        n = open_list(i,:);
        f_values(i) = g(n(1), n(2)) + heuristic(n, goal_idx);
    end

    [~, idx] = min(f_values);
    current = open_list(idx,:);
    open_list(idx,:) = [];

    if isequal(current, goal_idx)
        break;
    end

    visited(current(1), current(2)) = true;

    neighbours = check_neighbours(current, map);

    for i = 1:size(neighbours,1)
        n = neighbours(i,:);

        if visited(n(1), n(2))
            continue;
        end

        tentative_g = g(current(1), current(2)) + cost(current, n);

        if tentative_g < g(n(1), n(2))
            g(n(1), n(2)) = tentative_g;
            parent(n(1), n(2), :) = current;

            if ~ismember(n, open_list, 'rows')
                open_list = [open_list; n];
            end
        end
    end
end

path = goal_idx;
current = goal_idx;

while ~isequal(current, start_idx)
    p = squeeze(parent(current(1), current(2), :))';
    current = p;
    path = [current; path];
end

path = (path - 1) * map_step;

end

