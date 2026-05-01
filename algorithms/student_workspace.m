function [public_vars] = student_workspace(read_only_vars,public_vars)
%STUDENT_WORKSPACE Summary of this function goes here

gnss_lost = false;
gnss_ok = ~any(isnan(read_only_vars.gnss_position));

%% --- INIT ---
if read_only_vars.counter == 1
    public_vars.pf_enabled = false;
    public_vars.kf_enabled = false;

    public_vars.pf_initialized = false;
    public_vars.kf_initialized = false;

    public_vars.get_target_index = 1;
    if ~gnss_ok
        public_vars = init_particle_filter(read_only_vars, public_vars);
        public_vars.pf_initialized = true;
    end
    public_vars.plan_path = true;
    public_vars.plan_motion = false;
    
    public_vars.prev_gnss_ok = false;
    
    public_vars.gnns_counter = 1;
    public_vars.map_conv_radius = 3;
end

%% --- INIT KF ---
if all(~isnan(read_only_vars.gnss_position))
    public_vars.gnss_history( public_vars.gnns_counter, :) = read_only_vars.gnss_position;
    public_vars.gnns_counter = public_vars.gnns_counter + 1;
end

if gnss_ok && size(public_vars.gnss_history, 1) <= 100
    public_vars.motion_vector = [0, 0];
    public_vars.plan_motion = false;
    public_vars = init_kalman_filter(read_only_vars, public_vars); 
    if  public_vars.pf_initialized
        public_vars.kf.mu = public_vars.estimated_pose;
        public_vars.kf.sigma = diag([0.1, 0.1, 5*pi/180]);
    end
end

%% --- HLAVNÍ LOOP ---
if public_vars.pf_initialized || public_vars.kf_initialized

    gnss_lost = gnss_ok == 0 && public_vars.prev_gnss_ok == 1;

    if gnss_lost
        public_vars.path_planned = false;
        public_vars.plan_motion = false;
        public_vars = init_pf_around_pose(public_vars, public_vars.estimated_pose);
    end

    public_vars.prev_gnss_ok = gnss_ok;

    if gnss_ok && public_vars.kf_initialized
       public_vars.pf_enabled = 0;
       public_vars.kf_enabled = 1;
       public_vars = update_kalman_filter(read_only_vars, public_vars);
       public_vars.estimated_pose = estimate_pose(public_vars);
       public_vars.last_known_position = public_vars.estimated_pose;
       public_vars.plan_motion = true; 
    
    elseif ~gnss_ok
        public_vars.pf_enabled = 1;
        public_vars.kf_enabled = 0;
        public_vars = update_particle_filter(read_only_vars, public_vars);
        public_vars.estimated_pose = estimate_pose(public_vars); 
        public_vars.kf.mu = public_vars.estimated_pose;
        public_vars.kf.sigma = diag([0.1, 0.1, 5*pi/180]);

        if public_vars.pf.sigma < 0.5
            public_vars.plan_motion = true;
        else
            public_vars = simple_lidar_control(read_only_vars, public_vars);      
        end
        
    end

end

if public_vars.plan_motion
    public_vars = plan_motion(read_only_vars, public_vars);

    if public_vars.plan_path
        public_vars.path = plan_path(read_only_vars, public_vars);
        public_vars.plan_path = false;
    end
end
end