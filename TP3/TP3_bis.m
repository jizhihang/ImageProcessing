clear all
close all
clc

theta = 30 * (pi / 180);

imageName = "castle_bruite.png";


image = double(imread(['images_bruitees/', imageName])) / 255;

disp('embedding image in a larger one for rotation');
image = recalage_zero(image,2);

disp('rotating image');
image = rotation(image, theta);


% p=real(p);
figure;
imshow(image);title('Image au centre')

imwrite(image,['output/' + imageName]);