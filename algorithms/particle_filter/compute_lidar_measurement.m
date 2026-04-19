function [measurement] = compute_lidar_measurement(map, pose, lidar_config)
%COMPUTE_MEASUREMENTS Summary of this function goes here

measurement = zeros(1, length(lidar_config));
for i=1:length(lidar_config)
    phi = pose(3) + lidar_config(i);
    intersections = ray_cast(pose(1:2), map.walls, phi);
    if isempty(intersections)
        measurement(i) = 10;
    else
        distances = sqrt((intersections(:,1) - pose(1)).^2 + (intersections(:,2) - pose(2)).^2);
        measurement(i) = min(distances);
    end
end

end

