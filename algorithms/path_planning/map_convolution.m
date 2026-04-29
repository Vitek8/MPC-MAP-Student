function new_map = map_convolution(map)

radius = 2;
[x,y] = meshgrid(-radius:radius, -radius:radius);
kernel = (x.^2 + y.^2) <= radius^2;
% kernel = ones(2*radius+1);
new_map = conv2(double(map), double(kernel), 'same') > 0;

%% kod pro vizualizaci konvoluce (znázornuně mapu před a po konvoluci v dokumentaci obrázek 2)

% conv_map = new_map / max(new_map(:));
% 
% orig = imresize(double(map), [420 560], 'nearest');
% conv_resized = imresize(conv_map, [420 560], 'bilinear');
% 
% rgb = repmat(orig, [1 1 3]);
% 
% alpha = 0.6;
% overlay = conv_resized .* (1 - orig); 
% 
% for i = 1:3
%     rgb(:,:,i) = rgb(:,:,i) + alpha * overlay;
% end
% 
% rgb = min(rgb,1);
% rgb = flipud(rgb);
% imwrite(rgb, 'mapa_overlay.png');
end



