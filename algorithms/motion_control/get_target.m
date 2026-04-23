function [target, index] = get_target(estimated_pose, path, lookahead, last_index)
%GET_TARGET Summary of this function goes here
est_pos = estimated_pose(1:2);
if size(path, 1) > 0 
    target = path(end,:);
    for i = last_index:length(path)
    
        d = norm(path(i,:) - est_pos);
    
        if d > lookahead
            target = path(i,:);
            index = i;
            return;
        end
    
    end
else
    target = [];
end
end

