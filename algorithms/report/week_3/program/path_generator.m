close all;
clear;
clc;

load("../data/look_ahead_3.mat", 'arr_theta', 'arr_angle_error', 'arr_est_pos', 'arr_distance_error');
look_ahead_3 = arr_est_pos;
load("../data/look_ahead_1.mat", 'arr_theta', 'arr_angle_error', 'arr_est_pos', 'arr_distance_error');
look_ahead_1 = arr_est_pos;
goal_position = [25,10];
start_position = [5 10 0];

n = 100;
x = linspace(start_position(1), goal_position(1), n);
y = linspace(start_position(2), goal_position(2), n);

freq = 0.05;
sine_amplitude = 5;
sine_count = 1;

t = start_position(1) + linspace(0, sine_count / freq, 100000)';
sine_y = start_position(2) + sine_amplitude * sin(2 * pi * freq * (t - start_position(1)));

circular_arc_angles = linspace(pi, 0, 1000);
radius = 1/(2*freq);
circular_arc_x = start_position(1) + radius + radius * cos(circular_arc_angles)';
circular_arc_y = start_position(2) + radius * sin(circular_arc_angles)';

straight_line = [x' y'];
circular_arc = [circular_arc_x circular_arc_y];
sine_wave = [t sine_y];

figure;
hold on;
grid on;
axis equal;


plot(straight_line(:,1), straight_line(:,2), 'black-', 'LineWidth', 2);
plot(sine_wave(:,1), sine_wave(:,2), 'r-', 'LineWidth', 2);
plot(circular_arc(:,1), circular_arc(:,2), 'cyan-', 'LineWidth', 2);

[cx, cy] = create_circle(goal_position(1), goal_position(2), 0.5);
plot(cx, cy, 'Color','green', 'LineWidth',2);
[ax, ay] = create_arrow(start_position(1:2), start_position(3), 0.5);
h = plot(ax, ay, 'Color','blue', 'LineWidth',2);

xlabel('X [m]');
ylabel('Y [m]');

legend('Přímka', 'Sinus', 'Oblouk', 'Location','northeast');




xmin = 0;
xmax = 30;
ymin = 0;
ymax = 30;

axis([xmin xmax ymin ymax])

figure
plot(sine_wave(:,1), sine_wave(:,2), 'r-', 'LineWidth', 2);
hold on 
plot(look_ahead_3(1,:),look_ahead_3(2,:), 'b-', 'LineWidth', 2)
hold on 
plot(look_ahead_1(1,:),look_ahead_1(2,:), 'cyan-', 'LineWidth', 2)
[cx, cy] = create_circle(goal_position(1), goal_position(2), 0.5);
plot(cx, cy, 'Color','green', 'LineWidth',2);
[ax, ay] = create_arrow(start_position(1:2), start_position(3), 0.5);
h = plot(ax, ay, 'Color','blue', 'LineWidth',2);
xlabel('X [m]');
ylabel('Y [m]');

legend('Žádaná trajektorie','Skutečná trajektorie lookahead = 1', 'Skutečná trajektorie lookahead = 3', 'Location','northeast');

xmin = 4;
xmax = 26;
ymin = 4;
ymax = 16;

axis([xmin xmax ymin ymax])

figure
plot(arr_angle_error)
hold on
plot(arr_distance_error)