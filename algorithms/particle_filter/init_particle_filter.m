function [public_vars] = init_particle_filter(read_only_vars, public_vars)
%INIT_PARTICLE_FILTER Summary of this function goes here

N = 500;
limits = read_only_vars.discrete_map.limits;
map_width = limits(3);
map_height = limits(4);
particles_x = rand(N,1) * map_width;
particles_y = rand(N,1) * map_height;
particles_theta = rand(N,1) * 2*pi;
particles_w = ones(N,1) / N;
public_vars.particles = [particles_x, particles_y, particles_theta];

end

