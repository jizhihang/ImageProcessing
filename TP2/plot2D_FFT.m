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

end

