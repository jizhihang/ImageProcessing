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

function result = implicitTCDZoom(I, zoom)

  [nRow, nCol, nChannel] = size(I);

  symmetrie_miroir = [I(1:nRow, 1:nCol, :), I(1:nRow, nCol:-1:1, :); I(nRow:-1:1, 1:nCol, :), I(nRow :-1:1, nCol:-1:1,:)];

  img = zero_padding(symmetrie_miroir, zoom);

  result = img(1:floor(nRow*zoom), 1:floor(nCol*zoom), :);

end

img = double(imread("images/flowers.bmp"))/255;

zoom=2;
zeroPaddingZoom = zero_padding(img, zoom);

%figure;
%subplot(1, 2, 1);
%imshow(zeroPaddingZoom);
%title('Zero padding ')
%subplot(1, 2, 2);
%title('Implicit TCD')
tcd_im = implicitTCDZoom(img, zoom);
%imshow(tcd_im);

imwrite(zeroPaddingZoom, "output/flowersZeroPadding.png");
imwrite(tcd_im, "output/flowersTCD.png");