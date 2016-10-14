clear all
close all
clc

image = double(imread('input/lena.bmp')) / 255;
[nRow, nCol, ch] = size(image);

[halfRow,halfCol] = compute_center(nRow, nCol);

% figure; title('Monet Les Nymphéas');
% imshow(image);
% 
% sharped = laplacianSharpening(image, 3, 0.4);
% 
% figure; title('Laplacian Sharpening');
% imshow(sharped);

unzoom = 2 ;
sig = 0.8 * sqrt(unzoom^2 -1);

figure; title('Originale');
imshow(image)


gaussianFiltered = gaussianFilter(image, sig);
% gaussianFiltered = add_noise(image,sig);

% image=undersampling(image);
image=undersampling(gaussianFiltered,2);
image2=undersampling(image,2);

%pour l'affichage intermédiaire
% figure; title('Gaussian filtering');
% imshow(gaussianFiltered);

% figure; title('undersampling');
% imshow(image);

image=zero_padding(image,2);
image2=zero_padding(image2,2);


figure; title('zero_padded_gaussian');
imshow(image);

figure; title('zero_padded_raw');
imshow(image2);



% pause

