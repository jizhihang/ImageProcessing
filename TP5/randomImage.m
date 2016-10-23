
function image = randomImage(average, standard_dev, size)
  % Tirage de size(1) * size(2) * size(3) variables aléatoires suivant Normale(mu, sigma)
  image = normrnd(average, standard_dev, size(1), size(2), size(3));

  % Per-channel feature scaling [minimum, maximum] -> [0, 1] 
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
%imwrite(img, "noise001.png");
imshow(img);
title("random image std=1/100")

subplot(2, 2, 2);
img = randomImage(1/2, 1/10, size);
imshow(img);
%imwrite(img, "noise01.png");
title("random image std=1/10")

subplot(2, 2, 3)
img = randomImage(1/2, 1, size);
imshow(img);
%imwrite(img, "noise10.png");
title("random image std=1")

pause
