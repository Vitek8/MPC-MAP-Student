function [public_vars] = init_kalman_filter(read_only_vars, public_vars)
%INIT_KALMAN_FILTER Summary of this function goes here

% n - state vector - 3x1
% k - measurement vector - 2x1

% measurement model - k * n - 2x3
public_vars.kf.C = [1 0 0;
                    0 1 0];

% process noise R - n * n - 3x3
public_vars.kf.R = diag([
    0.01
    0.01
    0.01
]);

% measurement noise Q - k * k - 2x2
public_vars.kf.Q = diag([
    public_vars.gnss_sigma(1)^2
    public_vars.gnss_sigma(2)^2
]);

limits = read_only_vars.discrete_map.limits;

map_x1 = limits(1);
map_x2 = limits(3);
map_y1 = limits(2);
map_y2 = limits(4);

x = ((map_x2 - map_x1) + map_x1) / 2;
y = ((map_y2 - map_y1) + map_y1) / 2;
theta = rand() * 2*pi;

z0 = read_only_vars.gnss_position();

public_vars.mu = [z0, 0];
public_vars.sigma = diag([1, 1, pi^2]);

public_vars.mu_history = [];
public_vars.gt_history = [];

end

