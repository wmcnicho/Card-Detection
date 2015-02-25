function [] = trainblack()

    symbolVecs = readSymProps('spade');
    symbolVecs = [symbolVecs;readSymProps('club')];
    
    sDim = 3;
    sNumClass = 2;
    symbolClasses = [ones(60,1);2 * ones(60,1)];
    
    symbol_n = size(symbolClasses,1);
    
    [sMeans,sInvcors,sAprioris] = buildmodel(sDim,symbolVecs,symbol_n,sNumClass,symbolClasses);
    
    eval(['save  trained_models/symbols_black.mat sNumClass sMeans sInvcors sAprioris']);
    
end