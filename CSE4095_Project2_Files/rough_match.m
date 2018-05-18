function [x_offset, y_offset] = rough_match(image1, image2, k)
[n1_x, n1_y] = size(image1);
[n2_x, n2_y] = size(image2);

image1_padded = zeros(n1_x + n2_x, n1_y + n2_y);
image2_padded = zeros(n1_x + n2_x, n1_y + n2_y);
image1_padded(1:n1_x,1:n1_y) = image1;
image2_padded((n1_x+1):n1_x+n2_x,(n1_y+1):n1_y+n2_y) = image2;
image1_fft = fft2(image1_padded);
image2_fft = fft2(image2_padded);
magnitude1 = abs(image1_fft);
phase1 = angle(image1_fft);
magnitude2 = abs(image2_fft);
phase2 = angle(image2_fft);
k_t = ((magnitude1.*magnitude2).^k).*exp(1j*(phase1-phase2));
r_t = fftshift(k_t);
new_img = ifft2(r_t);
max_val = max(max(new_img));
[x_offset, y_offset] = find(new_img == max_val);

x_offset = x_offset - (n2_x - 1);
y_offset = y_offset - (n2_y - 1);
end