% Charger deux images prises du meme angle mais avec des temps d'exposition differents..
u_1 = mean(double(imread("input/NotreDame1.tif"))/255, 3);
u_2 = mean(double(imread("input/NotreDame2.tif"))/255, 3);

u_midway_1 = zeros(size(u_1));
u_midway_2 = zeros(size(u_2));

[u_sort_1, index_u_1] = sort(u_1(:));
[u_sort_2, index_u_2] = sort(u_2(:));
u_midway_1(index_u_1) = (u_sort_1 + u_sort_2)/2;
u_midway_2(index_u_2) = (u_sort_1 + u_sort_2)/2;

u_midway_1 = reshape(u_midway_1, size(u_1));
u_midway_2 = reshape(u_midway_2, size(u_2));

% On pourrait a la limite faire passer le test suivant:
% assert(u_midway_2, u_midway_1);
imwrite(u_midway_2, "NotreDame2M.png");
imwrite(u_midway_1, "NotreDame1M.png");