clear all
close all
clc

image = double(imread('input/house.png')) / 255;
% image = double(imread('input/lena.bmp')) / 255;

pkg load image;

[nRow, nCol, ch] = size(image);

% figure; title('Monet Les Nymphéas');
% imshow(image);
image = add_noise(image, 0.01);
sharped = laplacianSharpening(image, 3, 0.4);

figure; title('Laplacian Sharpening');
imshow(sharped);

imwrite(sharped,'output/house_sharpened_3_noisy.jpg')

pause

%unzoom = 8 ;
%sig = 0.8 * sqrt(unzoom^2 -1);
%image = add_noise(image,0.01);
%
%figure; title('Originale');
%imshow(image)
%
%
%gaussianFiltered = gaussianFilter(image, sig);
%% gaussianFiltered = gaussienne(image,sig);
%
%% image=undersampling(image);
%image2=image;
%image=undersampling(gaussianFiltered,8);
%image2=undersampling(image2,8);
%
%%pour l'affichage interm�diaire
%% figure; title('Gaussian filtering');
%% imshow(gaussianFiltered);
%
%% figure; title('undersampling');
%% imshow(image);
%
%image=zero_padding(image,8);
%image2=zero_padding(image2,8);
%
%
%figure; title('zero_padded_gaussian');
%imshow(image);
%
%figure; title('zero_padded_raw');
%imshow(image2);

% imwrite(image,'output/house8_bruit_gaussian.jpg')
% imwrite(image2,'output/house8_bruit_raw.jpg')

%% Tests images bruit�es


