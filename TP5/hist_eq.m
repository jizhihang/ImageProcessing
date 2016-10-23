clear all
close all
clc
pkg load image;
color_im = imread("images/flowers.bmp");
bw_im = double(imread("images/NotreDame1.tif"))/255;

%imshow(color_im);
%color_eq = histeq(color_im);
%imwrite(color_eq, "output/FlowersEq.png");

bw_eq = histeq(bw_im, 1024);
imwrite(bw_eq, "output/NotreDame1.png");

figure;
imhist(bw_im);
figure;
imhist(bw_eq);
pause
