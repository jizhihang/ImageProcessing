function I_translated = translation_vect(image, vect)


I= image;

DFT2d_I=fft2(I); % compute DTF
[M , N, nb_color_channels]=size(I); % image size to get frequency grid.

T=vect;

%%% ALTERNATIVE TO THE LOOP %%%%
Nr = ifftshift((-fix(M/2):ceil(M/2)-1));
Nc = ifftshift((-fix(N/2):ceil(N/2)-1));
[Nc,Nr] = meshgrid(Nc,Nr);
DFT2d_I_translated=DFT2d_I.*repmat(exp(-1i*2*pi*(T(1)*Nr/M+T(2)*Nc/N)),[1,1,nb_color_channels]);

% At this point DFT2d_I_translated contains de DFT coefficient of the
% translated version of I.

% now, inverse transform and display
I_translated=ifft2(DFT2d_I_translated);
I_translated=real(I_translated);

%size(I_translated)
% Due to rounding errors I_with_modulus_of_J can have very small
% but non zero imaginary part. We want a real image for displaying.
% figure; imshow(I);title('Original image I'); 
% figure(2); imshow(I_translated); title('I translated');

end

