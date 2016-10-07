function padded = zeroPadding(image, nPadding)

  ftImage = fft2(image);
  
  nRow = size(image, 1);
  nCol = size(image, 2);
           
  padded=[ftImage(1:nRow / 2, 1:nCol/2), zeros(nRow / 2, nPadding(1)), ftImage(1:nRow / 2, nCol/2 +1 : nCol)];
  
  padded=[padded; zeros(nPadding(2), size(padded, 2))];
  
  padded=[padded; ftImage(nRow / 2 + 1:nCol, 1:nCol/2), zeros(nRow / 2, nPadding(1)), ftImage(nRow /2 +1:nRow, nCol / 2 + 1:nCol)];
    
  padded =real( ifft2(padded)) / 255 ;
  
end
