
image = double(imread("input/Monet_Les_Nymphéas.jpg")) / 255;
figure; title("Monet Les Nymphéas");
imshow(image);


sharped = laplacianSharpening(image, 3, 0.4);

figure; title("Laplacian Sharpening");
imshow(sharped);


pause
