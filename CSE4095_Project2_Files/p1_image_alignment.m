function [realigned_test_image, realigned_original_image] = p1_image_alignment(reference_image, test_image, test_image_original)
    % We shift the original image the same way as the test image.
    
    %%%%%%%%%%%%%% INITIAL TRANSLATION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    [x_shift_A, y_shift_A] = rough_match(reference_image, test_image, 1);
    [x_size_reference, y_size_reference] = size(reference_image);
    [x_size_test, y_size_test] = size(test_image);
    
    %{
    We perform the initial translation of the test beads and the original
    test image.
    %}
    translated_test_A = imtranslate(test_image, [-y_shift_A, -x_shift_A]);
    realigned_original_image = test_image_original;
    realigned_original_image(:,:,1) = imtranslate(test_image_original(:,:,1), [-y_shift_A, -x_shift_A]);
    realigned_original_image(:,:,2) = imtranslate(test_image_original(:,:,2), [-y_shift_A, -x_shift_A]);
    realigned_original_image(:,:,3) = imtranslate(test_image_original(:,:,3), [-y_shift_A, -x_shift_A]);
    half_boundary = x_size_reference/2;
    
    %{
    We create the first overlay image, overlay_A to contain red and green
    beads simultaneously.
    %}
    
    overlay_A = zeros(x_size_reference, y_size_reference, 3);
    overlay_A(:,:,1) = reference_image;
    overlay_A(1:x_size_test,1:y_size_test, 2) = translated_test_A;
    half_boundary = x_size_reference/2;
    
    %%%%%%%%%%%%%%%%%%%%%%%%% ROTATION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % Computation of upper centroid for red reference beads.
    
    RCOUNT1_A = 0;
    
    RTOP_X_SUM_A = 0;
    RTOP_Y_SUM_A = 0;
    for j = 1:half_boundary
        for i = 1:y_size_reference
            if overlay_A(j, i, 1) ~= 0
                RCOUNT1_A = RCOUNT1_A + 1;
                RTOP_X_SUM_A = RTOP_X_SUM_A + i;
                RTOP_Y_SUM_A = RTOP_Y_SUM_A + j;
            end
        end
    end
    
    % Computation of lower centroid for red reference beads.
    
    RCOUNT2_A  = 0;
    RBOTTOM_X_SUM_A = 0;
    RBOTTOM_Y_SUM_A = 0;
    for j = half_boundary:x_size_reference
        for i = 1:y_size_reference
            if overlay_A(j, i, 1) ~= 0
                RCOUNT2_A = RCOUNT2_A + 1;
                RBOTTOM_X_SUM_A = RBOTTOM_X_SUM_A + i;
                RBOTTOM_Y_SUM_A = RBOTTOM_Y_SUM_A + j;
            end
        end
    end
    
    % Computation of upper centroid for green reference beads.
    
    GCOUNT1_A = 0;
    
    GTOP_X_SUM_A = 0;
    GTOP_Y_SUM_A = 0;
    for j = 1:half_boundary
        for i = 1:y_size_reference
            if overlay_A(j, i, 2) ~= 0
                GCOUNT1_A = GCOUNT1_A + 1;
                GTOP_X_SUM_A = GTOP_X_SUM_A + i;
                GTOP_Y_SUM_A = GTOP_Y_SUM_A + j;
            end
        end
    end
    
    % Computation of lower centroid for red reference beads.
    
    GCOUNT2_A  = 0;
    GBOTTOM_X_SUM_A = 0;
    GBOTTOM_Y_SUM_A = 0;
    for j = half_boundary:x_size_reference
        for i = 1:y_size_reference
            if overlay_A(j, i, 2) ~= 0
                GCOUNT2_A = GCOUNT2_A + 1;
                GBOTTOM_X_SUM_A = GBOTTOM_X_SUM_A + i;
                GBOTTOM_Y_SUM_A = GBOTTOM_Y_SUM_A + j;
            end
        end
    end
    
    % We take the sum from each component obtain each of the averages.

