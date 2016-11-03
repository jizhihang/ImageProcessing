close all;
clear all;

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
figure;title('Phase inside random')
imshow(phaseInsideRandom)

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

I = double(imread('input/flowers.bmp'))/255;
% Comparison of gaussian & Wiener filters for different levels of noise
disp('Deconvolution sans bruit')
sigma_conv = [1:10];
for s = [1] %sigma_conv
  I_hat = gaussianFilter(I, s, 0);
  title_ = ['Deconvolution avec sigma= ' num2str(s)];
  figure; title(title_); imshow(I_hat);
end

disp('Deconvolution avec bruit')
I_hat_noisy = gaussianFilter(I, 3.5, 0.01);
title_ = ['Deconvolution avec sigma= ' num2str(s)];
figure; title(title_); imshow(I_hat);

disp('Filtre Wiener')
sigma_noise = [0:0.1:0.3];
for s_n = [0.1] %sigma_noise
    for s_c = [3.5] %sigma_conv
    	I_wiener = wienerFilter(I, s_c, s_n, 0.5);
	figure;
	title_ = ['Deconvolution, sigma_g = ' num2str(s_c) ' noise = ' num2str(s_n)];
	imshow(I_wiener);
    end
end

% Contrast change
% 1. Affine feature scaling
% Per-channel feature scaling [minimum, maximum] -> [0, 1]
I_scaled = zeros(size(I));
for k = [1:3]
  max_ = max(max(I(:, :, k)));
  min_ = min(min(I(:, :, k)));
  I_scaled(:, :, k) = (I(:, :, k) - min_)/(max_ - min_);
end

figure; title('Feature scaled'); imshow(I_scaled);

% Boost de la saturation
saturationBoost(I_scaled, 1.5);

% Diminution de la saturation
saturationBoost(I_scaled, 0.5);

% 2. Interpolation lineaire?

% Filtre median
w = 3;
pause

