function translated = translateImage(image, translation)

  ftImage = fft2(image);
  
  
%   plot2D_FFT(ftImage)
  
  ftImage = fftshift(ftImage);    
  translated = ftImage;
  
  %expFactors = exp(i * 2 * pi / N ) * ones(size(ftImage));
  %expFactors(1, :) = 1;
  %expFactors(:, 1) = 1;
  
  nRow = size(ftImage, 1);
  nCol = size(ftImage, 2);
  
   
  MINUS_TWO_I_PI = - 2 * i * pi ;
  ROW_EXP_FACTOR = translation(1) * MINUS_TWO_I_PI / nRow;
  COL_EXP_FACTOR = translation(2) * MINUS_TWO_I_PI / nCol;
  
  for r = 1 : nRow  
    for c = 1: nCol           
      translated(r,c) = translated(r,c) * exp(ROW_EXP_FACTOR * (r - 1)) * exp(COL_EXP_FACTOR * (c - 1)) ;
    end
  end

   
  %expFactors = cumprod(cumprod(expFactors, 2), 1);
  %expFactors(length(expFactors));
  %expFactors = ones(size(ftImage));
  
  %translated = ftImage .* expFactors;
  translated = ifftshift(translated);
  translated = real(ifft2(translated));
  
  translated = translated / 255;
 
    end


