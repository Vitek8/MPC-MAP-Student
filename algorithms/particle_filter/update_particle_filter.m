function public_vars = update_particle_filter(read_only_vars, public_vars)
%UPDATE_PARTICLE_FILTER Summary of this function goes here
lidar = read_only_vars.lidar_distances;
lidar(isinf(lidar)) = 20;
particles = public_vars.particles;
N = size(particles,1);

% I. Prediction
for i=1:size(particles, 1)
    particles(i,:) = predict_pose(particles(i,:), public_vars.motion_vector, read_only_vars, public_vars.motion_sigma);
end

% II. Correction
measurements = zeros(size(particles,1), length(read_only_vars.lidar_config));
for i=1:size(particles, 1)
    measurements(i,:) = compute_lidar_measurement(read_only_vars.map, particles(i,:), read_only_vars.lidar_config);
end
public_vars.weights = weight_particles(measurements, lidar, public_vars.sensor_sigma);

% III. Resampling
Neff = 1 / sum(public_vars.weights.^2);
particles = resample_particles(particles, public_vars.weights);
if Neff < N/2
    particles(:,1) = particles(:,1) + 0.08 * randn(size(particles,1),1);
    particles(:,2) = particles(:,2) + 0.08 * randn(size(particles,1),1);
    particles(:,3) = particles(:,3) + 0.08 * randn(size(particles,1),1);
end

% IV. Pose estimation
[public_vars.pf.mu, public_vars.pf.sigma] = pf_pose_estimation(particles);
public_vars.particles = particles;

end

