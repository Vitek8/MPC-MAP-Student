function public_vars = simple_lidar_control(read_only_vars, public_vars)

lidar = read_only_vars.lidar_distances;
lidar(isinf(lidar)) = 20;
wheel_distance = read_only_vars.agent_drive.interwheel_dist;

front = lidar(1);
left  = mean(lidar(2:3));
right = mean(lidar(7:8));

v = 0.5;
k_turn = 0.6;
d_stop = 1;

error = left - right;
omega = k_turn * error;

if front < d_stop
    v = 0;
    omega = 0.5 * sign(error + 0.01);
end

v_left  = v - (omega * wheel_distance)/2;
v_right = v + (omega * wheel_distance)/2;

public_vars.motion_vector = [v_right, v_left];

end