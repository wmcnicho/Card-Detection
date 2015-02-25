function [ regions, morphed_image ] = cardlocation(file,show)
%CARDLOCATION Given a jpg image of a card finds the regions of the symbols
%and numbers and outputs an adjusted binary image separating
%symbols/numbers from the background. Optionally shows a region on the
%orginal image where the card region is detected
%   This technique uses adaptive thresholding and a bwmorph open to isolate
%   the symbols from the image. See bwmorph and adapt for more information.

% Load image
I = imread(file);

%run adaptive thresholding, this takes roughly 30 seconds
disp('Running adaptive thresholding on image. Please wait.');
ad = adapt(file);
disp('Thresholding finished.');

%run morph to remove thin lines from image
morphed_image = bwmorph(ad,'open',1);

% Finds regions
label = bwlabel(morphed_image,4);
regions = regionprops(label,['basic']);

[w,h]=size(morphed_image);


%Find the top leftmost and bottom rightmost point of all of the bounding boxes
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

%Using these two points draw a box around the symbol regions
%   i.e. draw a box around the card
width = brX-tlX;
height = brY-tlY;
boundingBox = [tlX,tlY,width,height];
shapeInserter = vision.ShapeInserter('Shape','Rectangles','BorderColor','Custom','CustomBorderColor', uint8([255 0 0]));
boxed_image = step(shapeInserter, I, int32(boundingBox));

if show > 0
    imshow(boxed_image);
end
