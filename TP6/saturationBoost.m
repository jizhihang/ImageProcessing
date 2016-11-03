% Changes image saturation by given factor
function saturationBoost(I, boost_factor)
% Changement de l'espace de couleurs
I_hsv = rgb2hsv(I);
% Boost de la saturation
I_hsv(:, :, 2) = I_hsv(:, :, 2) * boost_factor;
I_hsv(:, :, 2) =(I_hsv(:, :, 2) - min(min(I_hsv(:, :, 2)))) / (max(max(I_hsv(:, :, 2))) - min(min(I_hsv(:, :, 2))));

figure; title('Image with saturation boosted');
imshow(hsv2rgb(I_hsv));

end