clear all
close all
clc

theta=30*(pi/180);

%image import
image = double(imread('images_bruitees/castle_bruite.png'))/255;
% imshow(image)
%centering in a twice-bigger black image
image = recalage_zero(image,2);
[M,N,O] = size(image);
[halfRow, halfCol] = compute_center(M,N);

%3 translations according to the Yaroslavski formula

size(image)
%first translation
for i=1:N
    
vect_transl = [-(i-halfCol)*tan(theta/2), 0];


translation = translation_vect(image(:,i,:),vect_transl);

%size(translation)
image(:,i,:)=translation;

end 
% second translation

for i=1:M
    
vect_transl = [0, (i-halfRow)*sin(theta)];

image(i,:,:)=translation_vect(image(i,:,:),vect_transl);

end 

% Third translation

for i=1:N
    
vect_transl = [-(i-halfCol)*tan(theta/2), 0];

image(:,i,:)=translation_vect(image(:,i,:),vect_transl);

end 


% p=real(p);
figure;
imshow(image);title('Image au centre')

imwrite(image,'output/lena_rotation.png')