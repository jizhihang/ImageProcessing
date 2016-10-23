clear all
close all
clc

% This won't work, equalization from a single histogram expects grayscale images.
%color_im = imread("images/flowers.bmp");
%imshow(color_im);
%color_eq = histeq(color_im);
%imwrite(color_eq, "output/FlowersEq.png");

% The image is B&W but the file has three channels. 
bw_im = mean(double(imread("images/P11.jpg"))/255, 3);
bw_eq = histeq(bw_im, 256);
imwrite(bw_eq, "output/P11.png");

figure;
imhist(bw_im);
figure;
imhist(bw_eq);
pause
