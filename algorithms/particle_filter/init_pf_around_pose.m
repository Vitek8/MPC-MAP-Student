function public_vars = init_pf_around_pose(public_vars, pose)
N = 1000;
sigma_x = 0.5;
sigma_y = 0.5;
sigma_theta = 5*pi/180;

public_vars.particles(:,1) = pose(1) + sigma_x * randn(N,1);
public_vars.particles(:,2) = pose(2) + sigma_y * randn(N,1);
public_vars.particles(:,3) = pose(3) + sigma_theta * randn(N,1);
public_vars.particles(:,3) = atan2(sin(public_vars.particles(:,3)), cos(public_vars.particles(:,3)));
public_vars.weights = ones(N, 1) / N;

end