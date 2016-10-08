clear all
close all
clc


image = double(imread('input/castle_bruite.png')) / 255;

rotated_image = rotation(image, 2 *pi / 8);
figure;
imshow(rotated_image);title("Rotation d'image de 2 * pi/8")
imwrite(rotated_image, ["output/castle_bruite_2pi_over_8.png"]);




image = double(imread('input/house.png')) / 255;

rotated_image = rotation(image, 2 *pi / 3);
figure;
imshow(rotated_image);title("Rotation d'image de 2 * pi/3")
imwrite(rotated_image, ["output/house_rotation_2pi_over_3.png"]);

rotated_image = rotation(image, 2 * pi / 7 );
figure;
imshow(rotated_image);title("Rotation d'image de 2 * pi/7")
imwrite(rotated_image, ["output/house_rotation_2pi_over_7.png"]);

rotated_image = rotation(image, pi);
figure;
imshow(rotated_image);title("Rotation d'image de pi")
imwrite(rotated_image, ["output/house_rotation_pi.png"]);

disp("rotations successives d'un même image. Attention long...")
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
