function [ regions, morphed_image ] = cardlocation(file,show)
%REGIONCARD Summary of this function goes here
%   Detailed explanation goes here

% Load image
I = imread(file);
%i = myjpgload(file,0);

disp('Starting adapt. Please wait.');
ad = adapt(file);
disp('Adapt finished.');

morphed_image = bwmorph(ad,'open',1);
%imshow(morph);

%imshow(ad);

% Finds regions
label = bwlabel(morphed_image,4);
regions = regionprops(label,['basic']);

% Find bounding box
% Find top left corner

[w,h]=size(morphed_image);

tlX = w-1;
tlY = h-1;
brX = 0;
brY = 0;

for j = 1:length(regions)
        
    myVec = regions(j).BoundingBox;
    
    if myVec(1)<tlX
        tlX = myVec(1);
    end
    if myVec(2)<tlY
        tlY = myVec(2);
    end
    
    if (myVec(1)+myVec(3))>brX
        brX = myVec(1)+myVec(3);
    end
    if (myVec(2)+myVec(4))>brY
        brY = myVec(2)+myVec(4);
    end
    
end

width = brX-tlX;
height = brY-tlY;

boundingBox = [tlX,tlY,width,height];

%num = figure;
%figure(num);
%imshow(morph);

shapeInserter = vision.ShapeInserter('Shape','Rectangles','BorderColor','Custom','CustomBorderColor', uint8([255 0 0]));

%rectangle('Position',boundingBox);

boxed_image = step(shapeInserter, I, int32(boundingBox));

if show > 0
    imshow(boxed_image);
end
