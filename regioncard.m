function [ region ] = regioncard( file,thresh )
%REGIONCARD Summary of this function goes here
%   Detailed explanation goes here

i = myjpgload(file,0);
hist = dohist(i,1);
bin = binarisedlow(i,thresh);
imshow(bin);
morph = bin;
morph = bwmorph(bin,'open',1);
imshow(morph);
label = bwlabel(morph,4);
region = regionprops(label,['basic']);



end

