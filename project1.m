function [  ] = project1( num )

for j = 1:32
    image_name = strcat('train', num2str(j));
    load_file_path = strcat('./data1/', image_name, '.jpg');
    directory_path = strcat('./Stage2_symbolLoc/', num2str(j), '/');

    disp('Starting adapt. Please wait.');
    ad = adapt(load_file_path);
    disp('Adapt finished.');

    morph = bwmorph(ad,'open',16);


    % Finds regions
    label = bwlabel(morph,4);
    regions = regionprops(label,['basic']);

    props = findSymbols(regions, morph);

    [numberIm, symbolIm, numberProps, symbolProps] = extractSymbols(morph, regions, props);
    full_path_num = strcat(directory_path, num2str(j), '_number.jpg');
    imwrite(numberIm, full_path_num);
    full_path_sym = strcat(directory_path, num2str(j), '_symbol.jpg');
    imwrite(symbolIm, full_path_sym);
    full_path_num_props = strcat(directory_path, num2str(j), '_number.txt');
    FID = fopen(full_path_num_props,'w');
    fprintf(FID, '%1.0f, %5.4f, %5.4f, %5.4f\n', transpose(numberProps));
    fclose(FID);
    full_path_symbol_props = strcat(directory_path, num2str(j), '_symbol.txt');
    FID = fopen(full_path_symbol_props,'w');
    fprintf(FID, '%1.0f, %5.4f, %5.4f, %5.4f\n', transpose(symbolProps));
    fclose(FID);
    
end

% %Load image
% image_name = strcat('./data1/train', num2str(num), '.jpg');
% % 
% I = imread(image_name);
% i = myjpgload(image_name,0);
% 
% disp('Starting adapt. Please wait.');
% ad = adapt(image_name);
% disp('Adapt finished.');
% 
% morph = bwmorph(ad,'open',16);
% %imshow(morph);
% 
% %imshow(ad);
% 
% 
% % Finds regions
% label = bwlabel(morph,4);
% regions = regionprops(label,['basic']);
% 
% % image_name = strcat('train', num2str(num), '_out');
% % file_path = strcat('./Stage1_cardLoc/', image_name, '.jpg');
% % img = myjpgload(file_path, 0);     
% % label = bwlabel(img,4);
% % regions = regionprops(label,['basic']);
% 
% props = findSymbols(regions, morph);
% 
% [numberIm, symbolIm, numberProps, symbolProps] = extractSymbols(morph, regions, props);
% 
% figure(1);
% imshow(numberIm);
% figure(2);
% imshow(symbolIm);
% disp(numberProps);
% disp(symbolProps);

end

