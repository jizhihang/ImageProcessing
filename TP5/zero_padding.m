function [zero_padded] = zero_padding(I, zoom_factor)

 DFT2d_I=fft2(I);

 [M , N, nb_color_channels]=size(I);

 DFT2d_I_padded=zeros(floor(M*zoom_factor),floor(N*zoom_factor),nb_color_channels);

 DFT2d_I_padded(1:floor(M/2),1:floor(N/2),:)=DFT2d_I(1:floor(M/2),1:floor(N/2),:);

 DFT2d_I_padded(1:floor(M/2),end:-1:end-floor(N/2)+1,:)=DFT2d_I(1:floor(M/2),end:-1:floor(N/2)+1,:);

 DFT2d_I_padded(end:-1:end-floor(M/2)+1,1:floor(N/2),:)=DFT2d_I(end:-1:floor(M/2)+1,1:floor(N/2),:);

 DFT2d_I_padded(end:-1:end-floor(M/2)+1,end:-1:end-floor(N/2)+1,:)=DFT2d_I(end:-1:floor(M/2)+1,end:-1:floor(N/2)+1,:);

 DFT2d_I_padded=DFT2d_I_padded*floor(M*zoom_factor)*floor(N*zoom_factor)/(M*N);
 I_zoomed=ifft2(DFT2d_I_padded);
 zero_padded=real(I_zoomed);

end

function img = implicitTCDZoom(I, zoom)

  [nRow, nCol] = size(I);

  symetry = [I(1:end, 1:end, :), I(1:end, end:-1, :); ..
             I(end:-1:1, 1:end, :), I(end :-1:1, end:-1:1,:)];

  figure;imshow(symetry);

  img = zeroPaddingZoom(symetry, zoom);

  img = img(1:nRow, 1:nCol);

end

img = imread("images/castles");
zeroPaddingZoom = zero_padding(img, 2);

figure;
subplot(1, 2, 1);
imshow(zeroPaddingZoom, zoom);
subplot(1, 2, 2);
imshow(implicitTCDZoom, zoom);

//OMG NO OSCILLATION.
