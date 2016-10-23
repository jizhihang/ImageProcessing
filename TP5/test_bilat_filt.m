clc
clear

% read the image
A = double(imread('images/P30.jpg'))/255;

%A = A+0.1*randn(size(A));
% A(A<0) = 0; A(A>1) = 1;

%imwrite(A, "noisy.png");

% apply the filter
B = bilateral_filter(A,3,1,1);

imwrite(B, "output/P30b.png");
pkg load image;
figure;
imhist(A);
figure;
imhist(B);
pause;