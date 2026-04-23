function [public_vars] = student_workspace(read_only_vars,public_vars)
%STUDENT_WORKSPACE Summary of this function goes here

gnss_count = 100;
gnss_tmp = gnss_count + 1;

if read_only_vars.counter == 1

    public_vars.path = plan_path(read_only_vars, public_vars);
    public_vars.last_index = 10;


elseif read_only_vars.counter < gnss_tmp

    public_vars.motion_vector = [0, 0];

elseif read_only_vars.counter == gnss_tmp

    gnss  = read_only_vars.gnss_history - mean(read_only_vars.gnss_history);
    public_vars.gnss_sigma = std(gnss);
    public_vars.gnss_covariance = cov(gnss);
    public_vars = init_kalman_filter(read_only_vars, public_vars);

else

    [public_vars.mu, public_vars.sigma] = update_kalman_filter(read_only_vars, public_vars);
    public_vars.estimated_pose = estimate_pose(public_vars);
    [public_vars, public_vars.last_index] = plan_motion(read_only_vars, public_vars, public_vars.last_index);

end