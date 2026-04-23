function [public_vars] = plan_motion(read_only_vars, public_vars)
%PLAN_MOTION Summary of this function goes here

% I. Pick navigation target
lookahead = 0.5;
target = get_target(read_only_vars.mocap_pose, public_vars.path, lookahead);
if size(target) > 0
    public_vars.motion_vector = [0, 0];
    
    % II. Compute motion vector
    Kp = 5; 
    wheel_distance = read_only_vars.agent_drive.interwheel_dist;
    
    est_pos = read_only_vars.mocap_pose;
    
    x = est_pos(1);
    y = est_pos(2);
    dx = target(1) - x;
    dy = target(2) - y;
    
    theta = (rad2deg(wrapToPi(est_pos(3))));
    target_angle = rad2deg(atan2(dy, dx));
    
    angle_error = target_angle - theta;
    
    if abs(angle_error) < 5
        angle_error = 0;
    end
    
    omega_rad = deg2rad(angle_error);
    omega_setpoint = Kp * omega_rad;
    v = sqrt(dx^2 + dy^2);
    
    v_left = v - (omega_setpoint * wheel_distance)/ 2;
    v_right = v + (omega_setpoint * wheel_distance) / 2;
    public_vars.motion_vector = [v_right, v_left];
end
end