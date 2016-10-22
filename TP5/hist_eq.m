clear all
close all
clc

%% import
matfiles = dir(fullfile('./images','*.*'));
images={};

for i=3 : numel(matfiles)
  images{i} = double(imread(matfiles(i).name))/255;
%images{i} = mean(images{i},3);
end

equalized = {};
for i=3:numel(images)
%for i=3:6
%souci avec images non en niveaux de gris
%     equalized{i} = histeq(images{1,i});
  figure;
 imhist(images{1,i});
 imshow(images{1,i});
end
% I=images{1,3};
% 
%     equalized = histeq(I);

