function [ bin ] = cardlocation( file, old_thresh )
%REGIONCARD Summary of this function goes here
%   Detailed explanation goes here

% Load image
i = myjpgload(file,1);

disp('Starting adapt. Please wait.');
ad = adapt(file);
disp('Adapt finished.');

morph = bwmorph(ad,'open',16);
%imshow(morph);

%imshow(ad);

bin = morph;

% Finds regions
%label = bwlabel(morph,4);
%card = regionprops(label,['basic']);
%}


end