close all;
clear;
clc;

start_pos_x = 3;
start_pos_y = 10;
goal_pos_x = 25;
goal_pos_y = 10;

freq = 0.10;
sine_amplitude = 5;
sine_count = 1;

t = start_pos_x + linspace(0, sine_count / freq, 100000)';
sine_y = start_pos_y + sine_amplitude * sin(2 * pi * freq * (t - start_pos_x));

figure
plot(t, sine_y)



