% Charger deux images prises du meme angle mais avec des durees d'exposition differentes.
u_1 = double(imread("images/P1.jpg"))/255;
u_2 = double(imread("images/P2.jpg"))/255;

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

imwrite(u_midway_2, "output/P1M.png");
imwrite(u_midway_1, "output/P2M.png");

figure;
imhist(u_midway_2);
figure;
imhist(u_midway_1);

pause
