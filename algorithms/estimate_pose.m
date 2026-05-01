function [estimated_pose] = estimate_pose(public_vars)
if public_vars.kf_enabled
    estimated_pose = [public_vars.kf.mu(1), public_vars.kf.mu(2), public_vars.kf.mu(3)];
elseif  public_vars.pf_enabled
    estimated_pose = [public_vars.pf.mu(1), public_vars.pf.mu(2), public_vars.pf.mu(3)];
else
    estimated_pose = [];
end

end

