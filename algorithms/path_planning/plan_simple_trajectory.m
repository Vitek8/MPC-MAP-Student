function [straight_line,sine_wave,circular_arc,combined] = plan_simple_trajectory(read_only_vars, public_vars)
%PLAN_SIMPLE_TRAJECTORY sine_wave
%   undefined
arguments (Input)
    read_only_vars
    public_vars
end

arguments (Output)
    straight_line
    sine_wave
    circular_arc
    combined
end
    run('setup.m')
    
    goal_position = 0.2 * (read_only_vars.discrete_map.goal - 1);
    
    n = 100;
    x = linspace(start_position(1), goal_position(1), n);
    y = linspace(start_position(2), goal_position(2), n);
    
    freq = 0.05;
    sine_amplitude = 1;
    sine_count = 10;
    
    t = start_position(1) + linspace(0, sine_count / freq, 100000)';
    sine_y = start_position(2) + sine_amplitude * sin(2 * pi * freq * (t - start_position(1)));
    
    circular_arc_angles = linspace(pi, 0, 1000);
    radius = 1/(2*freq);
    circular_arc_x = start_position(1) + radius + radius * cos(circular_arc_angles)';
    circular_arc_y = start_position(2) + radius * sin(circular_arc_angles)';

    % COMBINED TRAJECTORY

    n1 = 70; 
    n2 = 30;  
    
    x1 = linspace(start_position(1), 7.5, n1);
    y1 = linspace(start_position(2), 14, n1);
    
    freq = 1;
    amp = 2;
    
    x2 = linspace(x1(end), goal_position(1) + 0.2, n2);
    y2_base = linspace(y1(end), goal_position(2), n2);
    y2 = y2_base + amp * sin(2*pi*freq*linspace(0,1,n2));

    % function return 
    straight_line = [x' y'];
    circular_arc = [circular_arc_x circular_arc_y];
    sine_wave = [t sine_y];
    combined = [ [x1' y1']; [x2' y2'] ];
end
