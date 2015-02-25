function [ ] = filter_image_by_regions( regions, binary_image, show )
%FILTER_IMAGE_BY_REGIONS Takes the regions struct produced by regionprops
%and an image and displays a new image of only the 'relevant' regions of the
%original image at the figure specificied by show
%   Relevance of the symbols is determined by two heuristics
%   1. Is the area of the region over 100 pixels
%   2. If the ratio of the width and height of bounding box of the symbol is between .5 and 2
%       N.B. This eliminates long regions that are usually shadows and
%       often not relevant
[width, height] = size(binary_image);

%Create an all black image
new_image = zeros(width, height);

%iterate over the provided regions and add the symbol to the new image if
%it passes the creteria
for j = 1:length(regions)
    bbwidth = regions(j).BoundingBox(3);
    bbheight = regions(j).BoundingBox(4);
    bbratio = min(bbwidth/bbheight, bbheight/bbwidth);
    %check to see if subimage isn't simply pixel noise
    if((regions(j).Area > 100) && (bbratio>.5))
    
        myVec = int32(regions(j).BoundingBox);% [x, y, w, h]

        xmin = myVec(1);
        xmax = myVec(1) + myVec(3);
        ymin = myVec(2);
        ymax = myVec(2) + myVec(4);

        %pull out subimage from the boundingbox
        subimage = binary_image(ymin:ymax, xmin:xmax);
        new_image(ymin:ymax,xmin:xmax) = subimage;
    end

end
if(show > 0)
    figure(show);
    imshow(new_image);
end
end

