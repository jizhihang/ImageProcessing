%clear all;
%close all;
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

function [halfRow halfCol] = compute_center(nRow, nCol)
  if (mod(nRow, 2) == 1)
    halfRow = (nRow -1) / 2;    
  else
    halfRow = nRow / 2;  
  endif
  if (mod(nCol, 2) == 1)
    halfCol = (nCol - 1) / 2;
  else
    halfCol = nCol / 2;
  endif
end

function translated = translateImage(image, translation)

  ftImage = fft2(image);
  %plot2D_FFT(ftImage);
  %ftImage = fftshift(ftImage);    
  translated = zeros(size(ftImage));
  
  %expFactors = exp(i * 2 * pi / N ) * ones(size(ftImage));
  %expFactors(1, :) = 1;
  %expFactors(:, 1) = 1;
  
  nRow = size(ftImage, 1); %N
  nCol = size(ftImage, 2); %M
  [halfRow halfCol] = compute_center(nRow, nCol)
   
  MINUS_TWO_I_PI =  - 2 * i * pi ;
  ROW_EXP_FACTOR = translation(1) * MINUS_TWO_I_PI / nRow;
  COL_EXP_FACTOR = translation(2) * MINUS_TWO_I_PI / nCol;
       
  for r = 1:halfRow
   
    for c = 1:halfCol
    
      translated(r,c, :) = ftImage(r, c, :) * exp(ROW_EXP_FACTOR * (r - 1 - nRow)) ...
                                            * exp(COL_EXP_FACTOR * (c - 1 - nCol));
      
    endfor
    
    for c = halfCol+1:nCol
    
      translated(r,c, :) = ftImage(r, c, :) * exp(ROW_EXP_FACTOR * (r - 1)) ... 
                                            * exp(COL_EXP_FACTOR * (c - 1 - nCol));
    
    endfor
    
  endfor
  
  for r = halfRow+1:nRow
    
    for c = 1: halfCol
    
      translated(r,c, :) = ftImage(r, c, :) * exp(ROW_EXP_FACTOR * (r - 1 - nRow)) ...
                                            * exp(COL_EXP_FACTOR * (c - 1));
      
    endfor
    
    for c = halfCol+1:nCol
    
      translated(r,c, :) = ftImage(r, c, :) * exp(ROW_EXP_FACTOR * (r - 1 )) ...
                                            * exp(COL_EXP_FACTOR * (c - 1 ));
    
    endfor
         
  endfor
  
  %expFactors = cumprod(cumprod(expFactors, 2), 1);
  %expFactors(length(expFactors));
  %expFactors = ones(size(ftImage));
  
  %translated = ftImage .* expFactors;
  %translated = ifftshift(translated);
  translated = real(ifft2(translated));
  
  translated = translated / 255;
 
endfunction 

function I_hat_zoom = zeroPadding(image, zoom)
  [H W nComp] = size(image);
  [H2, W2] = deal(round(zoom * H), round(zoom * W));
  [Hc Wc] = compute_center(H, W);
  
  I_hat_zoom = zeros(H2,W2, nComp);
  % Fast Fourier Transform
  I_hat = fft2(image);
  
  I_hat_zoom(1:Hc, 1:Wc, :) = I_hat(1:Hc, 1:Wc, :);
  I_hat_zoom(1:Hc, W2-Wc+1:W2, :) = I_hat(1:Hc, Wc+1:W, :);
  I_hat_zoom(H2-Hc+1:H2, 1:Wc, :) = I_hat(Hc+1:H, 1:Wc, :);
  I_hat_zoom(H2-Hc+1:H2, W2-Wc+1:W2, :) = I_hat(Hc+1:H, Wc+1:W, :);
  
  % Back to image space
  I_hat_zoom = zoom^2 * real(ifft2(I_hat_zoom)) / 255;
endfunction

%%% --------------------- Patch extraction (Care: No size checks)

% Helper function to get a patch of (w, h) from the image
% with specified patch center.
function subimg = patch(image, center_coords, side_size)
  half_side = compute_center(side_size, side_size);
  topLeft = center_coords - half_side;
  bottomRight = center_coords + half_side;
  if(mod(side_size, 2)==0)
    topLeft = topLeft + 1;
  endif
  subimg = image(topLeft(1):bottomRight(1), topLeft(2):bottomRight(2), :);
endfunction

% Return a patch given the top left coordinates and a patch size.
function subimg = patch2(image, topLeft, patch_size)
  bottomRight = topLeft + patch_size - 1
  subimg = image(topLeft(1):bottomRight(1), topLeft(2):bottomRight(2), :);
endfunction

% Return a patch with some specified size from the center of the image.
function subimg = centered_patch(image, side_size)
  [width height components] = size(image);
  [Wc Hc] = compute_center(width, height);
  subimg = patch(image, [Wc Hc], side_size);
endfunction

%%% --------------------- Testing functions

function testTranslation(img, translation)
  a = translateImage(img, translation);
  figure;imshow(a); title('Translated')
endfunction

function testZoom(name, img, zoom)
  a = zeroPadding(img, zoom);
  figure;imshow(a); title('Zoomed')
  filename = sprintf('images/%s-%dx%d-zoomed-%d.png', ...
                      name, size(img, 1), size(img, 2), zoom);
  imwrite(a, filename);
endfunction

function testPatch(img)
  patch = centered_patch(img, 257);
  figure; imshow(patch);title('Center Patch');
endfunction

function testPatch2(img)
  patch = patch2(img, [100 100], 256);
  size(patch)
  figure; imshow(patch);title('Patch');
endfunction

%%% --------------------- Main

% --- Load an image
filename = 'flowers.bmp';
img = imread(sprintf('images/%s', filename));
im_name = cell2mat(strsplit(filename, '.')(1,1));
figure;imshow(img);title('Original');

% --- Test patch extraction
%testPatch2(img);
patch = centered_patch(img, 256);

% --- Test translation
translation1 = [50, 50];
translation2 = [50.5, 50.5];
testTranslation(img, translation1);
testTranslation(img, translation2);

% --- Test zoom
zooms = [2];
for i=1:size(zooms,2)
  testZoom(im_name, patch, zooms(i));
endfor