output_dir = 'output/';
I = double(imread('input/lena.bmp')) / 255;
disp('Deconvolution par division sans bruit')
sigma_conv = [3:0.5:5];
for s = sigma_conv
  I_hat = gaussianFilter(I, s, 0);
  title_ = [output_dir "deconvolution_sigma_" num2str(s) ".png"];
  % figure; title(title_); imshow(I_hat);
  imwrite(I_hat, title_);
end

disp('Deconvolution par filtre Wiener avec bruit')

for s_n = [10:15] %sigma_noise
    for s_c = [3.5] %sigma_conv
        for lambda = [1]
      	  I_wiener = wienerFilter(I, s_c, s_n, lambda);
  	      figure;
  	      title_ = [output_dir "deconvolution_wiener_sigma_g_" num2str(s_c) "_noise_" num2str(s_n) "_lambda_" num2str(lambda) ".png"];
  	      %imshow(I_wiener);
          imwrite(I_wiener, title_);
        end
    end
end