G_CENTER_TOP_A = fliplr([GTOP_X_SUM_A/GCOUNT1_A, GTOP_Y_SUM_A/GCOUNT1_A]);
G_CENTER_BOTTOM_A = fliplr([GBOTTOM_X_SUM_A/GCOUNT2_A, GBOTTOM_Y_SUM_A/GCOUNT2_A]);
R_CENTER_TOP_A = fliplr([RTOP_X_SUM_A/RCOUNT1_A, RTOP_Y_SUM_A/RCOUNT1_A]);
R_CENTER_BOTTOM_A = fliplr([RBOTTOM_X_SUM_A/RCOUNT2_A, RBOTTOM_Y_SUM_A/RCOUNT2_A]);

    % We keep track of the centroids in a copy of the 3-D image.
    
    overlay_A_centroids = overlay_A;
    overlay_A_centroids(G_CENTER_BOTTOM_A(1) - 50:G_CENTER_BOTTOM_A(1) + 50, G_CENTER_BOTTOM_A(2) - 50: G_CENTER_BOTTOM_A(2) + 50, 2) = 1;
    overlay_A_centroids(R_CENTER_BOTTOM_A(1) - 50:R_CENTER_BOTTOM_A(1) + 50, R_CENTER_BOTTOM_A(2) - 50: R_CENTER_BOTTOM_A(2) + 50, 1) = 1;
    overlay_A_centroids(G_CENTER_TOP_A(1) - 50:G_CENTER_TOP_A(1) + 50, G_CENTER_TOP_A(2) - 50: G_CENTER_TOP_A(2) + 50, 2) = 1;
    overlay_A_centroids(R_CENTER_TOP_A(1) - 50:R_CENTER_TOP_A(1) + 50, R_CENTER_TOP_A(2) - 50: R_CENTER_TOP_A(2) + 50, 1) = 1;
    
    % We compute the shift between the red and green bottom centroids and
    % shift the green bottom centroid such that it aligns with the red
    % centroid's position. We use this to find the angle of rotation.
    
    SHIFTVAL_A = G_CENTER_BOTTOM_A - R_CENTER_BOTTOM_A;
    G_CENTER_BOTTOM_N_A = G_CENTER_BOTTOM_A - SHIFTVAL_A;
    G_CENTER_TOP_N_A = G_CENTER_TOP_A - SHIFTVAL_A;
    R_CENTER_TOP_N_A = R_CENTER_TOP_A;
    ADJACENT_A = R_CENTER_TOP_N_A - G_CENTER_BOTTOM_N_A;
    HYPOTENUSE_A = G_CENTER_TOP_N_A - G_CENTER_BOTTOM_N_A;
    N1_A = ADJACENT_A/norm(ADJACENT_A);
    N2_A = HYPOTENUSE_A/norm(HYPOTENUSE_A);
    THETA_A = atan2(norm(det([N2_A; N1_A])), dot(N1_A, N2_A));
    THETA_DEG_A = -rad2deg(THETA_A);
    
    % We rotate the green component, as that is the test image.
    % We rotate both the beads and original test image.
    
    overlay_B = overlay_A;
    overlay_B(:,:,2) = image_rotation(overlay_B(:,:,2), G_CENTER_BOTTOM_A(1), G_CENTER_BOTTOM_A(2), THETA_DEG_A);
    realigned_original_image(:,:,1) = image_rotation(realigned_original_image(:,:,1), G_CENTER_BOTTOM_A(1), G_CENTER_BOTTOM_A(2), THETA_DEG_A);
    realigned_original_image(:,:,2) = image_rotation(realigned_original_image(:,:,2), G_CENTER_BOTTOM_A(1), G_CENTER_BOTTOM_A(2), THETA_DEG_A);
    realigned_original_image(:,:,3) = image_rotation(realigned_original_image(:,:,3), G_CENTER_BOTTOM_A(1), G_CENTER_BOTTOM_A(2), THETA_DEG_A);
    
    % With overlay_B, we rescale the image.
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%% SCALE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   


    SCALE_A = norm(ADJACENT_A)/norm(HYPOTENUSE_A);

    if SCALE_A > 1.05 | SCALE_A < 0.95
    
        overlay_B_resize = imresize(overlay_B(:,:,2), SCALE_A);
        [overlay_B_resize_x, overlay_B_resize_y] = size(overlay_B_resize);
        realigned_image_zeros_A = zeros(x_size_reference, y_size_reference, 3);
        difference_N_x = round((x_size_reference - overlay_B_resize_x)/2);
        difference_N_y = round((y_size_reference - overlay_B_resize_y)/2);
        overlay_B_resize_zeros = zeros(x_size_reference, y_size_reference);
        overlay_B_resize_zeros(difference_N_x+1:difference_N_x+overlay_B_resize_x,difference_N_y+1:difference_N_y+overlay_B_resize_y) = overlay_B_resize;
        overlay_B(:,:,2) = overlay_B_resize_zeros;
        realigned_image_zeros_A(difference_N_x+1:difference_N_x+overlay_B_resize_x, difference_N_y+1:difference_N_y+overlay_B_resize_y, :) = imresize(realigned_original_image, [overlay_B_resize_x, overlay_B_resize_y]);
        realigned_original_image = realigned_image_zeros_A(difference_N_x+1:difference_N_x+overlay_B_resize_x, difference_N_y+1:difference_N_y+overlay_B_resize_y, :);
        
    end
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%% SHIFT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
    % Computation of upper centroid for red reference beads.
    
    RCOUNT1_B = 0;
    
    RTOP_X_SUM_B = 0;
    RTOP_Y_SUM_B = 0;
    for j = 1:half_boundary
        for i = 1:y_size_reference
            if overlay_B(j, i, 1) ~= 0
                RCOUNT1_B = RCOUNT1_B + 1;
                RTOP_X_SUM_B = RTOP_X_SUM_B + i;
                RTOP_Y_SUM_B = RTOP_Y_SUM_B + j;
            end
        end
    end
    
    % Computation of lower centroid for red reference beads.
    
    RCOUNT2_B  = 0;
    RBOTTOM_X_SUM_B = 0;
    RBOTTOM_Y_SUM_B = 0;
    for j = half_boundary:x_size_reference
        for i = 1:y_size_reference
            if overlay_B(j, i, 1) ~= 0
                RCOUNT2_B = RCOUNT2_B + 1;
                RBOTTOM_X_SUM_B = RBOTTOM_X_SUM_B + i;
                RBOTTOM_Y_SUM_B = RBOTTOM_Y_SUM_B + j;
            end
        end
    end
    
    % Computation of upper centroid for green reference beads.
    
    GCOUNT1_B = 0;
    
    GTOP_X_SUM_B = 0;
    GTOP_Y_SUM_B = 0;
    for j = 1:half_boundary
        for i = 1:y_size_reference
            if overlay_B(j, i, 2) ~= 0
                GCOUNT1_B = GCOUNT1_B + 1;
                GTOP_X_SUM_B = GTOP_X_SUM_B + i;
                GTOP_Y_SUM_B = GTOP_Y_SUM_B + j;
            end
        end
    end
    
    % Computation of lower centroid for red reference beads.
    
    GCOUNT2_B  = 0;
    GBOTTOM_X_SUM_B = 0;
    GBOTTOM_Y_SUM_B = 0;
    for j = half_boundary:x_size_reference
        for i = 1:y_size_reference
            if overlay_B(j, i, 2) ~= 0
                GCOUNT2_B = GCOUNT2_B + 1;
                GBOTTOM_X_SUM_B = GBOTTOM_X_SUM_B + i;
                GBOTTOM_Y_SUM_B = GBOTTOM_Y_SUM_B + j;
            end
        end
    end
    
