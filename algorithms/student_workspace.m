function [public_vars] = student_workspace(read_only_vars,public_vars)
%STUDENT_WORKSPACE Summary of this function goes here

if (read_only_vars.counter == 1)

    public_vars.path = plan_path(read_only_vars, public_vars);     
    public_vars = init_particle_filter(read_only_vars, public_vars);
    public_vars.get_target_index = 1;

end

public_vars.particles = update_particle_filter(read_only_vars, public_vars);
public_vars = plan_motion(read_only_vars, public_vars);

end