function [ string ] = recognize_card()
%RECOGNIZE_CARD Using the webcam built into the lab computers, take a
%picture of a playing card and report the value and suit symbol for that
%card

%take picture/ load picture
unix('mplayer tv:// -tv driver=v4l2:width=640:height=480:device=/dev/video0 -frames 5 -vo jpeg')
%load_file_path = '00000003.jpg';


load_file_path = 'data1/train1.jpg';
i = imread(load_file_path); 

%display boundry region of card
[regions, morphed_image] = cardlocation(load_file_path, 1);

%Output cleaned binary image
filter_image_by_regions(regions, bin_image, 2);

props_matrix = findSymbols(regions, morphed_image);

%Output classifcation
%isRed = findRedBlack(i,regions, props_matrix);

%[numberIm, symbolIm, numberProps, symbolProps] = extractSymbols(morphed_image, regions, props_matrix, isRed);


string = 'The ace of spades';
disp(string);
end