% We take the sum from each component obtain each of the averages.

G_CENTER_TOP_B = fliplr([GTOP_X_SUM_B/GCOUNT1_B, GTOP_Y_SUM_B/GCOUNT1_B]);
G_CENTER_BOTTOM_B = fliplr([GBOTTOM_X_SUM_B/GCOUNT2_B, GBOTTOM_Y_SUM_B/GCOUNT2_B]);
R_CENTER_TOP_B = fliplr([RTOP_X_SUM_B/RCOUNT1_B, RTOP_Y_SUM_B/RCOUNT1_B]);
R_CENTER_BOTTOM_B = fliplr([RBOTTOM_X_SUM_B/RCOUNT2_B, RBOTTOM_Y_SUM_B/RCOUNT2_B]);

% We save a copy of the second image to reveal the centroids.

overlay_B_centroids = overlay_B;
overlay_B_centroids(G_CENTER_BOTTOM_B(1) - 50:G_CENTER_BOTTOM_B(1) + 50, G_CENTER_BOTTOM_B(2) - 50: G_CENTER_BOTTOM_B(2) + 50, 2) = 1;
overlay_B_centroids(R_CENTER_BOTTOM_B(1) - 50:R_CENTER_BOTTOM_B(1) + 50, R_CENTER_BOTTOM_B(2) - 50: R_CENTER_BOTTOM_B(2) + 50, 1) = 1;
overlay_B_centroids(G_CENTER_TOP_B(1) - 50:G_CENTER_TOP_B(1) + 50, G_CENTER_TOP_B(2) - 50: G_CENTER_TOP_B(2) + 50, 2) = 1;
overlay_B_centroids(R_CENTER_TOP_B(1) - 50:R_CENTER_TOP_B(1) + 50, R_CENTER_TOP_B(2) - 50: R_CENTER_TOP_B(2) + 50, 1) = 1;

% We shift the image again to realign the bottom centroids.

