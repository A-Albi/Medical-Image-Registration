%{
(10 points) Combine DIC(gray), Calcein(green), AC(red) image and show it.
b. (10 points) Combine DIC(gray), Calcein(green), AC(red), and TRAP(yellow) image
and show it.
c. (10 points) Combine DIC(gray), Calcein(green), AC(red), TRAP(yellow), and
AP(orange) image and show it.
d. (30 points) Repeat 3a-3c with the segmented images found in step 2c.
%}

[x, y, z] = size(DIC);
gray_DIC = zeros(x, y, z);
gray_DIC(:,:,1) = rgb2gray(DIC);
gray_DIC(:,:,2) = rgb2gray(DIC);
gray_DIC(:,:,3) = rgb2gray(DIC);

green_Calcein = zeros(x, y, z);
green_Calcein(:,:,2) = Calcein(:,:,2);

red_AC = zeros(x, y, z);
red_AC(:,:,1) = AC(:,:,1);

TRAP_resize = zeros(x, y, z);
TRAP_resize(:,:,1) = imresize(TRAP(:,:,1), [x y]);
TRAP_resize(:,:,2) = imresize(TRAP(:,:,2), [x y]);

AP_resize = zeros(x, y, z);
AP_resize(:,:,1) = imresize(AP(:,:,1), [x y]);
AP_resize(:,:,2) = imresize(AP(:,:,2).*.66, [x y]);

[x, y, z] = size(DIC);
gray_DIC2 = zeros(x, y, z);
gray_DIC2(:,:,1) = rgb2gray(subtract_DIC);
gray_DIC2(:,:,2) = rgb2gray(subtract_DIC);
gray_DIC2(:,:,3) = rgb2gray(subtract_DIC);

green_Calcein2 = zeros(x, y, z);
green_Calcein2(:,:,2) = subtract_Calcein(:,:,2);

red_AC2 = zeros(x, y, z);
red_AC2(:,:,1) = subtract_AC(:,:,1);

TRAP_resize2 = zeros(x, y, z);
TRAP_resize2(:,:,1) = imresize(subtract_TRAP(:,:,1), [x y]);
TRAP_resize2(:,:,2) = imresize(subtract_TRAP(:,:,2), [x y]);

AP_resize2 = zeros(x, y, z);
AP_resize2(:,:,1) = imresize(subtract_AP(:,:,1), [x y]);
AP_resize2(:,:,2) = imresize(subtract_AP(:,:,2).*.66, [x y]);

gray_DIC = gray_DIC/255;
green_Calcein = green_Calcein/255;
red_AC = red_AC/255;
TRAP_resize = TRAP_resize/255;
AP_resize = AP_resize/255;

gray_DIC2 = gray_DIC2;
green_Calcein2 = green_Calcein2;
red_AC2 = red_AC2;
TRAP_resize2 = TRAP_resize2;
AP_resize2 = AP_resize2;