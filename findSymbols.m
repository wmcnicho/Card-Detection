function [ image_prop_matrix ] = findSymbols( regions, bin_image, show )
%FINDSYMBOLS Takes the regions struct produced by regionprops
%and a binary image and generates a property matrix of all the 'relevant' regions of the
%original image. Optionally show the filtered image at the figure
%specificied by show. 0
%   Relevance of the symbols is determined by two heuristics
%   1. Is the area of the region over 100 pixels
%   2. If the ratio of the width and height of bounding box of the symbol is between .5 and 2
%       N.B. This eliminates long regions that are usually shadows and
%       often not relevant

%Create an all black image
[width, height] = size(binary_image);
new_image = zeros(width, height);

image_prop_matrix = zeros(length(regions), 4);

%iterate over the bounding boxes of the regions
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
        subimage = bin_image(ymin:ymax, xmin:xmax);
        %get properties of the subimage
        prop = getproperties(subimage);
        %add these properties to a matrix
        image_prop_matrix(j, :) = [j, prop];

        %add the subimage to the new image
        new_image(ymin:ymax,xmin:xmax) = subimage;
    end

end
%remove 0 rows from matrix i.e. the irrelevant regions
image_prop_matrix(any(image_prop_matrix==0,2),:) = [];


if(show > 0)
    figure(show);
    imshow(new_image);
end

end

