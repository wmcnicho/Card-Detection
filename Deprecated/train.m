function [] = train()

    symbolVecs = readSymProps('spade');
    symbolVecs = [symbolVecs;readSymProps('heart')];
    symbolVecs = [symbolVecs;readSymProps('club')];
    symbolVecs = [symbolVecs;readSymProps('diamond')];
    
%     numberVecs = [];
%     for i = 2:9
%         numberVecs = [numberVecs;readNumProps(i)];
%     end
    
    sDim = 3;
%     nDim = 3;
    sNumClass = 4;
%     nNumClass = 8;
    load ./data1/GT_training.mat;
    classes = gt_training;
    symbolClasses = [ones(60,1);2 * ones(60,1);3 * ones(60,1);4 * ones(60,1)];
%     numberClasses = [1 * ones(8, 1);2 * ones(8, 1); 3 * ones(8, 1);4 * ones(8, 1);5 * ones(8, 1); 6 * ones(8, 1); 7 * ones(8, 1); 8 * ones(8, 1)];
    
    symbol_n = size(symbolClasses,1);
%     number_n = size(numberClasses,1);
    
    [sMeans,sInvcors,sAprioris] = buildmodel(sDim,symbolVecs,symbol_n,sNumClass,symbolClasses);
    
    eval(['save  trained_models/symbols.mat sNumClass sMeans sInvcors sAprioris']);
    
% 	[nMeans,nInvcors,nAprioris] = buildmodel(nDim,numberVecs,number_n,nNumClass+1,numberClasses);%to account for the off by one error
% 
%     eval(['save  trained_models/numbers.mat nNumClass nMeans nInvcors nAprioris']);
    
end