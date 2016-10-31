function image = swapModule(src, dest)

  if (sum(size(src) != size(dest)) > 0 )
    (sum(size(src) != size(dest)) > 0 )
    error('images must have same sizes')
    return

  end

  src = fft2(src);
  dest = fft2(dest);

  image = abs(src) .* exp(i * arg(dest));
  image = ifft2(image);
  image = real(image);

end
