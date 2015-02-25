function [ string, predictedClasses ] = recognize_card(load_file_path)
%RECOGNIZE_CARD Given the filepath of an image display the card location
%box and filtered binary image. Then output the suit and value of the card
%to the console.
%   This is a very basic high level script that in turn runs all of the
%   functions built for an Introduction to Vision and Robotics course at
%   the University of Edinburgh. Webcam extensions are trival.

i = imread(load_file_path); 

%display boundry region of card
[regions, morphed_image] = cardlocation(load_file_path, 1);

%Create a property matrix from the image and display a cleaned binary image
props_matrix = findSymbols(regions, morphed_image, 2);

%Output classifcation
[string,predictedClasses] = classify_card(i, regions, props_matrix);
disp(string);
%disp(predictedClasses);

end

