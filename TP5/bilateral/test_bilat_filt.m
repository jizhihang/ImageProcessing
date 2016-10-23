clc
clear

% read the image
A = double(imread('../images/flowers.bmp'))/255;

A = A+0.1*randn(size(A));
% A(A<0) = 0; A(A>1) = 1;

imwrite(A, "noisy.png");

% apply the filter
B = bilateral_filter(A,3,1,1);

imwrite(B, "bilateral.png");