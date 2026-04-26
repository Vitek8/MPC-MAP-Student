map_step = 0.2;
map = zeros(6, 6);
map(1:4, 4) = 1;
map_step = 0.2;

start = [0, 0];
start_index = round(1 + start/map_step);

g = inf(size(map));
g(start_index(1), start_index(2)) = 0;
goal = [1, 1];
goal_index = round(1 + goal/map_step);

visited = false(size(map));

[g, new_nodes] = check_neighbours(g, start_index, map, visited);
next_node = start_index;
path(1, :) = start_index;
counter = 2;
while any(next_node ~= goal_index)
    f_value = [];
    for i = 1:size(new_nodes,1)
        a = new_nodes(i, :);
        h_value = heuristic(a, goal_index);
        g_value = g(a(1), a(2));
        f_value(i) = h_value + g_value;
    end
   
    [~, index] = min(f_value);
    next_node = new_nodes(index,:);
    
    visited(next_node(1), next_node(2)) = true;
    path(counter, :) = next_node;
    counter = counter + 1;
    [g, new_nodes] = check_neighbours(g, next_node, map, visited);
    
end

