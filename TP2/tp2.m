
addpath(pwd)


function plot2D_FFT(fft)

  %fft = fftshift(fft); % Center FFT
  figure(3)
  shifted_fft = fftshift(fft);
  shifted_fft = abs(shifted_fft); 
  shifted_fft = log(shifted_fft+1); 
  shifted_fft = mat2gray(shifted_fft);
  
  imshow(shifted_fft)
  
  fft = abs(fft); 
  fft = log(fft+1); 
  fft = mat2gray(fft);

  figure(4);
  imshow(fft);

endfunction 


function translated = translateImage(image, translation)

  ftImage = fft2(image);
  
  
  plot2D_FFT(ftImage)

  %plot2D_FFT(ftImage);
  
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
    endfor
  endfor

   
  %expFactors = cumprod(cumprod(expFactors, 2), 1);
  %expFactors(length(expFactors));
  %expFactors = ones(size(ftImage));
  
  %translated = ftImage .* expFactors;
  translated = ifftshift(translated);
  translated = real(ifft2(translated));
  
  translated = translated / 255;
 
endfunction 

function padded = zeroPadding(image, nPadding)

  ftImage = fft2(image);
  
  nRow = size(image, 1);
  nCol = size(image, 2);
           
  padded=[ftImage(1:nRow / 2, 1:nCol/2), zeros(nRow / 2, nPadding(1)), ftImage(1:nRow / 2, nCol/2 +1 : nCol)];
  
  padded=[padded; zeros(nPadding(2), size(padded, 2))];
  
  padded=[padded; ftImage(nRow / 2 + 1:nCol, 1:nCol/2), zeros(nRow / 2, nPadding(1)), ftImage(nRow /2 +1:nRow, nCol / 2 + 1:nCol)];
    
  padded =real( ifft2(padded)) / 255 ;
  
endfunction


lena = imread("images/lena.bmp");
figure(1);
imshow(lena);

translation = [50.5, 50.5];
a = translateImage(lena, translation);

figure(2);
imshow(a);

zoom = size(lena);
a = zeroPadding(lena, zoom);
s = size(a)
figure(6)
imshow(a)

s= [s, 3]
b = zeros(s);
b(:,:, 1) = a;
b(:,:, 2) = a;
b(:,:, 3) = a;
imwrite(b, "images/lena-zoomed.bmp");
