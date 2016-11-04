function scaledImage = affineContrast(image)

  [nR, nC, nCh] = size(image);
  scaledImage = zeros(size(image));
  for k = 1: nCh

    max_ = max(max(image(:, :, k)));
    min_ = min(min(image(:, :, k)));

    scaledImage(:, :, k) = (image(:, :, k) - min_)/(max_ - min_);

  end

end
