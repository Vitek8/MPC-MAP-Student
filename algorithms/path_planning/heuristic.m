function h = heuristic(a, goal)
dx = a(2) - goal(2);
dy = a(1) - goal(1);
h = sqrt(dx^2 + dy^2);
end