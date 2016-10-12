function image = laplacianSharpening(image, n, epsilon)

  laplacien_x = ones(size(image));

  laplacien_y = laplacien_x;

  for i = 1 : n

    laplacien_x(1: end-1, :, : ) = image(1: end-1, :, :) - image(2: end, :, :);
    laplacien_x(1: end-1, :, : ) = laplacien_x(1: end-1, :, :) - laplacien_x(2: end, :, :);

    laplacien_y(:, 1: end-1, :) = image(:, 1: end-1, :) - image(:, 2: end, :);
    laplacien_y(:, 1: end-1, :) = laplacien_y(:, 1: end-1, :) - laplacien_y(:, 2: end, :);

    image = image - epsilon * (laplacien_x + laplacien_y);

  end
[a,b,c] = size(image);

a=a-2*n;
b=b-2*n;

new_image=zeros(a,b,3);
new_image(:,:,:)=image(n+1:end-(n),n+1:end-(n),:)


image=new_image;

end
