function [estimated_pose] = estimate_pose(public_vars, algorithms)

if algorithms == "kf"
    estimated_pose = [public_vars.kf.mu(1), public_vars.kf.mu(2), public_vars.kf.mu(3)];
else 
    estimated_pose = [public_vars.pf.mu(1), public_vars.pf.mu(2), public_vars.pf.mu(3)];
end

end

