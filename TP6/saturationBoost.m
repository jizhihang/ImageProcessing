% Changes image saturation by given factor
function saturationBoost(I, boost_factor)
% Changement de l'espace de couleurs
I_hsv = rgb2hsv(I);
% Boost de la saturation
I_hsv(:, :, 2) *= boost_factor;

figure; title('Image with saturation boosted');
imshow(hsv2rgb(I_hsv));

end