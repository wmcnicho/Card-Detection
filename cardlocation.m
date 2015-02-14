function [ regions ] = cardlocation( file, old_thresh )
%REGIONCARD Summary of this function goes here
%   Detailed explanation goes here

% Load image
i = myjpgload(file,1);

disp('Starting adapt. Please wait.');
ad = adapt(file);
disp('Adapt finished.');

morph = bwmorph(ad,'open',16);
imshow(morph);

% Finds regions
label = bwlabel(morph,4);
regions = regionprops(label,['basic']);

% Find bounding box
% Find top left corner

[w,h]=size(morph);

tlX = w-1;
tlY = h-1;
brX = 0;
brY = 0;

for j = 1:length(regions)
    
    [x,y,w,h] = regions.BoundingBox(n);
    
    if x<tlX
        tlX = x;
    end
    if y<tlY
        tlY = y;
    end
    
    if (x+w)<brX
        brX = x+w;
    end
    if (y+h)<brY
        brY = y+h;
    end
    
end

width = brX-tlX;
height = brY-tlY;

boundingBox = [tlX,tlY,width,height]
    