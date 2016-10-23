clear all
close all
clc
% pkg load image;

function test_bilateral_filter(A, noise)
	Anoisy = A + noise*randn(size(A));
	% Anoisy(Anoisy<0) = 0; Anoisy(Anoisy>1) = 1;

	%imwrite(Anoisy, "noisy.png");

	% apply the filter
	B = bilateral_filter(Anoisy,3,1,1);

	imwrite(B, "output/flowers_filtered.png");

	% Uncomment to visualize histograms
	% figure; imhist(Anoisy); title("Noisy Image Histogram");
	% figure; imhist(B); title("Bilaterally Filtered Histogram");
	% pause;
end

function test_hist_eq()
	% The image is B&W but the file has three channels. 
	bw_im = mean(double(imread("images/Photo11.jpg"))/255, 3);
	bw_eq = histeq(bw_im, 256);
	imwrite(bw_eq, "output/Photo11Equalized.png");

	figure; imhist(bw_im); title("B&W Image Histogram");
	figure; imhist(bw_eq); title("Equalized B&W Image Histogram");
end

function test_midway()
	% Charger deux images prises du meme angle mais avec des durees dexposition differentes.
	u_1 = double(imread("images/Photo1.jpg"))/255;
	u_2 = double(imread("images/Photo2.jpg"))/255;

	u_midway_1 = zeros(size(u_1));
	u_midway_2 = zeros(size(u_2));

	% Get sorted elements and corresponding indices
	% Compute midway values for each image component
	[u_sort_1, index_u_1] = sort(u_1(:));
	[u_sort_2, index_u_2] = sort(u_2(:));
	u_midway_1(index_u_1) = (u_sort_1 + u_sort_2)/2;
	u_midway_2(index_u_2) = (u_sort_1 + u_sort_2)/2;

	u_midway_1 = reshape(u_midway_1, size(u_1));
	u_midway_2 = reshape(u_midway_2, size(u_2));

	imwrite(u_midway_2, "output/Photo1Midway.png");
	imwrite(u_midway_1, "output/Photo2Midway.png");

	figure; imhist(u_midway_2); title("Image 2 Midway Histogram");
	figure; imhist(u_midway_1); title("Image 1 Midway Histogram");
end

function test_random_image()
	size = [256, 256, 3];

	figure;
	subplot(2, 2, 1);
	img = randomImage(1/2, 1/100, size);
	imshow(img); title("random image std=1/100");
	imwrite(img, "output/noise0_01.png");

	subplot(2, 2, 2);
	img = randomImage(1/2, 1/10, size);
	imshow(img); title("random image std=1/10");
	imwrite(img, "output/noise0_1.png");

	subplot(2, 2, 3)
	img = randomImage(1/2, 1, size);
	imshow(img); title("random image std=1");
	imwrite(img, "output/noise1_0.png");
end

% Read the image, set noise level
A = double(imread('images/flowers.bmp'))/255;
noise = 0.1;

test_random_image();
test_hist_eq();
test_midway();
test_bilateral_filter(A, noise);
pause