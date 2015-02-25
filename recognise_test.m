%Script used to gather test results after training
for i = 1 : 32
    
    image_name = strcat('test', num2str(i));
    load_file_path = strcat('./data2/', image_name, '.jpg');
    directory_path = strcat('./Stage3_classifyCard/');

    [result, predictedClasses] = recognize_card(load_file_path);
    
    result = result{1};
    
    full_path = strcat(directory_path, num2str(i), '_result.txt');
    FID = fopen(full_path,'w');
    fprintf(FID, '%s\n', result);
    fprintf(FID, '%1.0f, ', predictedClasses);
    fclose(FID);
    
end