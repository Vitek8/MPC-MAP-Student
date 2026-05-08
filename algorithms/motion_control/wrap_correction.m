function actual_angle_corected = wrap_correction(actual_angle, prev_angle)

d = actual_angle - prev_angle;
actual_angle_corected = actual_angle; 

if d > pi
    actual_angle_corected = actual_angle - 2*pi;

elseif d < -pi
    actual_angle_corected = actual_angle + 2*pi;    
end

end