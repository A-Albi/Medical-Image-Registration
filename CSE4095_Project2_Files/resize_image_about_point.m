function new_image = resize_image_about_point(changing_image, stable_image, row_y, col_x, scale)
[y_si, x_si] = size(stable_image);
[y_ci, x_ci] = size(changing_image);
upper_half = changing_image(1:row_y, 1:x_ci);
lower_half = changing_image(row_y + 1:y_ci, 1:x_ci);
[uh_rows, uh_cols] = size(upper_half);
[lh_rows, lh_cols] = size(lower_half);
new_upper_half = imresize(upper_half, [floor(uh_rows*scale) uh_cols]);
new_lower_half = imresize(lower_half, [floor(lh_rows*scale) lh_cols]);
new_image = zeros(y_si, x_si, 3);
new_image(:,:,1) = stable_image;
new_image(row_y - floor(uh_rows*scale) + 1:row_y, 1:x_ci, 2) = new_upper_half;
new_image(floor(row_y + 1): floor(row_y + floor(lh_rows*scale)), 1:x_ci, 2) = new_lower_half;
% test with this imshow(resize_image_about_point(overlay_image2_A(:,:,2), overlay_image2_A(:,:,1), G_CENTER_BOTTOM_2_A(1), G_CENTER_BOTTOM_2_A(2), .8742));



end