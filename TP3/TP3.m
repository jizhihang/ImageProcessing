clear all
close all
clc

image = double(imread('input/castle_bruite.png')) / 255;
image = rotation(image, 2 * pi / 3);
figure;
imshow(image);title("Rotation d'image de pi/3")

disp('appuyez sur une touche pour continuer')
pause

disp('Rotating the Image N time by 2*pi / N')
nRotation = 5;
theta = 2 * pi / nRotation;
image = double(imread('input/lena.bmp')) / 255;

for i = 1 : nRotation
    
    image = rotation(image, theta);
    figure;
    imshow(image);title(['N rotation de 2pi /', nRotation, " rotation n0" , i] );
    imwrite(image, ['output/rotation_2pi_', int2str(i), ".png" ])
   
end

pause
