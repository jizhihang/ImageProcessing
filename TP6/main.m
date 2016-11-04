close all;
clear all;

output_dir = 'output/';

I = double(imread("input/edouard-manet-berthe-morisot.jpg")) / 255;
imwrite(I, "output/edouart-manet-berthe-morisot.jpg");
% Boost de la saturation
figure; imshow(I);
boosted = saturationBoost(I, 1.5);
figure; imshow(boosted);
imwrite(boosted, "output/edouart-manet-berthe-morisot-boosted.jpg");

% Diminution de la saturation
unboosted = saturationBoost(I, 0.5);
figure; imshow(unboosted)
imwrite(unboosted, "output/edouart-manet-berthe-morisot-deboosted.jpg");

I = double(imread('input/lena.bmp')) / 255;

% Contrast change
% Affine feature scaling
% Per-channel feature scaling [minimum, maximum] -> [0, 1]
I_scaled = affineContrast(I);
title_= [output_dir "feature_scaled.png"];
imwrite(I_scaled, title_);

pkg load image;

figure; imhist(I);  print([output_dir "hist_orig.png"]);
figure; imhist(I_scaled); print([output_dir "hist_scaled.png"]);
figure; imshow(I); imwrite(I, [output_dir, "lena.png"]);
figure; imshow(I_scaled); imwrite(I_scaled, [output_dir, "lena_hist_scaled.png"]);

disp("inversion d'image")

source = double(imread('input/lena.bmp')) / 255;
dest = double(imread('input/barbara.png')) / 255;

figure;title('source');
imshow(source);
figure;title('destination')
imshow(dest);

phaseSwappedImg = swapPhase(source, dest);
figure;title('Phase swapping')
imshow(phaseSwappedImg)
imwrite(phaseSwappedImg, "output/phase_swapping.jpg");

phaseInsideRandom = swapPhase(source, double(randn(size(source))));
figure;title('Phase inside random');
imshow(phaseInsideRandom);

imwrite(phaseInsideRandom, "output/phase_swapping_in_random.jpg");

phaseInsideWhite = swapPhase(source, double(0.5 * ones(size(source))));
figure;title('Phase inside in grey image')
imshow(phaseInsideWhite)
imwrite(phaseInsideWhite, "output/phase_swapping_in_grey_image.jpg")


%phaseInsideGrad = swapPhase(source, double(mesh));
%figure;title('Phase inside gradient')
%imshow(phaseInsideGrad)
%imwrite(phaseInsideGrad, "output/phase_swapping_in_gradient.jpg");


moduleSwappedImg = swapModule(source, dest);
figure;title('Module swapping')
imshow(moduleSwappedImg)
imwrite(moduleSwappedImg, "output/module_swapping.jpg")


moduleSwappedImg = swapModule(source, double(randn(size(source))));
figure;title('Module swapping in grey image')
imshow(moduleSwappedImg)
imwrite(moduleSwappedImg, "output/module_swapping_in_grey_image.jpg")

disp('Deconvolution par division avec bruit')
noise_level = 0.01;
I_hat_noisy = gaussianFilter(I, 3.5, noise_level);
title_ = [output_dir "deconvolution_sigma_" num2str(s) "_noise_" num2str(noise_level) ".png"];
figure; title(title_); imwrite(I_hat_noisy, title_);

% Comparison of gaussian & Wiener filters for different levels of noise
noisy_deconvolution_test
