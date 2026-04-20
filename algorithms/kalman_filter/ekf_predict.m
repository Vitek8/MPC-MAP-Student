function [new_mu, new_sigma] = ekf_predict(mu, sigma, u, kf, sampling_period)
%EKF_PREDICT Summary of this function goes here
x = mu(1);
y = mu(2);
theta = mu(3);

v = u(1);
omega = u(2);

dt = sampling_period;

R = kf.R;

G = [
    1, 0, -v*sin(theta)*dt;
    0, 1,  v*cos(theta)*dt;
    0, 0,  1
];

new_mu = [
    x + v*cos(theta)*dt;
    y + v*sin(theta)*dt;
    theta + omega*dt
];

new_sigma = G * sigma * G' + R;

end

