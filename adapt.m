function [outimage] = adapt(inimage)
%ADAPT Takes in an image loaded from file and applies an adaptive
%thresholding technique discussed in the labs to convert it into a binary image. The core code format was
%given as a script but has been adjusted slighty to be used as a function.
%
%The constant N was determined because the symbols in the training data
%all roughly fell within a 30x30 window.
%The constant C (Constant) was determined through testing but a threshold
%of 20 pixel difference between foreground and background seemed
%reasonable.

N=30;
Constant=20;

    inimage = imread(inimage,'jpg');
    inimage = myrgb2gray(inimage);
    [H,W] = size(inimage);
    outimage = zeros(H,W);
    N2 = floor(N/2);
    for i = 1+N2 : H-N2
      for j = 1+N2 : W-N2
        % extract subimage
        subimage = inimage(i-N2:i+N2,j-N2:j+N2);
        threshold = mean(mean(subimage)) - Constant;
        if inimage(i,j) < threshold
         outimage(i,j) = 1;
        else
         outimage(i,j) = 0;
        end
      end
    end

