%% Generate observed image
clear all;
close all;
I=double(imread('flowers.bmp'))/255;
I=mean(I,3);
sizeI=size(I);
u=I+0.1*randn(sizeI);
figure; imshow(u);title('Noisy observed image');

% Denoise
w=3;
sigma_s=1;
sigma_i=2;
size_I_noisy=size(u);


%% Bilateral filtering.


figure;imshow(I_denoised);title('Denoised image');

