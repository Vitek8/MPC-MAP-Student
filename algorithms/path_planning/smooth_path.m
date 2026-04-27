function [new_path] = smooth_path(old_path)
%SMOOTH_PATH Summary of this function goes here

new_path = old_path;

alpha = 0.25;   
beta  = 0.5;  
tolerance = 1e-4;


new_path = old_path;
change = inf;


while change > tolerance
    change = 0;

    for i = 2:size(old_path,1)-1

        old_point = new_path(i,:);

        new_path(i,:) = new_path(i,:) + ...
            alpha * (old_path(i,:) - new_path(i,:)) + ...
            beta  * (new_path(i-1,:) + new_path(i+1,:) - 2*new_path(i,:));

        change = change + norm(old_point - new_path(i,:));
    end
end

end

