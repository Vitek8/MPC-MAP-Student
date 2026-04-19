function [path] = plan_path(read_only_vars, public_vars)
%PLAN_PATH Summary of this function goes here

planning_required = 0;

if planning_required
    
    path = astar(read_only_vars, public_vars);
    path = smooth_path(path);
    
else
    
    [straight_line,sine_wave,circular_arc,combined] = plan_simple_trajectory(read_only_vars, public_vars);
    trajectories = {straight_line, sine_wave, circular_arc, combined};
    public_vars.path = trajectories{public_vars.path_type};
    
    path = public_vars.path;
    
end

end

