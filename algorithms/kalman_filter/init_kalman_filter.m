function [public_vars] = init_kalman_filter(read_only_vars, public_vars)
%INIT_KALMAN_FILTER Summary of this function goes here

% n - state vector - 3x1
% k - measurement vector - 2x1

% measurement model - k * n - 2x3
public_vars.kf.C = [1 0 0;
                    0 1 0];

% process noise R - n * n - 3x3
public_vars.kf.R = diag([
    0.0001
    0.0001
    0.0001
]);

% measurement noise Q - k * k - 2x2
public_vars.kf.Q = diag([
    public_vars.gnss_sigma(1)^2
    public_vars.gnss_sigma(2)^2
]);

z0 = read_only_vars.gnss_position();
public_vars.mu = [z0, 0];
public_vars.sigma = diag([1, 1, pi^2]);

end

