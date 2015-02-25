function [ mfinal ] = readSymProps( string )

    file = strcat('properties/',string,'/');
    basenum = 0;
    if (strcmp(string,'spade'))
        basenum = 1;
    end   
    if (strcmp(string,'heart'))
        basenum = 2;
    end  
    if (strcmp(string,'club'))
        basenum = 3;
    end  
    if (strcmp(string,'diamond'))
        basenum = 4;
    end  
    
    mfinal = [];
    
    for j = 0:7

        newfile = strcat(file,int2str(basenum+(j*4)),'_symbol.txt');
        
        m = dlmread(newfile);
        [rows,columns] = size(m);
        m1 = m(1:rows,2:columns-1);
        mfinal = [mfinal;m1];
        
    end

    % disp(mfinal);
    
end