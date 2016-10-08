function image_recalee = recalage_zero(image,facteur)

[M, N, O] = size(image);
[halfRow, halfCol] = compute_center(M,N);


M2 = M*facteur; % Taille X de l'image J
N2 = N*facteur; % Taille Y de l'image J

p = zeros(M2, N2, O); % On cr�e la plus grande image vide

m2c = round(M2 * 0.5); % Centre X de p
n2c = round(N2 * 0.5); % Centre Y de p

mc = round(M * 0.5); % Centre X de image
nc = round(N * 0.5); % Centre Y de image

% Ins�rer J au centre de p
p((halfRow+1):(halfRow+M),(halfCol+1):(halfCol+N),:) = image(:,:,:);

image_recalee=p;
size(image_recalee)

end

