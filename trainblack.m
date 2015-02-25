function [] = trainblack()
%TRAINBLACK Used to train the black bayesian classifer model. Assumes that
%there is data prestored in properties/spade and properties/club
%according to the convention specified in readSymProps
%   The file reading was used to speed up the training since the symbol
%   dectection process can be time consuming

    symbolVecs = readSymProps('spade');
    symbolVecs = [symbolVecs;readSymProps('club')];
    
    blackDim = 3;
    blackNumClass = 2;
    symbolClasses = [ones(60,1);2 * ones(60,1)];
    
    symbol_n = size(symbolClasses,1);
    
    [blackMeans,blackInvcors,blackAprioris] = buildmodel(blackDim,symbolVecs,symbol_n,blackNumClass,symbolClasses);
    
    eval(['save  trained_models/symbols_black.mat blackNumClass blackMeans blackInvcors blackAprioris']);
    
end