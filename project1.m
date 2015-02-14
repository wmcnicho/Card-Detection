function [  ] = project1(  )

% for i = 1:32
%     image_name = strcat('train', num2str(i));
%     file_path = strcat('./data1/', image_name, '.jpg');
%     save_name = strcat('./Stage1_cardLoc/', image_name, '_out.jpg');
%     card = cardlocation(file_path, 0);
%     imwrite(card, save_name);
%     
% end

% Load image
I = imread('./data1/train1.jpg');
i = myjpgload('./data1/train1.jpg',0);

disp('Starting adapt. Please wait.');
ad = adapt('./data1/train1.jpg');
disp('Adapt finished.');

morph = bwmorph(ad,'open',16);
%imshow(morph);

%imshow(ad);

% Finds regions
label = bwlabel(morph,4);
regions = regionprops(label,['basic']);

findSymbols(regions, morph);

end

