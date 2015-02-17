function [ mfinal ] = readNumProps( i )

    file = strcat('properties/',int2str(i),'/');
    basenum = int8(((i-2)*4)+1);
    
    mfinal = [];
    
    for j = 0:3

        newfile = strcat(file,int2str(basenum+j),'_number.txt');
        
        m = dlmread(newfile);
        [rows,columns] = size(m);
        m1 = m(1:rows,2:columns);
        mfinal = [mfinal;m1];
        
    end

    % disp(mfinal);
    
end

