function [new_pose] = predict_pose(old_pose, motion_vector, read_only_vars)
%PREDICT_POSE Summary of this function goes here

sigma = 1;

motion_vector = motion_vector + motion_vector .* (sigma * randn(2,1));
wheel_distance = read_only_vars.agent_drive.interwheel_dist;
dt = read_only_vars.sampling_period;

v = (motion_vector(1) + motion_vector(2)) / 2;
omega = (motion_vector(1) - motion_vector(2)) / wheel_distance;

x = old_pose(1);
y = old_pose(2);
theta = old_pose(3);

new_x = x + v * cos(theta) * dt;
new_y = y + v * sin(theta) * dt;
new_theta = theta + omega * dt;

new_theta = atan2(sin(new_theta), cos(new_theta));
new_pose = [new_x, new_y, new_theta];

end
