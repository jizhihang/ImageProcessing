function filtered = bilateral_filter(image,N,sigma_s,sigma_i)

res = zeros(size(image,1),size(image,2));

%calcul du kernel gaussien à valeurs constantes: distance relative des
%pixels
[X,Y] = meshgrid(-N:N,-N:N);
G = exp(-(X.^2+Y.^2)/(2*sigma_s^2));

for i = 1:size(image,1)
    %taille de la fenêtre variable en fonction de la proximité avec les bords
         iMin = max(i-N,1);
         iMax = min(i+N,size(image,1)); 
         
   for j = 1:size(image,2)
         
         jMin = max(j-N,1);
         jMax = min(j+N,size(image,2));
         
         window = image(iMin:iMax,jMin:jMax,:); %fenêtre glissante
      
         dr = window(:,:,1)-image(i,j,1);
         dg = window(:,:,2)-image(i,j,2);
         db = window(:,:,3)-image(i,j,3);
         
         %calcul du deuxieme kernel prenant en compte les valeurs
         %d'intensité des pixels,pour chaque canal de l'image
         H = exp(-(dr.^2+dg.^2+db.^2)/(2*sigma_i^2));
      
         %calcul de la formule
         val_win = H.*G((iMin:iMax)-i+N+1,(jMin:jMax)-j+N+1);
		 
		 %calcul de la constante de normalisation
		 norm_win = sum(val_win(:)); 
		 
		 %calcul du pixel associé sur les 3 canaux
         filtered(i,j,1) = sum(sum(val_win.*window(:,:,1))) / norm_win;
         filtered(i,j,2) = sum(sum(val_win.*window(:,:,2))) / norm_win;
         filtered(i,j,3) = sum(sum(val_win.*window(:,:,3))) / norm_win;
                
   end
end