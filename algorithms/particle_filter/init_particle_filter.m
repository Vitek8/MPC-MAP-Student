function public_vars = init_particle_filter(read_only_vars, public_vars)
N = 1000;
limits = read_only_vars.discrete_map.limits; 
map_x1 = min(limits(1));
map_x2 = max(limits(3));
map_y1 = min(limits(2));
map_y2 = max(limits(4));

public_vars.particles(:, 1) = rand(N,1) * (map_x2 - map_x1) + map_x1;
public_vars.particles(:, 2) = rand(N,1) * (map_y2 - map_y1) + map_y1;
public_vars.particles(:, 3) = rand(N,1) * 2*pi;
public_vars.weights = ones(N, 1) / N;

end

