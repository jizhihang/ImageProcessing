function image = laplacianSharpening(image, n)

  laplacien_x = zeros(size(image));
  laplacien_y = laplacien_x;

  for i = 1 : n

    laplacien_x(1: end-1, :) = image(1: end-1, :) - image(2: end, :);
    laplacien_x(1: end-1, :) = laplacien_x(1: end-1, :) - laplacien_x(2: end, :);

    laplacien_y(:, 1: end-1) = image(:, 1: end-1) - image(2: end, :);
    laplacien_y(:, 1: end-1) = laplacien_y(:, 1: end-1) - laplacien_y(:, 2: end);

    image = image - (laplacien_x + laplacien_y);

  end

endfunction
