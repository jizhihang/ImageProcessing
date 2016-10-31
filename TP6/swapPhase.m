function image = swapPhase(src, dest)

  if (sum(size(src) != size(dest)) > 0 )
    error('images must have same sizes')
    return

  end

  src = fft2(src);
  dest = fft2(dest);

  image = abs(dest) .* exp(i * arg(src));
  image = ifft2(image);
  image = real(image);
end


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
