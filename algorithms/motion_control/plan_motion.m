function [public_vars] = plan_motion(read_only_vars, public_vars)
%PLAN_MOTION Summary of this function goes here

% I. Pick navigation target
lookahead = 2;
target = get_target(read_only_vars.mocap_pose, public_vars.path, lookahead);
plot(target(1), target(2), 'bo', 'MarkerSize',8, 'MarkerFaceColor','b')
public_vars.motion_vector = [0, 0];



% II. Compute motion vector
dt = 0.05; % estimovaná (změřená) časová konstanta simulátoru
wheel_radius = 2;
wheel_distance = 0.8;
file = "algorithms\report\assignment_2\data\angle.mat";

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

omega = angle_error * dt;
omega_rad = deg2rad(omega);
v = sqrt(dx^2 + dy^2);


v_left = (2 * v - omega * wheel_distance)/(2 * wheel_radius);
v_right = (2 * v + omega * wheel_distance) / (2 * wheel_radius);
public_vars.motion_vector = [v_right, v_left];

%% DEBUG
% if exist(file, 'file')
%     load(file, 'arr_theta', 'arr_angle_error');
% else
%     arr_theta = [];
%     arr_angle_error = [];
% end
% 
% arr_theta(read_only_vars.counter) = theta;
% arr_angle_error(read_only_vars.counter) = angle_error;
% 
% 
% save(file, 'arr_theta', 'arr_angle_error');
% 
% fprintf("angle_est: %f, target_angle: %f, angle_error: %f\n", theta, target_angle, angle_error);
% 
% figure(public_vars.h2) 
% hold on
% plot(read_only_vars.counter,theta, 'ro')
% hold on 
% plot(read_only_vars.counter,angle_error, 'go')
% hold on
% plot(read_only_vars.counter,target_angle, 'bo')
% legend('', 'theta', 'angle error', 'target angle')
end