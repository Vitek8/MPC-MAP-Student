function [public_vars] = student_workspace(read_only_vars,public_vars)
%STUDENT_WORKSPACE Summary of this function goes here

if read_only_vars.counter == 101

    public_vars.path = plan_path(read_only_vars, public_vars);
end

end