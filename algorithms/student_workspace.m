function [public_vars] = student_workspace(read_only_vars,public_vars)
%STUDENT_WORKSPACE Summary of this function goes here

gnss_count = 100;
gnss_tmp = gnss_count + 1;
gnss_ok = ~any(isnan(read_only_vars.gnss_position));

if read_only_vars.counter == 1
    public_vars.get_target_index = 1;
    if gnss_ok == false
        public_vars = init_particle_filter(read_only_vars, public_vars);
        public_vars.pf_initialized = false;
    else
        public_vars.pf_initialized = false;
    end
    public_vars.path_planned = false;
    public_vars.plan_motion = false;
    

elseif read_only_vars.counter < gnss_tmp && gnss_ok == true
    public_vars.motion_vector = [0, 0];

elseif read_only_vars.counter == gnss_tmp && gnss_ok == true
    gnss  = read_only_vars.gnss_history - mean(read_only_vars.gnss_history);
    public_vars.gnss_sigma = std(gnss);
    public_vars.gnss_covariance = cov(gnss);
    public_vars = init_kalman_filter(read_only_vars, public_vars);    

else
    if gnss_ok
       public_vars = update_kalman_filter(read_only_vars, public_vars);
       public_vars.estimated_pose = estimate_pose(public_vars, "kf");
       public_vars.plan_motion = true;
        
    else
        if public_vars.pf_initialized == false
            public_vars = init_particle_filter(read_only_vars, public_vars);
            public_vars.pf_initialized = true;
        end
        public_vars = update_particle_filter(read_only_vars, public_vars);
        public_vars.estimated_pose = estimate_pose(public_vars, "pf");

        if public_vars.pf.sigma > 0.01
            public_vars = simple_lidar_control(read_only_vars, public_vars);  
            public_vars.plan_motion = true;
        end
    end
end

if public_vars.plan_motion == true
    public_vars = plan_motion(read_only_vars, public_vars);

    if public_vars.path_planned == false
        public_vars.path = plan_path(read_only_vars, public_vars);
        public_vars.path_planned = true;
    end
end
    


 

end