SHIFTVAL_B = fliplr(G_CENTER_BOTTOM_B - R_CENTER_BOTTOM_B);
overlay_C = overlay_B;
overlay_C(:,:,2) = imtranslate(overlay_C(:,:,2), -SHIFTVAL_B);
realigned_original_image(:,:,1) = imtranslate(realigned_original_image(:,:,1), -SHIFTVAL_B);
realigned_original_image(:,:,2) = imtranslate(realigned_original_image(:,:,2), -SHIFTVAL_B);
realigned_original_image(:,:,3) = imtranslate(realigned_original_image(:,:,3), -SHIFTVAL_B);
    
    RCOUNT1_C = 0;
    
    RTOP_X_SUM_C = 0;
    RTOP_Y_SUM_C = 0;
    for j = 1:half_boundary
        for i = 1:y_size_reference
            if overlay_C(j, i, 1) ~= 0
                RCOUNT1_C = RCOUNT1_C + 1;
                RTOP_X_SUM_C = RTOP_X_SUM_C + i;
                RTOP_Y_SUM_C = RTOP_Y_SUM_C + j;
            end
        end
    end
    
    % Computation of lower centroid for red reference beads.
    
    RCOUNT2_C  = 0;
    RBOTTOM_X_SUM_C = 0;
    RBOTTOM_Y_SUM_C = 0;
    for j = half_boundary:x_size_reference
        for i = 1:y_size_reference
            if overlay_C(j, i, 1) ~= 0
                RCOUNT2_C = RCOUNT2_C + 1;
                RBOTTOM_X_SUM_C = RBOTTOM_X_SUM_C + i;
                RBOTTOM_Y_SUM_C = RBOTTOM_Y_SUM_C + j;
            end
        end
    end
    
    % Computation of upper centroid for green reference beads.
    
    GCOUNT1_C = 0;
    
    GTOP_X_SUM_C = 0;
    GTOP_Y_SUM_C = 0;
    for j = 1:half_boundary
        for i = 1:y_size_reference
            if overlay_C(j, i, 2) ~= 0
                GCOUNT1_C = GCOUNT1_C + 1;
                GTOP_X_SUM_C = GTOP_X_SUM_C + i;
                GTOP_Y_SUM_C = GTOP_Y_SUM_C + j;
            end
        end
    end
    
    % Computation of lower centroid for red reference beads.
    
    GCOUNT2_C  = 0;
    GBOTTOM_X_SUM_C = 0;
    GBOTTOM_Y_SUM_C = 0;
    for j = half_boundary:x_size_reference
        for i = 1:y_size_reference
            if overlay_C(j, i, 2) ~= 0
                GCOUNT2_C = GCOUNT2_C + 1;
                GBOTTOM_X_SUM_C = GBOTTOM_X_SUM_C + i;
                GBOTTOM_Y_SUM_C = GBOTTOM_Y_SUM_C + j;
            end
        end
    end

G_CENTER_TOP_C = fliplr([GTOP_X_SUM_C/GCOUNT1_C, GTOP_Y_SUM_C/GCOUNT1_C]);
G_CENTER_BOTTOM_C = fliplr([GBOTTOM_X_SUM_C/GCOUNT2_C, GBOTTOM_Y_SUM_C/GCOUNT2_C]);
R_CENTER_TOP_C = fliplr([RTOP_X_SUM_C/RCOUNT1_C, RTOP_Y_SUM_C/RCOUNT1_C]);
R_CENTER_BOTTOM_C = fliplr([RBOTTOM_X_SUM_C/RCOUNT2_C, RBOTTOM_Y_SUM_C/RCOUNT2_C]);
    
overlay_C_centroids = overlay_C;
overlay_C_centroids(G_CENTER_BOTTOM_C(1) - 50:G_CENTER_BOTTOM_C(1) + 50, G_CENTER_BOTTOM_C(2) - 50: G_CENTER_BOTTOM_C(2) + 50, 2) = 1;
overlay_C_centroids(R_CENTER_BOTTOM_C(1) - 50:R_CENTER_BOTTOM_C(1) + 50, R_CENTER_BOTTOM_C(2) - 50: R_CENTER_BOTTOM_C(2) + 50, 1) = 1;
overlay_C_centroids(G_CENTER_TOP_C(1) - 50:G_CENTER_TOP_C(1) + 50, G_CENTER_TOP_C(2) - 50: G_CENTER_TOP_C(2) + 50, 2) = 1;
overlay_C_centroids(R_CENTER_TOP_C(1) - 50:R_CENTER_TOP_C(1) + 50, R_CENTER_TOP_C(2) - 50: R_CENTER_TOP_C(2) + 50, 1) = 1;


realigned_test_image = overlay_C;

% We compute the shift between the red and green bottom centroids and
% shift the green bottom centroid such that it aligns with the red
% centroid's position. We use this to find the angle of rotation.
end