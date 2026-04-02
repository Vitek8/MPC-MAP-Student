function [target, public_vars] = get_target(estimated_pose, path, lookahead, public_vars)
%GET_TARGET Summary of this function goes here
est_pos = estimated_pose(1:2);
target = path(end,:);

for i = public_vars.get_target_index:length(path)

    d = norm(path(i,:) - est_pos);

    if d > lookahead
        target = path(i,:);
        public_vars.get_target_index = i;
        return;
    end

end

end

