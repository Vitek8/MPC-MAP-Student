function [public_vars] = student_workspace(read_only_vars,public_vars)
%STUDENT_WORKSPACE Summary of this function goes here

% 8. Perform initialization procedure
if (read_only_vars.counter == 1)
          
    public_vars = init_particle_filter(read_only_vars, public_vars);
    % public_vars = init_kalman_filter(read_only_vars, public_vars);

end

gnss_count = 100;
gnss_tmp = gnss_count + 1;

if read_only_vars.counter < gnss_tmp

    public_vars.gnss_data(read_only_vars.counter, :) = read_only_vars.gnss_position;

elseif read_only_vars.counter == gnss_tmp

    gnss  = public_vars.gnss_data  - mean(public_vars.gnss_data);
    public_vars.gnss_sigma = std(gnss);
    public_vars.gnss_covariance = cov(gnss);
    public_vars = init_kalman_filter(read_only_vars, public_vars);

elseif read_only_vars.counter < gnss_tmp * 4
    public_vars.motion_vector = [0.4, 0.4];
else
    public_vars.motion_vector = [0, 0];
end
% 9. Update particle filter
public_vars.particles = update_particle_filter(read_only_vars, public_vars);

% 10. Update Kalman filter
if read_only_vars.counter > gnss_tmp
    [public_vars.mu, public_vars.sigma, public_vars] = update_kalman_filter(read_only_vars, public_vars);
end
% 11. Estimate current robot position
public_vars.estimated_pose = estimate_pose(public_vars); % (x,y,theta)

% 12. Path planning
% public_vars.path = plan_path(read_only_vars, public_vars);

% 13. Plan next motion command
% public_vars = plan_motion(read_only_vars, public_vars);


end