%{
% Contains red beads of new image
mineral1 = im2double(imresize(imread('Efna4_E01_hf_FL2_M_s6c1.jpg','jpg'), 1));
% Contains green beads of old image
mineral2 = im2double(imresize(imread('Efna4_E01_hf_FL2_M_s6c2.jpg','jpg'), 1));
% Contains bone mineral
mineral3 = im2double(imresize(imread('Efna4_E01_hf_FL2_M_s6c3.jpg','jpg'), 1));
% Contains AP cells with red beats
osteoblast1 = im2double(imresize(imread('Efna4_E01_hf_FL2_A_s6c1.jpg','jpg'), 1));
% Contains green beads for trap cells
osteoclast1 = im2double(imresize(imread('Efna4_E01_hf_FL2_T_s6c1.jpg','jpg'), 1));
% Contains trap cells
osteoclast2 = im2double(imresize(imread('Efna4_E01_hf_FL2_T_s6c2.jpg','jpg'), 1));
%}

mineral1 = imread('Efna4_E01_hf_FL2_M_s6c1.jpg','jpg');
mineral2 = imread('Efna4_E01_hf_FL2_M_s6c2.jpg','jpg');
mineral3 = imread('Efna4_E01_hf_FL2_M_s6c3.jpg','jpg');
osteoblast1 = imread('Efna4_E01_hf_FL2_A_s6c1.jpg','jpg');
osteoclast1 = imread('Efna4_E01_hf_FL2_T_s6c1.jpg','jpg');
osteoclast2 = imread('Efna4_E01_hf_FL2_T_s6c2.jpg','jpg');

% For the first part, we use osteoclast1 as test, and mineral2 as
% reference.

% For the second part, we use osteoblast1 as test,
% 'Efna4_E01_hF_FL2_A_s6c1.jpg' and mineral1 as the reference image,
% 'Efna4_E01_hF_FL2_M_s6c1.jpg'