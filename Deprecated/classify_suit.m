function [ suit ] = classify_card( i, morph, regions, props)

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

end

