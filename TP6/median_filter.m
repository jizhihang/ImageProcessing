clear all; close all;
proportion=.5; % proportion of corrupted pixels (The following
% will only produce an approximation of the proportion. See below.)
I=double(imread('lena.bmp'))/255;
I=mean(I,3); % Assume grayscle for now

% Simulation of the noise
I_noisy=I(:); % We reorder the matrix to transform it into a vector.
uniform_numbers = rand(size(I)); % For every  pixel we generate an i.i.d.
% uniform random variable in  [0,1].
positions_for_zeroes = find(uniform_numbers <= proportion/2); % we look for the positions
% that satisfy x<proportions. Since uniform_numbers is uniform there are
% approximatively proportion/2 such values. (This is where we made an
% approximation. Due to the large size of the image the error will be 
% small. You can check that.)
I_noisy(positions_for_zeroes) = 0; % These positions are set to zero.
% Do the same for ones.
positions_for_ones = find(uniform_numbers > proportion/2 & uniform_numbers <= proportion);
% Here it is important to exclude the uniform_numbers that satisfy
% uniform_numbers<proportion/2 because we just used them for the zeroes...
% uniform_numbers <= proportion can be replaced by e.g. 1-proportion/2,
% etc.
I_noisy(positions_for_ones) = 1;
I_noisy=reshape(I_noisy,size(I));
figure;imshow(I_noisy);title('Noisy image');

% Denoising. We will use a rectangle of length 2L+1.
% Be carefull with boundaries, as usual.
 .... A COMPLETER. 
figure;imshow(I_denoised);title('Denoised by median filter')

