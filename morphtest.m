function [ ] = cardlocation(file,show)

I = imread(file);
%i = myjpgload(file,0);

disp('Starting adapt. Please wait.');
ad = adapt(file);
disp('Adapt finished.');

morph = ad;

% morph = bwmorph(morph,'open',9001);
% morph = bwmorph(morph,'erode',2);
% morph = bwmorph(morph,'dilate',2);
% se = strel('disk',2);
% morph = imopen(morph,se);

morph = cleanup(morph,2,2,0);


imshow(morph);