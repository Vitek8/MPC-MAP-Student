function public_vars = simple_lidar_control(read_only_vars, public_vars)
lidar = read_only_vars.lidar_distances;
wheel_distance = read_only_vars.agent_drive.interwheel_dist;

lidar_front = lidar(1);
right_lidar = mean(lidar(7:8));
left_lidar  = mean(lidar(2:3));

d_safe = 1;
k_turn = 0.2;
v_max  = 0.3;

error = left_lidar - right_lidar;
omega = k_turn * error;

if lidar_front < d_safe
    v = 0;
    omega = 0.2;
else
    v = v_max;
end

v_left = v - (omega * wheel_distance)/ 2;
v_right = v + (omega * wheel_distance) / 2;

public_vars.motion_vector = [v_right, v_left]; 

end