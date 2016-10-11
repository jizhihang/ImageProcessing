
image = double(imread("input/Monet_Les_Nymphéas.jpg")) / 255;
figure; title("Monet Les Nymphéas");
imshow(image);


sharped = laplacianSharpening(image, 3, 0.4);

figure; title("Laplacian Sharpening");
imshow(sharped);


unzoom = 1.01;
sig = 0.8 * sqrt(unzoom^2 -1);
gaussianFiltered = gaussianFilter(image, sig);
figure; title("Gaussian filtering");
imshow(gaussianFiltered);


pause
