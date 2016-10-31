disp("inversion d'image")

source = double(imread('input/lena.bmp')) / 255;
dest = double(imread('input/barbara.png')) / 255;

figure;title('source');
imshow(source);
figure;title('destination')
imshow(dest);

phaseSwappedImg = swapPhase(source, dest);
figure;title('Phase swapping')
imshow(phaseSwappedImg)
imwrite(phaseSwappedImg, "output/phase_swapping.jpg");

phaseInsideRandom = swapPhase(source, double(randn(size(source))));
figure;title('Phase inside random')
imshow(phaseInsideRandom)

imwrite(phaseInsideRandom, "output/phase_swapping_in_random.jpg");

phaseInsideWhite = swapPhase(source, double(0.5 * ones(size(source))));
figure;title('Phase inside in grey image')
imshow(phaseInsideWhite)
imwrite(phaseInsideWhite, "output/phase_swapping_in_grey_image.jpg")


phaseInsideGrad = swapPhase(source, double(mesh));
figure;title('Phase inside gradient')
imshow(phaseInsideGrad)
imwrite(phaseInsideGrad, "output/phase_swapping_in_gradient.jpg");


moduleSwappedImg = swapModule(source, dest);
figure;title('Module swapping')
imshow(moduleSwappedImg)
imwrite(moduleSwappedImg, "output/module_swapping.jpg")


moduleSwappedImg = swapModule(source, double(randn(size(source))));
figure;title('Module swapping in grey image')
imshow(moduleSwappedImg)
imwrite(moduleSwappedImg, "output/module_swapping_in_grey_image.jpg")
pause
