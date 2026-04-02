function [public_vars] = student_workspace(read_only_vars,public_vars)
%STUDENT_WORKSPACE Summary of this function goes here


run('setup.m')


start_pos_x = start_position(1);
start_pos_y = start_position(2);
goal_pos_x = 25;
goal_pos_y = 10;

n = 100;
x = linspace(start_pos_x, goal_pos_x, n);
y = linspace(start_pos_y, goal_pos_y, n);

freq = 0.05;
sine_amplitude = 5;
sine_count = 1;

t = start_pos_x + linspace(0, sine_count / freq, 100000)';
sine_y = start_pos_y + sine_amplitude * sin(2 * pi * freq * (t - start_pos_x));

circular_arc_angles = linspace(pi, 0, 1000);
radius = pi * freq * sine_count;
circular_arc_x = start_pos_x + radius + radius * cos(circular_arc_angles)';
circular_arc_y = start_pos_y + radius * sin(circular_arc_angles)';

straight_line = [x' y'];
circular_arc = [circular_arc_x circular_arc_y];
sine_wave = [t sine_y];

public_vars.path = sine_wave;

calculated_start_x = goal_pos_x - 1/freq * sine_count;
calculated_start_y = goal_pos_y;
fprintf("Nastav počátek na: [%f %f]\n", calculated_start_x, calculated_start_y);

% 8. Perform initialization procedure
if (read_only_vars.counter == 1)
          
    public_vars = init_particle_filter(read_only_vars, public_vars);
    public_vars = init_kalman_filter(read_only_vars, public_vars);

end

% 9. Update particle filter
public_vars.particles = update_particle_filter(read_only_vars, public_vars);

% 10. Update Kalman filter
[public_vars.mu, public_vars.sigma] = update_kalman_filter(read_only_vars, public_vars);

% 11. Estimate current robot position
public_vars.estimated_pose = estimate_pose(public_vars); % (x,y,theta)

% 12. Path planning
public_vars.path = plan_path(read_only_vars, public_vars);

% 13. Plan next motion command
public_vars = plan_motion(read_only_vars, public_vars);



end
