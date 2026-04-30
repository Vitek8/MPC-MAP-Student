function public_vars = update_particle_filter(read_only_vars, public_vars)
%UPDATE_PARTICLE_FILTER Summary of this function goes here

particles = public_vars.particles;

% I. Prediction
for i=1:size(particles, 1)
    particles(i,:) = predict_pose(particles(i,:), public_vars.motion_vector, read_only_vars, public_vars.motion_sigma);
end

% II. Correction
measurements = zeros(size(particles,1), length(read_only_vars.lidar_config));
for i=1:size(particles, 1)
    measurements(i,:) = compute_lidar_measurement(read_only_vars.map, particles(i,:), read_only_vars.lidar_config);
end
weights = weight_particles(measurements, read_only_vars.lidar_distances, public_vars.sensor_sigma);

% III. Resampling
particles = resample_particles(particles, weights);

% IV. Pose estimation
x = particles(:, 1);
y = particles(:, 2);
theta = particles(:, 3);

x_est = mean(x);
y_est = mean(y);
theta_est = atan2(mean(sin(theta)), mean(cos(theta)));

var_x = mean((x - x_est).^2);
var_y = mean((y - y_est).^2);

public_vars.particles = particles;
public_vars.pf.mu = [x_est, y_est, theta_est];
public_vars.pf.sigma = [var_x, var_y];

end

