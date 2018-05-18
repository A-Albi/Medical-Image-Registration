[x_shift, y_shift] = rough_match(r_m2_c, o_m1_c, 1);
[x_shift2, y_shift2] = rough_match(r_m2_b, o_m1_b, 1);
[o_m1_c_aligned, osteoclast1_aligned] = p1_image_alignment(r_m2_c, o_m1_c, osteoclast1);
[o_m1_b_aligned, osteoblast1_aligned] = p1_image_alignment(r_m2_b, o_m1_b, osteoblast1);