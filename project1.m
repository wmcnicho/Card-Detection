function [  ] = project1(  )

for i = 1:32
    image_name = strcat('train', num2str(i));
    file_path = strcat('./data1/', image_name, '.jpg');
    save_name = strcat('./test_data/', image_name, '_out.jpg');
    card = cardlocation(file_path, 0);
    imwrite(card, save_name);
    
end


end

