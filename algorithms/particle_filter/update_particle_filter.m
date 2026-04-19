function [particles] = update_particle_filter(read_only_vars, public_vars)
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

[~, index] = min(weights);
plot(particles(index,1), particles(index,2), 'go', 'LineWidth', 2);

% particle_pose = compute_lidar_measurement(read_only_vars.map, particles(index, :), read_only_vars.lidar_config)
% lidar_pose = read_only_vars.lidar_distances

% III. Resampling
particles = resample_particles(particles, weights);

end

