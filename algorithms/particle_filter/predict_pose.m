function [new_pose] = predict_pose(old_pose, motion_vector, read_only_vars)
%PREDICT_POSE Summary of this function goes here

Tvz = read_only_vars.sampling_period;
wheel_distance = 0.8;
new_pose = old_pose(1:2) + motion_vector * Tvz .* [cos(old_pose(3)) sin(old_pose(3))];
new_pose(3) = old_pose(3) + 1 / wheel_distance * (motion_vector(1) - motion_vector(2)) * Tvz;
end

