function [  ] = findSymbols( regions, bin_image )
%given the regions of the image, calculate the compactness of all of the
%regions to determine which symbols are the card


image_prop_matrix = zeros(length(regions), 3);
%iterate over the bounding boxes of the regions

for j = 1:length(regions)
    
    myVec = int32(regions(j).BoundingBox);% [x, y, w, h]
    
    xmin = myVec(1);
    xmax = myVec(1) + myVec(3);
    ymin = myVec(2);
    ymax = myVec(2) + myVec(4);
    
    %pull out subimage from the boundingbox
    %subimage = bin_image(133:138, 231:234)
    subimage = bin_image(ymin:ymax, xmin:xmax);
    figure(j);
    imshow(subimage);
    %get properties of the subimage
    prop = getproperties(subimage);
    %add these properties to a matrix
    image_prop_matrix(j, :) = prop;
    

end

%for now just print the matrix
disp(image_prop_matrix);

end

