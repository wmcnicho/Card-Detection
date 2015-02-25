function [] = trainred()

    symbolVecs = readSymProps('heart');
    symbolVecs = [symbolVecs;readSymProps('diamond')];
    
    redDim = 3;
    redNumClass = 2;
    symbolClasses = [ones(60,1);2 * ones(60,1)];
    
    symbol_n = size(symbolClasses,1);
    
    [redMeans,redInvcors,redAprioris] = buildmodel(redDim,symbolVecs,symbol_n,redNumClass,symbolClasses);
    
    eval(['save  trained_models/symbols_red.mat redNumClass redMeans redInvcors redAprioris']);
    
end