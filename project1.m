function [  ] = project1( num )

for i = 1:32
    image_name = strcat('train', num2str(i));
    file_path = strcat('./data1/', image_name, '.jpg');
    save_name = strcat('./Stage2_symbolLoc/', image_name, '_out.jpg');

    I = imread(image_name);
    i = myjpgload(image_name,0);

    disp('Starting adapt. Please wait.');
    ad = adapt(image_name);
    disp('Adapt finished.');

    morph = bwmorph(ad,'open',16);


    % Finds regions
    label = bwlabel(morph,4);
    regions = regionprops(label,['basic']);

    imwrite(card, save_name);
    findSymbols(regions, morph);
end

%Load image
image_name = strcat('./data1/train', num2str(num), '.jpg');
% 
I = imread(image_name);
i = myjpgload(image_name,0);

disp('Starting adapt. Please wait.');
ad = adapt(image_name);
disp('Adapt finished.');

morph = bwmorph(ad,'open',16);
%imshow(morph);

%imshow(ad);


% Finds regions
label = bwlabel(morph,4);
regions = regionprops(label,['basic']);

% image_name = strcat('train', num2str(num), '_out');
% file_path = strcat('./Stage1_cardLoc/', image_name, '.jpg');
% img = myjpgload(file_path, 0);     
% label = bwlabel(img,4);
% regions = regionprops(label,['basic']);

findSymbols(regions, morph);



end

