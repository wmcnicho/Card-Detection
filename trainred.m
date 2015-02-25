function [] = trainred()

    symbolVecs = readSymProps('heart');
    symbolVecs = [symbolVecs;readSymProps('diamond')];
    
    sDim = 3;
    sNumClass = 2;
    symbolClasses = [ones(60,1);2 * ones(60,1)];
    
    symbol_n = size(symbolClasses,1);
    
    [sMeans,sInvcors,sAprioris] = buildmodel(sDim,symbolVecs,symbol_n,sNumClass,symbolClasses);
    
    eval(['save  trained_models/symbols_red.mat sNumClass sMeans sInvcors sAprioris']);
    
end