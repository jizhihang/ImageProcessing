clear all
close all
clc

image = double(imread('input/Monet_Les_Nympheas.jpg')) / 255;
[nRow, nCol, ch] = size(image);

[halfRow,halfCol] = compute_center(nRow, nCol);

% figure; title('Monet Les Nymphéas');
% imshow(image);
% 
% sharped = laplacianSharpening(image, 3, 0.4);
% 
% figure; title('Laplacian Sharpening');
% imshow(sharped);

unzoom = 2;
sig = 0.8 * sqrt(unzoom^2 -1);
gaussianFiltered = gaussianFilter(image, sig, halfRow, halfCol);

image=undersampling(image);

figure; title('Gaussian filtering');
imshow(real(gaussianFiltered));

figure; title('undersampling');
imshow(image);


% pause
