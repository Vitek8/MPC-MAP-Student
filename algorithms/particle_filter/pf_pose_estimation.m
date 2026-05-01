function [mu, sigma] = pf_pose_estimation(particles)
radius = 0.5;
best_count = 0;
best_idx = 1;
N = size(particles,1);

particle_x = particles(:, 1) - mean(particles(:, 1));
particle_y = particles(:, 2) - mean(particles(:, 2));

for i = 1:N
    dx = particles(:,1) - particles(i,1);
    dy = particles(:,2) - particles(i,2);
    dist = sqrt(dx.^2 + dy.^2);

    count = sum(dist < radius);

    if count > best_count
        best_count = count;
        best_idx = i;
    end
end

dx = particles(:,1) - particles(best_idx,1);
dy = particles(:,2) - particles(best_idx,2);
dist = sqrt(dx.^2 + dy.^2);

cluster_idx = dist < radius;

cluster = particles(cluster_idx,:);

x_est = mean(cluster(:,1));
y_est = mean(cluster(:,2));
theta_est = atan2(mean(sin(cluster(:,3))), mean(cos(cluster(:,3))));

var_x = mean((cluster(:,1) - x_est).^2);
var_y = mean((cluster(:,2) - y_est).^2);


var_all_x = std(particle_x);
var_all_y = std(particle_y);

mu = [x_est, y_est, theta_est];
sigma =  var_all_x + var_all_y;


end

