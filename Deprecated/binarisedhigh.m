function [outImage] = binarisedhigh(inImage, threshold)

[m,n] = size(inImage);
outImage = zeros(m,n);

for i = 1:m
    for j = 1:n
        if inImage(i,j) < threshold
            outImage(i,j) = 0;
        else
            outImage(i,j) = 1;
        end
    end
end