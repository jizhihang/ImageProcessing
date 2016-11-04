% Changes image saturation by given factor
function boosted =  saturationBoost(I, boost_factor)

  boosted = rgb2hsv(I);

  boosted(:, :, 2) = boosted(:, :, 2) * boost_factor;

  %remove values above after h boosting
  %can do this because all h,s and v values are below 1;
  overOne = find(boosted > 1);

  boosted(overOne) = 1;

  boosted = hsv2rgb(boosted);

end
