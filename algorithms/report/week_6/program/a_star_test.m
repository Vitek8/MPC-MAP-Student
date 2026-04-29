% --- MAPA ---
map = read_only_vars.discrete_map.map;
map_step = 0.2;

start = [0.6, 0.2];
goal  = [0.4, 3];

start_index = round(1 + start/map_step);
goal_index  = round(1 + goal/map_step);

g = inf(size(map));
g(start_index(1), start_index(2)) = 0;

visited = false(size(map));

parent = zeros([size(map), 2]);

open_list = start_index;

while ~isempty(open_list)

    f_values = zeros(size(open_list,1),1);
    for i = 1:size(open_list,1)
        n = open_list(i,:);
        f_values(i) = g(n(1), n(2)) + heuristic(n, goal_index);
    end

    [~, idx] = min(f_values);
    current = open_list(idx,:);
    open_list(idx,:) = [];


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

path = goal_index;
current = goal_index;

while ~isequal(current, start_index)
    p = squeeze(parent(current(1), current(2), :))';
    current = p;
    path = [current; path];
end