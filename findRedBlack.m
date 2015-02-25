function [isRed] = findRedBlack(image,regions, props)
%FINDREDBLACK Given an image, its associated regions struct from
%regionprops, and its property matrix, this function will return 1 if the
%image is a red card and 0 if it is black card.
%   This funciton converts the image into a normalized RGB image and then
%   sums the total number of red pixels in a symbol subregion of the image.
%   If the ratio of red pixels to other pixels in the subimage is greater
%   than a threshold the image is assumed to be red. (default threshold is
%   .45 and was determined experimentally)
    
threshold = 0.45;
image = double(image);

%Get the total number of red, green, and blue pixel values
R = image(:,:,1)+1;
G = image(:,:,2)+1;
B = image(:,:,3)+1;
%Normalize the red, blue, and green value
NormalizedRed = R(:,:)./sqrt(R(:,:).^2+G(:,:).^2+B(:,:).^2);
NormalizedGreen = G(:,:)./sqrt(R(:,:).^2+G(:,:).^2+B(:,:).^2);
NormalizedBlue = B(:,:)./sqrt(R(:,:).^2+G(:,:).^2+B(:,:).^2);
%put the normalized rgb values into norm
norm(:,:,1) = NormalizedRed(:,:);
norm(:,:,2) = NormalizedGreen(:,:);
norm(:,:,3) = NormalizedBlue(:,:);

%extract a subimage corresponding to the smallest region (which should
%always be a symbol in our implementation)
[~,index] = min(props(:,2));
region_index = props(index,1);
myVec = int32(regions(region_index).BoundingBox);% [x, y, w, h]
xmin = myVec(1);
xmax = myVec(1) + myVec(3);
ymin = myVec(2);
ymax = myVec(2) + myVec(4);
subimage = norm(ymin:ymax, xmin:xmax,:);

%sum the total pixel values of the normalised sub_image
sub_R = sum(sum(subimage(:,:,1)));
sub_G = sum(sum(subimage(:,:,2)));
sub_B = sum(sum(subimage(:,:,3)));

%see if the ratio of red to total colors is above a threshold
isRed = ((sub_R/ (sub_R+sub_G+sub_B)) > threshold);

end