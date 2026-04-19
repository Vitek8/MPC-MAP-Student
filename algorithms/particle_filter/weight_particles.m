function [weights] = weight_particles(particle_measurements, lidar_distances)
N = size(particle_measurements, 1);
weights = zeros(N,1);

sigma = 3;

for i = 1:N
    
    error = particle_measurements(i,:) - lidar_distances;
    p = norm_pdf(error, 0, sigma);
    log_weight = sum(log(p));
    weights(i) = log_weight;

end

max_w = max(weights);
weights = exp(weights - max_w);

weights = weights / sum(weights);


end