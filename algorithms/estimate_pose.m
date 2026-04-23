function [estimated_pose] = estimate_pose(public_vars)
%ESTIMATE_POSE Summary of this function goes here

estimated_pose = [public_vars.mu(1), public_vars.mu(2), public_vars.mu(3)];

end

