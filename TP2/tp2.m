clc
clear all
close all

%chargement de l'image
% lena = imread('images/lena.bmp');
% figure(1); %originale
% imshow(lena);

translation = [50.5, 50.5];
a = translateImage(lena, translation);

figure(2);
imshow(a);

zoom = size(lena);
a = zeroPadding(lena, zoom);
s = size(a)
figure(6)
imshow(a)

s= [s, 3]
b = zeros(s);
b(:,:, 1) = a;
b(:,:, 2) = a;
b(:,:, 3) = a;
imwrite(b, 'images/lena-zoomed.bmp');
