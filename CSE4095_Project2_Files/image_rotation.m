function new_image = image_rotation(image, centroid_x, centroid_y, theta)
%{
The following function was cited from Jan Motl's
rotate around function in MathWorks.

Motl, Jan (2014) rotateAround source code (Version 1.3)
[Source code]. https://www.mathworks.com/matlabcentral/fileexchange/40469-rotate-an-image-around-a-point
%}

% We first obtain the size of the image.
[h, w] = size(image);
im_center_x = floor(w/2 + 1);
im_center_y = floor(h/2 + 1);

delta_x = im_center_x - centroid_x;
delta_y = im_center_y - centroid_y;

%{
By finding the polar coordinates of the shift,
we can represent the shift from the center of the
image to the center of the centroids.
%}
[rotate_shift, rho_shift] = cart2pol(-delta_x, delta_y);
[new_x, new_y] = pol2cart(rotate_shift+theta*(pi/180), rho_shift);
shift_x = round(centroid_x - (new_x + im_center_x));
shift_y = round(centroid_y - (-new_y + im_center_y));
p_x = abs(shift_x);
p_y = abs(shift_y);
pd = padarray(image, [p_y p_x]);

rotated_image = imrotate(pd, theta, 'bicubic', 'crop');
new_image = rotated_image(p_y + 1 - shift_y:end-p_y-shift_y, p_x+1-shift_x:end-p_x-shift_x);

end