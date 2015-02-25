function [  ] = project1( num )

for j = num:num
    
    image_name = strcat('train', num2str(j));
    load_file_path = strcat('./data1/', image_name, '.jpg');
    directory_path = strcat('./Stage2_symbolLoc/', num2str(j), '/');
    
    i = importdata(load_file_path,'jpg');

    disp('Starting adapt. Please wait.');
    ad = adapt(load_file_path);
    disp('Adapt finished.');

    morph = bwmorph(ad,'open',1);


    % Finds regions
    label = bwlabel(morph,4);
    regions = regionprops(label,['basic']);

    props = findSymbols(regions, morph);
    
    isRed = findRedBlack(i,regions, props);

    [numberIm, symbolIm, numberProps, symbolProps] = extractSymbols(morph, regions, props, isRed);
    
    
    predictedClasses = [];
    suit;
    
    if isRed
        
        load('trained_models/symbols_red.mat');
        
        for k = 1:size(symbolProps)
            
            predictedClasses = [predictedClasses;classify(symbolProps(k,2:end),redNumClass, redMeans, redInvcors, 3, redAprioris)];
            
        end
        
        finalClass = mode(predictedClasses)
        
    else
        
        load('trained_models/symbols_black.mat');
        
        for k = 1:size(symbolProps)
            
            predictedClasses = [predictedClasses;classify(symbolProps(k,2:end),blackNumClass, blackMeans, blackInvcors, 3, blackAprioris)];
            
        end
        
        
        
    end
    
    disp(predictedClasses);
    
%     full_path_num = strcat(directory_path, num2str(j), '_number.jpg');
%     imwrite(numberIm, full_path_num);
%     full_path_sym = strcat(directory_path, num2str(j), '_symbol.jpg');
%     imwrite(symbolIm, full_path_sym);
%     full_path_num_props = strcat(directory_path, num2str(j), '_number.txt');
%     FID = fopen(full_path_num_props,'w');
%     fprintf(FID, '%1.0f, %5.4f, %5.4f, %5.4f\n', transpose(numberProps));
%     fclose(FID);
%     full_path_symbol_props = strcat(directory_path, num2str(j), '_symbol.txt');
%     FID = fopen(full_path_symbol_props,'w');
%     fprintf(FID, '%1.0f, %5.4f, %5.4f, %5.4f\n', transpose(symbolProps));
%     fclose(FID);
    
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

