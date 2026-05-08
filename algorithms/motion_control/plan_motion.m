function [public_vars] = plan_motion(read_only_vars, public_vars)
%PLAN_MOTION Summary of this function goes here

% I. Pick navigation target
lookahead = 0.5;
est_pos = public_vars.estimated_pose;
[target, public_vars] = get_target(est_pos, public_vars.path, lookahead, public_vars);
if size(target) > 0
    % plot(target(1), target(2), 'bo', 'MarkerSize',8, 'MarkerFaceColor','b')
    public_vars.motion_vector = [0, 0];
    
    % II. Compute motion vector
    Kp = 5; 
    wheel_distance = read_only_vars.agent_drive.interwheel_dist;
    
    x = est_pos(1);
    y = est_pos(2);
    dx = target(1) - x;
    dy = target(2) - y;
    theta = est_pos(3);

    theta = wrap_correction(theta, public_vars.actual.prev_angle);
    public_vars.actual.prev_angle = theta;
       
    target_angle = atan2(dy, dx);   
    target_angle = wrap_correction(target_angle, public_vars.target.prev_angle);
    public_vars.target.prev_angle = target_angle;
    
    angle_error = target_angle - theta;
    
    v_max = read_only_vars.agent_drive.max_vel;
    v_min = -read_only_vars.agent_drive.max_vel;

    omega_rad = angle_error;
    omega_setpoint = Kp * omega_rad;
    v = sqrt(dx^2 + dy^2);
    v = max(min(v,  v_max), v_min);
    
    v_left = v - (omega_setpoint * wheel_distance)/ 2;
    v_left = max(min(v_left,  v_max), v_min);
    
    v_right = v + (omega_setpoint * wheel_distance) / 2;
    v_right = max(min(v_right,  v_max), v_min);

    public_vars.motion_vector = [v_right, v_left];
end
end