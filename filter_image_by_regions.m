function [ ] = filter_image_by_regions( regions, binary_image, show )
%FILTER_REGIONS Takes the regions 

[width, height] = size(binary_image);
new_image = zeros(width, height);

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

