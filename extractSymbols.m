function [numberIm, symbolIm, subPropsNumbers, subPropsSymbols] = extractSymbols( image, regions, props, isRed )

    [value,index] = max(props(:,2));
    
    sortedprops = sortrows(props,2);
    [rows,columns] = size(sortedprops);
    subPropsNumbers = sortedprops(rows-1:rows,:);
    subPropsSymbols = sortedprops(1:rows-2,:);
    
    region_index = props(index,1);
    
    myVec = int32(regions(region_index).BoundingBox);% [x, y, w, h]
    
    xmin = myVec(1);
    xmax = myVec(1) + myVec(3);
    ymin = myVec(2);
    ymax = myVec(2) + myVec(4);
    
    numberIm = image(ymin:ymax, xmin:xmax);
    numberProps = props(index,:);
    
    [value,index] = min(props(:,2));
    
    region_index = props(index,1);
    
    myVec = int32(regions(region_index).BoundingBox);% [x, y, w, h]
    
    xmin = myVec(1);
    xmax = myVec(1) + myVec(3);
    ymin = myVec(2);
    ymax = myVec(2) + myVec(4);
    
    symbolIm = image(ymin:ymax, xmin:xmax);
    symbolProps = props(index,2:end);
    
    symbolProps = [symbolProps,(isRed)];
    
end

