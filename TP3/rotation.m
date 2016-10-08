
%image rotation using Yarovslavsky algorithm:
%The rotation is decomposed in three axis parallel translation
%image: NxMxC matrix where C can be color channels
%theta: angle in radian
function image = rotation(image, theta)

  image = recalage_zero(image, 2);
  
  THETA_ON_HALF = theta / 2;  
  
  [M,N,O] = size(image);
  [halfRow, halfCol] = compute_center(M,N);

  %first translation
  for i=1:N
        
    vect_transl = [- (i-halfCol) * tan(THETA_ON_HALF), 0]; 
    image(:,i,:) = translation_vect(image(:,i,:), vect_transl);

  end 
  
  % second translation
  for i=1:M
      
    vect_transl = [0, (i-halfRow) * sin(theta)];

    image(i,:,:) = translation_vect(image(i,:,:), vect_transl);

  end 

  % Third translation
  for i=1:N
      
    vect_transl = [-(i-halfCol)*tan(THETA_ON_HALF), 0];
    image(:,i,:) = translation_vect(image(:,i,:),vect_transl);

  end

end