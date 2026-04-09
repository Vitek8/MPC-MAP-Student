function [new_pose] = predict_pose(old_pose, motion_vector, read_only_vars)
%PREDICT_POSE Summary of this function goes here

wheel_distance = 0.8;
Tvz = read_only_vars.sampling_period;

omega = 1 / wheel_distance * (motion_vector(1) - motion_vector(2));
v = (motion_vector(1) + motion_vector(2)) / 2;

new_pose = zeros(size(old_pose));
for i = 1:size(old_pose, 1)
    
    x = old_pose(i, 1);
    y = old_pose(i, 2);
    theta = old_pose(i, 3);

    new_x = x + v * cos(theta) * Tvz + randn * 0.1;
    new_y = y + v * sin(theta) * Tvz + randn * 0.1;
    new_theta = theta + omega * Tvz + randn * 0.05;

    new_pose(i, :) = [new_x new_y new_theta];
end
size(new_pose)

end

