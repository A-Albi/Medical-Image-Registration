function [circles_image, circles_data] = find_circles(image, threshold, mval)

% The image is assumed to be two-dimensional.

%{
    We threshold the image into a logical type and
    proceed to check if each area is a circle. The
    information about the areas and perimeters of each
    objects indicates this.

    Then, using the find function, each of the areas with
    circles are located and isolated from the rest of the
    image.
%}
threshold_image = imbinarize(image, threshold);
label = bwlabel(threshold_image);
data = regionprops(threshold_image, 'Centroid', 'Area', 'Perimeter');
areas = [data.Area];
perimeters = [data.Perimeter];
ratios = (perimeters.^2)./(4*pi*areas);
valid_circles = (ratios <= 1 + mval) & (ratios >= 1 - mval);
valid_circles_idx = find(valid_circles);

% We return the image and the data

circles_image = double(ismember(label, valid_circles_idx) > 0);
circles_data = data((ratios <= 1 + mval) & (ratios >= 1 - mval));


end