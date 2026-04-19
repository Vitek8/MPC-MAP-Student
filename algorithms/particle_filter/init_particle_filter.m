function [public_vars] = init_particle_filter(read_only_vars, public_vars)
%INIT_PARTICLE_FILTER Summary of this function goes here

N = 1000;
limits = read_only_vars.discrete_map.limits;

map_x1 = limits(1);
map_x2 = limits(3);
map_y1 = limits(2);
map_y2 = limits(4);

public_vars.particles(:, 1) = rand(N,1) * (map_x2 - map_x1) + map_x1;
public_vars.particles(:, 2) = rand(N,1) * (map_y2 - map_y1) + map_y1;
public_vars.particles(:, 3) = rand(N,1) * 2*pi;

end

