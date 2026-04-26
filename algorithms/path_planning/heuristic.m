function h = heuristic(a, b)
% Calculate the distance between two points using Euclidean distance

dx = a(1) - b(1);
dy = a(2) - b(2);

h = sqrt(dx^2 + dy^2);

end

