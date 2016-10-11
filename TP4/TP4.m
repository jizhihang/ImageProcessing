
image = double(imread("input/Monet_Les_Nymphéas.jpg"));

sharped = laplacianSharpening(image, 3);

figure; title("Laplacian Sharpening");
imshow(sharped);
