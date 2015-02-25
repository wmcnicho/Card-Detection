function [ card_string, predictedClasses ] = classify_card( i, morph, regions, props)

    isRed = findRedBlack(i,regions, props);

    [numberIm, symbolIm, numberProps, symbolProps] = extractSymbols(morph, regions, props, isRed);
    
    number = size(symbolProps,1) - 2;
    
    predictedClasses = [];
    suit = 'unset';
    
    if isRed
        
        load('trained_models/symbols_red.mat');
        
        for k = 1:size(symbolProps)
            
            predictedClasses = [predictedClasses;classify(symbolProps(k,2:end),redNumClass, redMeans, redInvcors, 3, redAprioris)];
            
        end
        
        finalClass = mode(predictedClasses); % Will select class 1 in case of tie
        
        if finalClass == 1
            
            suit = 'HEARTS';
            
        else
            
            suit = 'DIAMONDS';
            
        end
        
    else
        
        load('trained_models/symbols_black.mat');
        
        for k = 1:size(symbolProps)
            
            predictedClasses = [predictedClasses;classify(symbolProps(k,2:end),blackNumClass, blackMeans, blackInvcors, 3, blackAprioris)];
            
        end
        
        finalClass = mode(predictedClasses); % Will select class 1 in case of tie
        
        if finalClass == 1
            
            suit = 'SPADES';
            
        else
            
            suit = 'CLUBS';
            
        end
        
    end

    card_string = strcat(num2str(number),{' of '},suit);    
    
end

