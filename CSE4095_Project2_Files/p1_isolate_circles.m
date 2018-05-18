threshold = 0.6;
mval = 0.2;

%{
We perform circle-finding for the first pair of images, the reference image
'Efna4_E01_hf_FL2_M_s6c2.jpg' as mineral2 and the test image
'Efna4_E01_hf_FL2_T_s6c1.jpg' as osteoclast1.
%}

[r_m2_c, r_m2_c_data] = find_circles(mineral2(:,:,2), threshold, mval);
[o_m1_c, o_m1_c_data] = find_circles(osteoclast1(:,:,2), threshold, mval);

%{
We perform circle finding on the reference image mineral1 and the test
image osteoblast1.
%}

[r_m2_b, r_m2_b_data] = find_circles(mineral1(:,:,1), threshold, mval);
[o_m1_b, o_m1_b_data] = find_circles(osteoblast1(:,:,1), threshold, mval);