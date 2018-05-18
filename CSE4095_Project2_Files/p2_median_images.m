%{
Using the previous section, we use the aligned images for the following
images:

mineral2 is CALCEIN
mineral1 is AC
mineral3 is DIC
osteoclast2 is TRAP
osteoblast1_aligned, the aligned image, is AP

%}

% We obtain the median images.

%{
Calcein = mineral2;
AC = mineral1;
DIC = mineral3;
TRAP = osteoclast2;
AP = osteoblast1;
%}

Calcein = imresize(mineral2, .5);
AC = imresize(mineral1, .5);
DIC = imresize(mineral3, .5);
TRAP = imresize(osteoclast2, .5);
AP = imresize(osteoblast1, .5);

MCalcein = Calcein;
MAC = AC;
MDIC = DIC;
MTRAP = TRAP;
MAP = AP;

MCalcein(:,:,1) = medfilt2(Calcein(:,:,1), [51 51]);
MCalcein(:,:,2) = medfilt2(Calcein(:,:,2), [51 51]);
MCalcein(:,:,3) = medfilt2(Calcein(:,:,3), [51 51]);

MAC(:,:,1) = medfilt2(AC(:,:,1), [51 51]);
MAC(:,:,2) = medfilt2(AC(:,:,2), [51 51]);
MAC(:,:,3) = medfilt2(AC(:,:,3), [51 51]);

MDIC(:,:,1) = medfilt2(DIC(:,:,1), [501 501]);
MDIC(:,:,2) = medfilt2(DIC(:,:,2), [501 501]);
MDIC(:,:,3) = medfilt2(DIC(:,:,3), [501 501]);

MTRAP(:,:,1) = medfilt2(TRAP(:,:,1), [81 81]);
MTRAP(:,:,2) = medfilt2(TRAP(:,:,2), [81 81]);
MTRAP(:,:,3) = medfilt2(TRAP(:,:,3), [81 81]);

MAP(:,:,1) = medfilt2(AP(:,:,1), [71 71]);
MAP(:,:,2) = medfilt2(AP(:,:,2), [71 71]);
MAP(:,:,3) = medfilt2(AP(:,:,3), [71 71]);