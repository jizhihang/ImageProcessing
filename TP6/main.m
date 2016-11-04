close all;
clear all;

output_dir = 'output/';

I = double(imread('input/boat512.gif')) / 255;
I_scaled = affineContrast(I);
title_= [output_dir "feature_scaled.png"];
imwrite(I_scaled, title_);
pkg load image;
figure; imhist(I);  print([output_dir "hist_orig.png"]);
figure; imhist(I_scaled); print([output_dir "hist_scaled.png"]);
figure; imshow(I);
figure; imshow(I_scaled);
pause


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


% Contrast change
% 1. Affine feature scaling
% Per-channel feature scaling [minimum, maximum] -> [0, 1]

%figure('Position',[startx,starty,width,height]);plot(0:20,sin(0:20));

% Comparison of gaussian & Wiener filters for different levels of noise
disp('Deconvolution sans bruit')
sigma_conv = [1:10];
for s = [1] %sigma_conv
  I_hat = gaussianFilter(I, s, 0);
  title_ = [output_dir "deconvolution_sigma_" num2str(s) ".png"];
  % figure; title(title_); imshow(I_hat);
  imwrite(I_hat, title_);
end

noise_level = 0.01;
%I_noisy += randn(size(I)) * noise_level;

disp('Deconvolution avec bruit')
I_hat_noisy = gaussianFilter(I, 3.5, noise_level);
title_ = [output_dir "deconvolution_sigma_" num2str(s) "_noise_" num2str(noise_level) ".png"];
figure; title(title_); imwrite(I_hat_noisy, title_);

disp('Filtre Wiener')
sigma_noise = [0:0.1:0.3];
for s_n = [0.1] %sigma_noise
    for s_c = [3.5] %sigma_conv
    	I_wiener = wienerFilter(I, s_c, s_n, 0.5);
	figure;
	title_ = [output_dir "wiener_sigma_g_" num2str(s_c) "_noise_" num2str(s_n) ".png"];
	imshow(I_wiener); imwrite(I_wiener, title_);
    end
end

% Boost de la saturation
saturationBoost(I_scaled, 1.5);

% Diminution de la saturation
saturationBoost(I_scaled, 0.5);

% 2. Interpolation lineaire?

% Filtre median
w = 3;
