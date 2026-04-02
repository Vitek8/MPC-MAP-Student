function [target, public_vars] = get_target(estimated_pose, path, lookahead)
%GET_TARGET Summary of this function goes here
est_pos = estimated_pose(1:2);
target = path(end,:);
file = "algorithms\report\assignment_2\data\index.mat";
if exist(file, 'file')
    load(file, 'index');
else
    index = 1;
end
for i = index:length(path)

    d = norm(path(i,:) - est_pos);

    if d > lookahead
        target = path(i,:);
        index = i;
        save(file, 'index');
        return;
    end

end

end

