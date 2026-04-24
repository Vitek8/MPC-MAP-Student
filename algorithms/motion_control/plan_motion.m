function [public_vars] = plan_motion(read_only_vars, public_vars)
%PLAN_MOTION Summary of this function goes here

% I. Pick navigation target
lookahead = 0.5;
est_pos = read_only_vars.mocap_pose;
[target, public_vars] = get_target(est_pos, public_vars.path, lookahead, public_vars);
% plot(target(1), target(2), 'bo', 'MarkerSize',8, 'MarkerFaceColor','b')
if size(target) > 0
    public_vars.motion_vector = [0, 0];
    
    % II. Compute motion vector
    Kp = 5; 
    wheel_distance = read_only_vars.agent_drive.interwheel_dist;
    
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
    
    v_max = read_only_vars.agent_drive.max_vel;
    v_min = -read_only_vars.agent_drive.max_vel;

    omega_rad = deg2rad(angle_error);
    omega_setpoint = Kp * omega_rad;
    v = sqrt(dx^2 + dy^2);
    v = max(min(v,  v_max), v_min);
    
    v_left = v - (omega_setpoint * wheel_distance)/ 2;
    v_right = v + (omega_setpoint * wheel_distance) / 2;

    public_vars.motion_vector = [v_right, v_left];
end
end