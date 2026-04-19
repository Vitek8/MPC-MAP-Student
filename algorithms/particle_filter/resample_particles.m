function [new_particles] = resample_particles(particles, weights)

N = size(particles,1);
new_particles = zeros(size(particles));
cdf = cumsum(weights);

for i = 1:N
    
   r = rand(); 
   idx = sum(cdf < r) + 1; 
   new_particles(i,:) = particles(idx,:);

end

end