function [isRed] = findRedBlack(image,regions, props)
    
    image = double(image);

    R = image(:,:,1)+1;
    G = image(:,:,2)+1;
    B = image(:,:,3)+1;

    NormalizedRed = R(:,:)./sqrt(R(:,:).^2+G(:,:).^2+B(:,:).^2);
    NormalizedGreen = G(:,:)./sqrt(R(:,:).^2+G(:,:).^2+B(:,:).^2);
    NormalizedBlue = B(:,:)./sqrt(R(:,:).^2+G(:,:).^2+B(:,:).^2);

    norm(:,:,1) = NormalizedRed(:,:);
    norm(:,:,2) = NormalizedGreen(:,:);
    norm(:,:,3) = NormalizedBlue(:,:);
    
    %imshow(norm);
    
    [value,index] = min(props(:,2));
    
    region_index = props(index,1);
    
    myVec = int32(regions(region_index).BoundingBox);% [x, y, w, h]
    
    xmin = myVec(1);
    xmax = myVec(1) + myVec(3);
    ymin = myVec(2);
    ymax = myVec(2) + myVec(4);
    
    subimage = norm(ymin:ymax, xmin:xmax,:);
    
    R = sum(sum(subimage(:,:,1)));
    G = sum(sum(subimage(:,:,2)));
    B = sum(sum(subimage(:,:,3)));
    
    isRed = ((R/ (R+G+B)) > .45);
    
end