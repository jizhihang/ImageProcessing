function image = randomImage(average, standard_dev, size)

  image = normrnd(average, standard_dev, size(1), size(2), size(3));

  for i = 1: size(3)

    maximum = max(max(image(:, :, i)));
    minimum = min(min(image(:, :, i)));
    image(:,:, i) = (image(:, :, i) - minimum) / ( maximum - minimum );

  end
end

size = [256, 256, 3];

figure;
subplot(2, 2, 1);
img = randomImage(1/2, 1/100, size);
min(min(img(:,:, 1)))
max(max(img(:,:, 1)))

imshow(img);
title("random image std=1/100")

subplot(2, 2, 2);
img = randomImage(1/2, 1/10, size);
min(min(img(:,:, 1)))
max(max(img(:,:, 1)))
imshow(img);
title("random image std=1/10")

subplot(2, 2, 3)
img = randomImage(1/2, 1, size);
min(min(img(:,:, 1)))
max(max(img(:,:, 1)))
imshow(img);
title("random image std=1")

pause
